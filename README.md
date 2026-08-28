Globus Personal Connect Container
=================================

A simple container for Globus Personal Connect (GPC).

Building
--------

In the `Dockerfile`, there are two separate options for downloading GPC.
Currently selected is the one for arm64 architectures (for running locally on a
Mac). If deploying to an x86 machine, you will need to select the alternative
link.

Setup
-----

In the `docker-compose.yml` file, there are a few things to note:

- You will want to mount in a directory for `config` that will
  be the GPC config directory used in the container. It is recommended
  that this is a bind-mount as you may wish to edit the config later.
- You will want to mount in your data directories that you wish to share
  with GPC.
- On first start, you will want to un-comment the line changing to `-setup`
  as the entrypoint. This will allow you to run the setup wizard with
  `docker compose run globus`.

Mounting Data
-------------

After first setup, `docker compose down`. You will then be able to edit the
configuration setup in the `config` directory. Of important note is
`config/lta/config-paths`, the set of paths that GPC will allow to be shared.
Initially `~` is mounted, which is the home directory inside the container
(probably containing nothing).

To add new directories, you should add new lines to this file. For example,
our default `docker-compose.yml` includes a mount for `/data`. This would
be expressed in this file as a new line that looks like:
```
/data,1,0
```
In this file, the first column is the path to the folder, the second column
is whether or not this is shareable (0 or 1), and the third whether it is 
readable (0) or readable and writable (1).
