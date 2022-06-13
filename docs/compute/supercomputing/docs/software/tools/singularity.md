# Singularity Container

[Singularity][a] enables users to have full control of their environment. A non-privileged user can "swap out" the operating system on the host for one they control. So if the host system is running RHEL6 but your application runs in Ubuntu/RHEL7, you can create an Ubuntu/RHEL7 image, install your applications into that image, copy the image to another host, and run your application on that host in its native Ubuntu/RHEL7 environment.

Singularity also allows you to leverage the resources of whatever host you are on. This includes HPC interconnects, resource managers, file systems, GPUs and/or accelerators, etc. Singularity does this by enabling several key facets:

* Encapsulation of the environment
* Containers are image based
* No user contextual changes or root escalation allowed
* No root owned daemon processes

This documentation is for Singularity version 2.4 and newer.

<div align="center">
  <iframe width="250" height="50%" src="https://www.youtube.com/embed/m8llDjFuXlc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  <iframe width="250" height="50%" src="https://www.youtube.com/embed/SJHizTjwyFk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  <iframe width="250" height="50%" src="https://www.youtube.com/embed/97VuBVnfcwg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  <iframe width="250" height="50%" src="https://www.youtube.com/embed/wGJnkRmW5iU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## Using Docker Images

Singularity can import, bootstrap, and even run Docker images directly from [Docker Hub][b]. You can easily run an RHEL7 container like this:

```console
hra0031@login4:~$ cat /etc/redhat-release
CentOS release 6.9 (Final)
hra0031@login4:~$ ml Singularity
hra0031@login4:~$ singularity shell docker://centos:latest
Docker image path: index.docker.io/library/centos:latest
Cache folder set to /home/hra0031/.singularity/docker
[1/1] |===================================| 100.0%
Creating container runtime...
Singularity: Invoking an interactive shell within container...

Singularity centos:latest:~> cat /etc/redhat-release
CentOS Linux release 7.4.1708 (Core)
```

In this case, the image is downloaded from Docker Hub, extracted to a temporary directory, and Singularity interactive shell is invoked. This procedure can take a lot of time, especially with large images.

## Importing Docker Image

Singularity containers can be in three different formats:

* read-only **squashfs** (default) - best for production
* writable **ext3** (--writable option)
* writable **(ch)root directory** (--sandbox option) - best for development

Squashfs and (ch)root directory images can be built from Docker source directly on the cluster, no root privileges are needed. It is strongly recommended to create a native Singularity image to speed up the launch of the container.

```console
hra0031@login4:~$ ml Singularity
hra0031@login4:~$ singularity build ubuntu.img docker://ubuntu:latest
Docker image path: index.docker.io/library/ubuntu:latest
Cache folder set to /home/hra0031/.singularity/docker
Importing: base Singularity environment
Importing: /home/hra0031/.singularity/docker/sha256:50aff78429b146489e8a6cb9334d93a6d81d5de2edc4fbf5e2d4d9253625753e.tar.gz
Importing: /home/hra0031/.singularity/docker/sha256:f6d82e297bce031a3de1fa8c1587535e34579abce09a61e37f5a225a8667422f.tar.gz
Importing: /home/hra0031/.singularity/docker/sha256:275abb2c8a6f1ce8e67a388a11f3cc014e98b36ff993a6ed1cc7cd6ecb4dd61b.tar.gz
Importing: /home/hra0031/.singularity/docker/sha256:9f15a39356d6fc1df0a77012bf1aa2150b683e46be39d1c51bc7a320f913e322.tar.gz
Importing: /home/hra0031/.singularity/docker/sha256:fc0342a94c89e477c821328ccb542e6fb86ce4ef4ebbf1098e85669e051ef0dd.tar.gz
Importing: /home/hra0031/.singularity/metadata/sha256:c6a9ef4b9995d615851d7786fbc2fe72f72321bee1a87d66919b881a0336525a.tar.gz
WARNING: Building container as an unprivileged user. If you run this container as root
WARNING: it may be missing some functionality.
Building Singularity image...
Singularity container built: ubuntu.img
Cleaning up...
```

alternatively, you can create your own docker image and import it to singularity.
For example, we show how to create and run ubuntu docker image with gvim installed:

```console
your_local_machine $  docker pull ubuntu
your_local_machine $  docker run --rm -it ubuntu bash
# apt update
# apt install vim-gtk
your_local_machine $  docker ps -a
your_local_machine $  docker commit 837a575cf8dc
your_local_machine $  docker image  ls
your_local_machine $  docker tag 4dd97cefde62 ubuntu_gvim
your_local_machine $  docker save -o ubuntu_gvim.tar ubuntu_gvim
```

copy the `ubuntu_gvim.tar` archive to IT4I supercomputers, convert to Singularity image and run:

```console
$ ml Singularity
$ singularity build ubuntu_givm.img docker-archive://ubuntu_gvim.tar
$ singularity shell -B /usr/user/$ID ubuntu_gvim.img
```

Note the bind to `/usr/user/$ID` directory.

## Launching the Container

The interactive shell can be invoked by the `singularity shell` command. This is useful for development purposes. Use the `-w | --writable` option to make changes inside the container permanent.

```console
hra0031@login4:~$ singularity shell -w ubuntu.img
Singularity: Invoking an interactive shell within container...

Singularity ubuntu.img:~> cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.3 LTS"
```

A command can be run inside the container (without an interactive shell) by invoking the `singularity exec` command.

```
hra0031@login4:~$ singularity exec ubuntu.img cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.3 LTS"
```

A singularity image can contain a runscript. This script is executed inside the container after the `singularity run` command is used. The runscript is mostly used to run an application for which the container is built. In the following example, it is the `fortune | cowsay` command:

```
hra0031@login4:~$ singularity run ubuntu.img
 ___________________
< Are you a turtle? >
 -------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

## Accessing /HOME and /SCRATCH Within Container

A user home directory is mounted inside the container automatically. If you need access to the **/SCRATCH** storage for your computation, this must be mounted by the `-B | --bind` option.

!!!Warning
      The mounted folder has to exist inside the container or the container image has to be writable!

```console
hra0031@login4:~$ singularity shell -B /scratch -w ubuntu.img
Singularity: Invoking an interactive shell within container...

Singularity ubuntu.img:~> ls /scratch
ddn  sys  temp  work
```

A comprehensive documentation can be found at the [Singularity][c] website.

[a]: http://singularity.lbl.gov/
[b]: https://hub.docker.com/
[c]: http://singularity.lbl.gov/quickstart
