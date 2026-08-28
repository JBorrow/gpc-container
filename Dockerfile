FROM ubuntu:24.04

RUN apt-get update
RUN apt-get install --yes --no-install-recommends ca-certificates curl tini
RUN apt-get install --yes --no-install-recommends python3-dev

# Download GCP server
RUN curl --output /tmp/gcp.tgz https://downloads.globus.org/globus-connect-personal/linux_aarch64/stable/globusconnectpersonal-aarch64-latest.tgz
#RUN curl --output /tmp/gcp.tgz https://downloads.globus.org/globus-connect-personal/linux/stable/globusconnectpersonal-latest.tgz 
RUN mkdir -p /opt/globus-connect-personal
RUN tar --extract --gzip --file /tmp/gcp.tgz --directory /opt/globus-connect-personal --strip-components=1

# Permissions; GCP cannot run as root
RUN groupadd --gid 1001 globus
RUN useradd --uid 1001 --gid 1001 --create-home --shell /bin/bash globus

ENV HOME=/home/globus
USER globus

ENTRYPOINT ["/usr/bin/tini", "--", "/opt/globus-connect-personal/globusconnectpersonal", "-start"]


