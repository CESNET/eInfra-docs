# Intel Compilers

## Introduction

 Intel compilers are compilers for Intel processor-based systems, available for Microsoft Windows, Linux, and macOS operating systems.

## Installed Versions

Intel compilers are available in multiple versions via the `intel` module. The compilers include the icc C and C++ compiler and the ifort Fortran 77/90/95 compiler.

```console
$ ml intel
$ icc -v
$ ifort -v
```

## AVX2 Vectorization

Intel compilers provide vectorization of the code via the AVX2 instructions and support threading parallelization via OpenMP.

For maximum performance on the Salomon cluster compute nodes, compile your programs using the AVX2 instructions, with reporting where the vectorization was used. We recommend the following compilation options for high performance:

```console
$ icc   -ipo -O3 -xCORE-AVX2 -qopt-report1 -qopt-report-phase=vec myprog.c mysubroutines.c -o myprog.x
$ ifort -ipo -O3 -xCORE-AVX2 -qopt-report1 -qopt-report-phase=vec myprog.f mysubroutines.f -o myprog.x
```

In this example, we compile the program enabling interprocedural optimizations between source files (`-ipo`), aggressive loop optimizations (`-O3`), and vectorization (`-xCORE-AVX2`).

The compiler recognizes the omp, simd, vector, and ivdep pragmas for OpenMP parallelization and AVX2 vectorization. Enable the OpenMP parallelization by the `-openmp` compiler switch.

```console
$ icc -ipo -O3 -xCORE-AVX2 -qopt-report1 -qopt-report-phase=vec -openmp myprog.c mysubroutines.c -o myprog.x
$ ifort -ipo -O3 -xCORE-AVX2 -qopt-report1 -qopt-report-phase=vec -openmp myprog.f mysubroutines.f -o myprog.x
```

Read more [here][a].

## Sandy Bridge/Ivy Bridge/Haswell Binary Compatibility

Salomon compute nodes are equipped with the Haswell-based architecture while the UV1 SMP compute server has Ivy Bridge CPUs, which are equivalent to Sandy Bridge (only smaller manufacturing technology). The new processors are backward compatible with the Sandy Bridge nodes, so all programs that run on the Sandy Bridge processors should also run on the new Haswell nodes. To get the optimal performance out of the Haswell processors, a program should make use of the special AVX2 instructions for this processor. This can be done by recompiling codes with the compiler flags designated to invoke these instructions. For the Intel compiler suite, there are two options:

* Using compiler flag (both for Fortran and C): `-xCORE-AVX2`. This will create a binary with AVX2 instructions, specifically for the Haswell processors. Note that the executable will not run on Sandy Bridge/Ivy Bridge nodes.
* Using compiler flags (both for Fortran and C): `-xAVX -axCORE-AVX2`. This   will generate multiple, feature specific auto-dispatch code paths for Intel® processors, if there is a performance benefit. Therefore, this binary will run both on Sandy Bridge/Ivy Bridge and Haswell processors. During runtime, it will be decided which path to follow, dependent on which processor you are running on. In general, this will result in larger binaries.

[a]: https://software.intel.com/en-us/intel-cplusplus-compiler-16.0-user-and-reference-guide
