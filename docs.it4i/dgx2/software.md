# Software Deployment

Software deployment on DGX-2 is based on containers. NVIDIA provides a wide range of prepared Docker containers with a variety of different software. Users can easily download these containers and use them directly on the DGX-2.

The catalog of all container images can be found on [NVIDIA site][a]. Supported software includes:

* TensorFlow
* MATLAB
* GROMACS
* Theano
* Caffe2
* LAMMPS
* ParaView
* ...

## Running Containers on DGX-2

NVIDIA expects usage of Docker as a containerization tool, but Docker is not a suitable solution in a multiuser environment. For this reason, the [Singularity container][b] solution is used.

Singularity can be used similarly to Docker, just change the image URL address. For example, original command for Docker `docker run -it nvcr.io/nvidia/theano:18.08` should be changed to `singularity shell docker://nvcr.io/nvidia/theano:18.08`. More about Singularity [here][1].

For fast container deployment, all images are cached after first use in the *lscratch* directory. This behavior can be changed by the *SINGULARITY_CACHEDIR* environment variable, but the start time of the container will increase significantly.

```console
$ ml av Singularity

---------------------------- /apps/modules/tools ----------------------------
   Singularity/3.3.0
```

## MPI Modules

```console
$ ml av MPI

---------------------------- /apps/modules/mpi ----------------------------
   OpenMPI/2.1.5-GCC-6.3.0-2.27    OpenMPI/3.1.4-GCC-6.3.0-2.27    OpenMPI/4.0.0-GCC-6.3.0-2.27 (D)    impi/2017.4.239-iccifort-2017.7.259-GCC-6.3.0-2.27
```

## Compiler Modules

```console
$ ml av gcc

---------------------------- /apps/modules/compiler ----------------------------
   GCC/6.3.0-2.27    GCCcore/6.3.0    icc/2017.7.259-GCC-6.3.0-2.27    ifort/2017.7.259-GCC-6.3.0-2.27

```

[1]: ../software/tools/singularity.md
[a]: https://ngc.nvidia.com/catalog/landing
[b]: https://www.sylabs.io/
