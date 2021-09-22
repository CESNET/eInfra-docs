# MPI

## Setting Up MPI Environment

The Karolina cluster provides several implementations of the MPI library:

* OpenMPI
* Intel MPI (impi)
* MPICH

MPI libraries are activated via the environment modules.

Look up the modulefiles/mpi section in `ml av`:

```console
$ ml av
------------------------------------------------------- /apps/modules/mpi -------------------------------------------------------
   OpenMPI/3.1.4-GCC-6.3.0-2.27               OpenMPI/4.1.1-GCC-10.2.0
   OpenMPI/4.0.3-GCC-9.3.0                    OpenMPI/4.1.1-GCC-10.3.0                             (D)
   OpenMPI/4.0.5-GCC-10.2.0                   impi/2017.4.239-iccifort-2017.8.262-GCC-6.3.0-2.27
   OpenMPI/4.0.5-gcccuda-2020b                impi/2018.4.274-iccifort-2018.5.274-GCC-8.3.0-2.32
   OpenMPI/4.0.5-iccifort-2020.4.304          impi/2018.4.274-iccifort-2019.1.144-GCC-8.2.0-2.31.1
   OpenMPI/4.0.5-NVHPC-21.2-CUDA-11.2.2       impi/2019.9.304-iccifort-2020.1.217
   OpenMPI/4.0.5-NVHPC-21.2-CUDA-11.3.0       impi/2019.9.304-iccifort-2020.4.304
   OpenMPI/4.1.1-GCC-10.2.0-Java-1.8.0_221    impi/2021.2.0-intel-compilers-2021.2.0               (D)
   MPICH/3.3.2-GCC-10.2.0
```

There are default compilers associated with any particular MPI implementation. The defaults may be changed; the MPI libraries may be used in conjunction with any compiler.

Examples:

```console
$ ml gompi/2020b
```

In this example, we activate the OpenMPI with the GNU compilers (OpenMPI 4.0.5 and GCC 10.2.0). For more information about toolchains, see the [Environment and Modules][1] section.

To use OpenMPI with the Intel compiler suite, use:

```console
$ ml iompi/2020b
```

In this example, the OpenMPI 4.0.5 using the Intel compilers 2020.4.304 is activated. It uses the `iompi` toolchain.

## Compiling MPI Programs

After setting up your MPI environment, compile your program using one of the MPI wrappers:

For module `gompi/2020b`

```console
$ mpicc -v
Using built-in specs.
COLLECT_GCC=/apps/all/GCCcore/10.2.0/bin/gcc
COLLECT_LTO_WRAPPER=/apps/all/GCCcore/10.2.0/libexec/gcc/x86_64-pc-linux-gnu/10.2.0/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none
Target: x86_64-pc-linux-gnu
Configured with: ../configure --enable-languages=c,c++,fortran --without-cuda-driver --enable-offload-targets=nvptx-none --enable-lto --enable-checking=release --disable-multilib --enable-shared=yes --enable-static=yes --enable-threads=posix --enable-plugins --enable-gold=default --enable-ld --with-plugin-ld=ld.gold --prefix=/apps/all/GCCcore/10.2.0 --with-local-prefix=/apps/all/GCCcore/10.2.0 --enable-bootstrap --with-isl=/dev/shm/easybuild/build/GCCcore/10.2.0/system-system/gcc-10.2.0/stage2_stuff
Thread model: posix
Supported LTO compression algorithms: zlib
gcc version 10.2.0 (GCC)
$ mpif77 -v
Using built-in specs.
COLLECT_GCC=/apps/all/GCCcore/10.2.0/bin/gfortran
COLLECT_LTO_WRAPPER=/apps/all/GCCcore/10.2.0/libexec/gcc/x86_64-pc-linux-gnu/10.2.0/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none
Target: x86_64-pc-linux-gnu
Configured with: ../configure --enable-languages=c,c++,fortran --without-cuda-driver --enable-offload-targets=nvptx-none --enable-lto --enable-checking=release --disable-multilib --enable-shared=yes --enable-static=yes --enable-threads=posix --enable-plugins --enable-gold=default --enable-ld --with-plugin-ld=ld.gold --prefix=/apps/all/GCCcore/10.2.0 --with-local-prefix=/apps/all/GCCcore/10.2.0 --enable-bootstrap --with-isl=/dev/shm/easybuild/build/GCCcore/10.2.0/system-system/gcc-10.2.0/stage2_stuff
Thread model: posix
Supported LTO compression algorithms: zlib
gcc version 10.2.0 (GCC)
~$ mpif90 -v
Using built-in specs.
COLLECT_GCC=/apps/all/GCCcore/10.2.0/bin/gfortran
COLLECT_LTO_WRAPPER=/apps/all/GCCcore/10.2.0/libexec/gcc/x86_64-pc-linux-gnu/10.2.0/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none
Target: x86_64-pc-linux-gnu
Configured with: ../configure --enable-languages=c,c++,fortran --without-cuda-driver --enable-offload-targets=nvptx-none --enable-lto --enable-checking=release --disable-multilib --enable-shared=yes --enable-static=yes --enable-threads=posix --enable-plugins --enable-gold=default --enable-ld --with-plugin-ld=ld.gold --prefix=/apps/all/GCCcore/10.2.0 --with-local-prefix=/apps/all/GCCcore/10.2.0 --enable-bootstrap --with-isl=/dev/shm/easybuild/build/GCCcore/10.2.0/system-system/gcc-10.2.0/stage2_stuff
Thread model: posix
Supported LTO compression algorithms: zlib
gcc version 10.2.0 (GCC)
```

When using Intel MPI, use the following MPI wrappers:

For module `intel/2020b`

```console
$  mpiicc -v
mpiicc for the Intel(R) MPI Library 2019 Update 9 for Linux*
Copyright 2003-2020, Intel Corporation.
icc version 19.1.3.304 (gcc version 10.2.0 compatibility)
ld    /lib/../lib64/crt1.o /lib/../lib64/crti.o /apps/all/GCCcore/10.2.0/lib/gcc/x86_64-pc-linux-gnu/10.2.0/crtbegin.o --eh-frame-hdr --build-id -dynamic-linker /lib64/ld-linux-x86-64.so.2 -m elf_x86_64 -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib/release -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib -o a.out -L/apps/all/imkl/2020.4.304-iimpi-2020b/mkl/lib/intel64 -L/apps/all/imkl/2020.4.304-iimpi-2020b/lib/intel64 -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/libfabric/lib -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib/release -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib -L/apps/all/UCX/1.9.0-GCCcore-10.2.0/lib -L/apps/all/numactl/2.0.13-GCCcore-10.2.0/lib -L/apps/all/iccifort/2020.4.304/compilers_and_libraries_2020.4.304/linux/tbb/lib/intel64/gcc4.8 -L/apps/all/binutils/2.35-GCCcore-10.2.0/lib -L/apps/all/zlib/1.2.11-GCCcore-10.2.0/lib -L/apps/all/iccifort/2020.4.304/compilers_and_libraries_2020.4.304/linux/compiler/lib/intel64_lin -L/apps/all/UCX/1.9.0-GCCcore-10.2.0/lib/../lib64 -L/apps/all/UCX/1.9.0-GCCcore-10.2.0/lib/../lib64/ -L/apps/all/numactl/2.0.13-GCCcore-10.2.0/lib/../lib64 -L/apps/all/numactl/2.0.13-GCCcore-10.2.0/lib/../lib64/ -L/apps/all/binutils/2.35-GCCcore-10.2.0/lib/../lib64 -L/apps/all/binutils/2.35-GCCcore-10.2.0/lib/../lib64/ -L/apps/all/zlib/1.2.11-GCCcore-10.2.0/lib/../lib64 -L/apps/all/zlib/1.2.11-GCCcore-10.2.0/lib/../lib64/ -L/apps/all/GCCcore/10.2.0/lib/gcc/x86_64-pc-linux-gnu/10.2.0/ -L/apps/all/GCCcore/10.2.0/lib/gcc/x86_64-pc-linux-gnu/10.2.0/../../../../lib64 -L/apps/all/GCCcore/10.2.0/lib/gcc/x86_64-pc-linux-gnu/10.2.0/../../../../lib64/ -L/lib/../lib64 -L/lib/../lib64/ -L/usr/lib/../lib64 -L/usr/lib/../lib64/ -L/apps/all/imkl/2020.4.304-iimpi-2020b/mkl/lib/intel64/ -L/apps/all/imkl/2020.4.304-iimpi-2020b/lib/intel64/ -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/libfabric/lib/ -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib/release/ -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib/ -L/apps/all/UCX/1.9.0-GCCcore-10.2.0/lib64 -L/apps/all/UCX/1.9.0-GCCcore-10.2.0/lib/ -L/apps/all/numactl/2.0.13-GCCcore-10.2.0/lib64 -L/apps/all/numactl/2.0.13-GCCcore-10.2.0/lib/ -L/apps/all/iccifort/2020.4.304/compilers_and_libraries_2020.4.304/linux/tbb/lib/intel64/gcc4.8/ -L/apps/all/binutils/2.35-GCCcore-10.2.0/lib64 -L/apps/all/binutils/2.35-GCCcore-10.2.0/lib/ -L/apps/all/zlib/1.2.11-GCCcore-10.2.0/lib64 -L/apps/all/zlib/1.2.11-GCCcore-10.2.0/lib/ -L/apps/all/GCCcore/10.2.0/lib/gcc/x86_64-pc-linux-gnu/10.2.0/../../../ -L/lib64 -L/lib/ -L/usr/lib64 -L/usr/lib --enable-new-dtags -rpath /apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib/release -rpath /apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib -lmpifort -lmpi -ldl -lrt -lpthread -Bdynamic -Bstatic -limf -lsvml -lirng -Bdynamic -lm -Bstatic -lipgo -ldecimal --as-needed -Bdynamic -lcilkrts -lstdc++ --no-as-needed -lgcc -lgcc_s -Bstatic -lirc -lsvml -Bdynamic -lc -lgcc -lgcc_s -Bstatic -lirc_s -Bdynamic -ldl -lc /apps/all/GCCcore/10.2.0/lib/gcc/x86_64-pc-linux-gnu/10.2.0/crtend.o /lib/../lib64/crtn.o
$ mpiifort -v
mpiifort for the Intel(R) MPI Library 2019 Update 9 for Linux*
Copyright 2003-2020, Intel Corporation.
ifort version 19.1.3.304
ld    /lib/../lib64/crt1.o /lib/../lib64/crti.o /apps/all/GCCcore/10.2.0/lib/gcc/x86_64-pc-linux-gnu/10.2.0/crtbegin.o --eh-frame-hdr --build-id -dynamic-linker /lib64/ld-linux-x86-64.so.2 -m elf_x86_64 -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib/release -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib -o a.out /apps/all/iccifort/2020.4.304/compilers_and_libraries_2020.4.304/linux/compiler/lib/intel64_lin/for_main.o -L/apps/all/imkl/2020.4.304-iimpi-2020b/mkl/lib/intel64 -L/apps/all/imkl/2020.4.304-iimpi-2020b/lib/intel64 -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/libfabric/lib -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib/release -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib -L/apps/all/UCX/1.9.0-GCCcore-10.2.0/lib -L/apps/all/numactl/2.0.13-GCCcore-10.2.0/lib -L/apps/all/iccifort/2020.4.304/compilers_and_libraries_2020.4.304/linux/tbb/lib/intel64/gcc4.8 -L/apps/all/binutils/2.35-GCCcore-10.2.0/lib -L/apps/all/zlib/1.2.11-GCCcore-10.2.0/lib -L/apps/all/iccifort/2020.4.304/compilers_and_libraries_2020.4.304/linux/compiler/lib/intel64_lin -L/apps/all/UCX/1.9.0-GCCcore-10.2.0/lib/../lib64 -L/apps/all/UCX/1.9.0-GCCcore-10.2.0/lib/../lib64/ -L/apps/all/numactl/2.0.13-GCCcore-10.2.0/lib/../lib64 -L/apps/all/numactl/2.0.13-GCCcore-10.2.0/lib/../lib64/ -L/apps/all/binutils/2.35-GCCcore-10.2.0/lib/../lib64 -L/apps/all/binutils/2.35-GCCcore-10.2.0/lib/../lib64/ -L/apps/all/zlib/1.2.11-GCCcore-10.2.0/lib/../lib64 -L/apps/all/zlib/1.2.11-GCCcore-10.2.0/lib/../lib64/ -L/apps/all/GCCcore/10.2.0/lib/gcc/x86_64-pc-linux-gnu/10.2.0/ -L/apps/all/GCCcore/10.2.0/lib/gcc/x86_64-pc-linux-gnu/10.2.0/../../../../lib64 -L/apps/all/GCCcore/10.2.0/lib/gcc/x86_64-pc-linux-gnu/10.2.0/../../../../lib64/ -L/lib/../lib64 -L/lib/../lib64/ -L/usr/lib/../lib64 -L/usr/lib/../lib64/ -L/apps/all/imkl/2020.4.304-iimpi-2020b/mkl/lib/intel64/ -L/apps/all/imkl/2020.4.304-iimpi-2020b/lib/intel64/ -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/libfabric/lib/ -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib/release/ -L/apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib/ -L/apps/all/UCX/1.9.0-GCCcore-10.2.0/lib64 -L/apps/all/UCX/1.9.0-GCCcore-10.2.0/lib/ -L/apps/all/numactl/2.0.13-GCCcore-10.2.0/lib64 -L/apps/all/numactl/2.0.13-GCCcore-10.2.0/lib/ -L/apps/all/iccifort/2020.4.304/compilers_and_libraries_2020.4.304/linux/tbb/lib/intel64/gcc4.8/ -L/apps/all/binutils/2.35-GCCcore-10.2.0/lib64 -L/apps/all/binutils/2.35-GCCcore-10.2.0/lib/ -L/apps/all/zlib/1.2.11-GCCcore-10.2.0/lib64 -L/apps/all/zlib/1.2.11-GCCcore-10.2.0/lib/ -L/apps/all/GCCcore/10.2.0/lib/gcc/x86_64-pc-linux-gnu/10.2.0/../../../ -L/lib64 -L/lib/ -L/usr/lib64 -L/usr/lib --enable-new-dtags -rpath /apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib/release -rpath /apps/all/impi/2019.9.304-iccifort-2020.4.304/intel64/lib -lmpifort -lmpi -ldl -lrt -lpthread -Bdynamic -Bstatic -lifport -lifcoremt -limf -lsvml -Bdynamic -lm -Bstatic -lipgo -lirc -Bdynamic -lpthread -Bstatic -lsvml -Bdynamic -lc -lgcc -lgcc_s -Bstatic -lirc_s -Bdynamic -ldl -lc /apps/all/GCCcore/10.2.0/lib/gcc/x86_64-pc-linux-gnu/10.2.0/crtend.o /lib/../lib64/crtn.o
```

Wrappers `mpif90` and `mpif77` provided by Intel MPI are designed for GCC and GFortran. You might be able to compile MPI code by them even with Intel compilers, but you might run into problems.

Example program:

```cpp
// helloworld_mpi.c
#include <stdio.h>

#include<mpi.h>

int main(int argc, char **argv) {

int len;
int rank, size;
char node[MPI_MAX_PROCESSOR_NAME];

// Initiate MPI
MPI_Init(&argc, &argv);
MPI_Comm_rank(MPI_COMM_WORLD,&rank);
MPI_Comm_size(MPI_COMM_WORLD,&size);

// Get hostame and print
MPI_Get_processor_name(node,&len);
printf("Hello world! from rank %d of %d on host %sn",rank,size,node);

// Finalize and exit
MPI_Finalize();

return 0;
}
```

Compile the above example with:

```console
$ mpicc helloworld_mpi.c -o helloworld_mpi.x
```

## Running MPI Programs

The MPI program executable must be compatible with the loaded MPI module.
Always compile and execute using the very same MPI module.

It is strongly discouraged to mix MPI implementations. Linking an application with one MPI implementation and running `mpirun`/`mpiexec` from another implementation may result in unexpected errors.

The MPI program executable must be available within the same path on all nodes. This is automatically fulfilled on the /home and /scratch filesystem. You need to preload the executable if running on the local scratch /lscratch filesystem.

### Ways to Run MPI Programs

The optimal way to run an MPI program depends on its memory requirements, memory access pattern and communication pattern.

!!! note
    Consider these ways to run an MPI program:
    1. One MPI process per node, 128 threads per process
    2. Two MPI processes per node, 64 threads per process
    3. 128 MPI processes per node, 1 thread per process.

**One MPI** process per node, using 128 threads, is most useful for memory demanding applications that make good use of processor cache memory and are not memory-bound. This is also a preferred way for communication intensive applications as one process per node enjoys full bandwidth access to the network interface.

**Two MPI** processes per node, using 64 threads each, bound to processor socket is most useful for memory bandwidth-bound applications such as BLAS1 or FFT with scalable memory demand. However, note that the two processes will share access to the network interface. The 64 threads and socket binding should ensure maximum memory access bandwidth and minimize communication, migration, and NUMA effect overheads.

!!! note
    Important! Bind every OpenMP thread to a core!

In the previous two cases with one or two MPI processes per node, the operating system might still migrate OpenMP threads between cores. You want to avoid this by setting the `KMP_AFFINITY` or `GOMP_CPU_AFFINITY` environment variables.

**128 MPI** processes per node, using 1 thread each bound to a processor core is most suitable for highly scalable applications with low communication demand.

### Running OpenMPI

The [OpenMPI 4.1.1][a] is based on OpenMPI. Read more on [how to run OpenMPI][2].

[1]: ../../modules-matrix.md
[2]: running_openmpi.md

[a]: http://www.open-mpi.org/
