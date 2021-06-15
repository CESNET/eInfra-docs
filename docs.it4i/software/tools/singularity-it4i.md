# Singularity on IT4Innovations

On our clusters, the Singularity images of main Linux distributions are prepared.

```console
   Salomon                 Barbora
      ├── CentOS              ├── CentOS
      │    ├── 6              │    ├── 6
      │    └── 7              │    └── 7
      ├── Debian              ├── Debian
      │    └── latest         │    └── latest
      ├── Fedora              ├── Fedora
      │    └── latest         │    └── latest
      └── Ubuntu              └── Ubuntu
           └── latest              └── latest
```

!!! info
    Current information about available Singularity images can be obtained by the `ml av` command. The images are listed in the `OS` section.

The bootstrap scripts, wrappers, features, etc. are located [here][a].

## IT4Innovations Singularity Wrappers

For better user experience with Singularity containers, we prepared several wrappers:

* image-exec
* image-mpi
* image-run
* image-shell
* image-update

Listed wrappers help you to use prepared Singularity images loaded as modules. You can easily load a Singularity image like any other module on the cluster by the `ml OS/version` command. After the module is loaded for the first time, the prepared image is copied into your home folder and is ready for use. When you load the module next time, the version of the image is checked and an image update (if exists) is offered. Then you can update your copy of the image by the `image-update` command.

!!! warning
    With an image update, all user changes to the image will be overridden.

The runscript inside the Singularity image can be run by the `image-run` command. This command automatically mounts the `/scratch` and `/apps` storage and invokes the image as writable, so user changes can be made.

Very similar to `image-run` is the `image-exec` command. The only difference is that `image-exec` runs a user-defined command instead of a runscript. In this case, the command to be run is specified as a parameter.

Using the interactive shell inside the Singularity container is very useful for development. In this interactive shell, you can make any changes to the image you want, but be aware that you can not use the `sudo` privileged commands directly on the cluster. To simply invoke interactive shell, use the `image-shell` command.

Another useful feature of the Singularity is the direct support of OpenMPI. For proper MPI function, you have to install the same version of OpenMPI inside the image as you use on the cluster. OpenMPI/3.1.4 is installed in prepared images. The MPI must be started outside the container. The easiest way to start the MPI is to use the `image-mpi` command.
This command has the same parameters as `mpirun`, so there is no difference between running normal MPI application and MPI application in a Singularity container.

## Examples

In the examples, we will use prepared Singularity images.

### Load Image

```console
$ ml CentOS/6
Your image of CentOS/6 is at location: /home/login/.singularity/images/CentOS-6_20180220133305.img
```

!!! tip
    After the module is loaded for the first time, the prepared image is copied into your home folder to the *.singularity/images* subfolder.

### Wrappers

**image-exec**

Executes the given command inside the Singularity image. The container is in this case started, then the command is executed and the container is stopped.

```console
$ ml CentOS/7
Your image of CentOS/7 is at location: /home/login/.singularity/images/CentOS-7_20180220104046.img
$ image-exec cat /etc/centos-release
CentOS Linux release 7.3.1708 (Core)
```

**image-mpi**

MPI wrapper - see more in the [Examples MPI][1] section.

**image-run**

This command runs the runscript inside the Singularity image. Note, that the prepared images do not contain a runscript.

**image-shell**

Invokes an interactive shell inside the Singularity image.

```console
$ ml CentOS/7
$ image-shell
Singularity: Invoking an interactive shell within container...

Singularity CentOS-7_20180220104046.img:~>
```

### Update Image

This command is for updating your local Singularity image copy. The local copy is overridden in this case.

```console
$ ml CentOS/6
New version of CentOS image was found. (New: CentOS-6_20180220092823.img Old: CentOS-6_20170220092823.img)
For updating image use: image-update
Your image of CentOS/6 is at location: /home/login/.singularity/images/CentOS-6_20170220092823.img
$ image-update
New version of CentOS image was found. (New: CentOS-6_20180220092823.img Old: CentOS-6_20170220092823.img)
Do you want to update local copy? (WARNING all user modification will be deleted) [y/N]: y
Updating image  CentOS-6_20180220092823.img
       2.71G 100%  199.49MB/s    0:00:12 (xfer#1, to-check=0/1)

sent 2.71G bytes  received 31 bytes  163.98M bytes/sec
total size is 2.71G  speedup is 1.00
New version is ready. (/home/login/.singularity/images/CentOS-6_20180220092823.img)
```

### MPI

In the following example, we are using a job submitted by the command: `qsub -A PROJECT -q qprod -l select=2:mpiprocs=24 -l walltime=00:30:00 -I`

!!! note
    We have seen no major performance impact for a job running in a Singularity container.

With Singularity, the MPI usage model is to call `mpirun` from outside the container, and reference the container from your `mpirun` command. Usage would look like this:

```console
$ mpirun -np 24 singularity exec container.img /path/to/contained_mpi_prog
```

By calling `mpirun` outside of the container, we solve several very complicated work-flow aspects. For example, if `mpirun` is called from within the container, it must have a method for spawning processes on remote nodes. Historically the SSH is used for this, which means that there must be an `sshd` running within the container on the remote nodes and this `sshd` process must not conflict with the `sshd` running on that host. It is also possible for the resource manager to launch the job and (in OpenMPI’s case) the Orted (Open RTE User-Level Daemon) processes on the remote system, but that then requires resource manager modification and container awareness.

In the end, we do not gain anything by calling `mpirun` from within the container except for increasing the complexity levels and possibly losing out on some added
performance benefits (e.g. if a container was not built with the proper OFED as the host).

#### MPI Inside Singularity Image

```console
$ ml CentOS/7
$ image-shell
Singularity: Invoking an interactive shell within container...

Singularity CentOS-7_20180220092823.img:~> mpirun hostname | wc -l
24
```

As you can see in this example, we allocated two nodes, but MPI can use only one node (24 processes) when used inside the Singularity image.

#### MPI Outside Singularity Image

```console
$ ml CentOS/7
Your image of CentOS/7 is at location: /home/login/.singularity/images/CentOS-7_20180220092823.img
$ image-mpi hostname | wc -l
48
```

In this case, the MPI wrapper behaves like the `mpirun` command. The `mpirun` command is called outside the container and the communication between nodes are propagated
into the container automatically.

## How to Use Own Image on Cluster?

* Prepare the image on your computer
* Transfer the images to your `/home` directory on the cluster (for example `.singularity/image`)

```console
local:$ scp container.img login@login4.salomon.it4i.cz:~/.singularity/image/container.img
```

* Load module Singularity (`ml Singularity`)
* Use your image

!!! note
    If you want to use the Singularity wrappers with your own images, load the `Singularity-wrappers/master` module and set the environment variable `IMAGE_PATH_LOCAL=/path/to/container.img`.

## How to Edit IT4Innovations Image?

* Transfer the image to your computer

```console
local:$ scp login@login4.salomon.it4i.cz:/home/login/.singularity/image/container.img container.img
```

* Modify the image
* Transfer the image from your computer to your `/home` directory on the cluster

```console
local:$ scp container.img login@login4.salomon.it4i.cz:/home/login/.singularity/image/container.img
```

* Load module Singularity (`ml Singularity`)
* Use your image

[1]: #mpi

[a]: https://code.it4i.cz/sccs/it4i-singularity
