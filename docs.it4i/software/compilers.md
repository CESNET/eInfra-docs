# Compilers

## Available Compilers

There are several compilers for different programming languages available on the cluster:

* C/C++
* Fortran 77/90/95/HPF
* Unified Parallel C
* Java
* NVIDIA CUDA

The C/C++ and Fortran compilers are provided by:

Open source:

* GNU GCC
* Clang/LLVM

Commercial licenses:

* Intel
* PGI

## Intel Compilers

For information about the usage of Intel Compilers and other Intel products, read the [Intel Parallel studio][1] page.

## PGI Compilers

The Portland Group Cluster Development Kit (PGI CDK).

```console
$ ml PGI
$ pgcc -v
$ pgc++ -v
$ pgf77 -v
$ pgf90 -v
$ pgf95 -v
$ pghpf -v
```

The PGI CDK also incudes tools for debugging and profiling.

PGDBG OpenMP/MPI debugger and PGPROF OpenMP/MPI profiler are available

```console
$ ml PGI
$ ml Java
$ pgdbg &
$ pgprof &
```

For more information, see the [PGI page][a].

## GNU

For compatibility reasons, the original (old 4.8.5) versions of GNU compilers as part of the OS are still available. These are accessible in the search path by default.

It is strongly recommended to use the up to date version which comes with the module GCC:

```console
$ ml GCC
$ gcc -v
$ g++ -v
$ gfortran -v
```

With the module loaded, two environment variables are predefined. One for maximum optimizations on the cluster's architecture, and the other for debugging purposes:

```console
$ echo $OPTFLAGS
-O3 -march=native

$ echo $DEBUGFLAGS
-O0 -g
```

For more information about the possibilities of the compilers, see the man pages.

**Simple program to test the compiler**

```cpp
$ cat count.upc

/* hello.upc - a simple UPC example */
#include <upc.h>
#include <stdio.h>

int main() {
  if (MYTHREAD == 0) {
    printf("Welcome to GNU UPC!!!n");
  }
  upc_barrier;
  printf(" - Hello from thread %in", MYTHREAD);
  return 0;
}
```

To compile the example, use:

```console
$ gupc -o count.upc.x count.upc
```

To run the example with 5 threads, use:

```console
$ ./count.upc.x -fupc-threads-5
```

For more information, see the man pages.

## Java

For information on how to use Java (runtime and/or compiler), read the [Java page][2].

## NVIDIA CUDA

For information on how to work with NVIDIA CUDA, read the [NVIDIA CUDA page][3].

[1]: intel/intel-suite/intel-compilers.md
[2]: lang/java.md
[3]: nvidia-cuda.md

[a]: http://www.pgroup.com/products/pgicdk.htm
