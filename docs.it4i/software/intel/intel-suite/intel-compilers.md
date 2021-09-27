# Intel Compilers

## Introduction

 Intel compilers are compilers for Intel processor-based systems, available for Microsoft Windows, Linux, and macOS operating systems.

## Installed Versions

Intel compilers are available in multiple versions via the `intel` module. The compilers include the icc C and C++ compiler and the ifort Fortran 77/90/95 compiler.

For the current list of installed versions, use:

```console
$ ml av intel/
```

```console
$ ml intel/2020b
$ icc -v
icc version 19.1.3.304 (gcc version 10.2.0 compatibility)
$ ifort -v
ifort version 19.1.3.304
```

## Instructions Vectorization

Intel compilers provide vectorization of the code via the AVX-2/AVX-512 instructions and support threading parallelization via OpenMP.

For maximum performance on the Barbora cluster compute nodes, compile your programs using the AVX-512 instructions, with reporting where the vectorization was used. We recommend the following compilation options for high performance.

!!! info
    Barbora non-accelerated nodes support AVX-512 instructions (cn1-cn192).

```console
$ icc -ipo -O3 -xCORE-AVX512 -qopt-report1 -qopt-report-phase=vec myprog.c mysubroutines.c -o myprog.x
```

In this example, we compile the program enabling interprocedural optimizations between source files (`-ipo`), aggressive loop optimizations (`-O3`), and vectorization (`-xCORE-AVX512`).

For maximum performance on the Barbora GPU nodes or Karolina cluster compute nodes, compile your programs using the AVX-2 instructions, with reporting where the vectorization was used. We recommend the following compilation options for high performance.

```console
$ icc -ipo -O3 -xCORE-AVX2 -qopt-report1 -qopt-report-phase=vec myprog.c mysubroutines.c -o myprog.x
```

!!! warn
    Karolina cluster has AMD cpu, use compiler options `-march=core-avx2`.

In this example, we compile the program enabling interprocedural optimizations between source files (`-ipo`), aggressive loop optimizations (`-O3`), and vectorization (`-xCORE-AVX2`).

The compiler recognizes the omp, simd, vector, and ivdep pragmas for OpenMP parallelization and AVX2 vectorization. Enable the OpenMP parallelization by the `-openmp` compiler switch.

```console
$ icc -ipo -O3 -xCORE-AVX2 -qopt-report1 -qopt-report-phase=vec -openmp myprog.c mysubroutines.c -o myprog.x
```

Read more [here][a].

[a]: https://software.intel.com/content/www/us/en/develop/documentation/cpp-compiler-developer-guide-and-reference/top.html
