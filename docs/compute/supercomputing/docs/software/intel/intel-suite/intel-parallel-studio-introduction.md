# Intel Parallel Studio

All clusters provide following elements of the Intel Parallel Studio XE

Intel Parallel Studio XE

* Intel Compilers
* Intel Debugger
* Intel MKL Library
* Intel Integrated Performance Primitives Library
* Intel Threading Building Blocks Library
* Intel Trace Analyzer and Collector
* Intel Advisor
* Intel Inspector

## Intel Compilers

The Intel compilers are available via the intel module. The compilers include the icc C and C++ compiler and the ifort Fortran 77/90/95 compiler.

```console
$ ml intel/2020b
$ icc -v
icc version 19.1.3.304 (gcc version 10.2.0 compatibility)
$ ifort -v
ifort version 19.1.3.304
```

Read more at the [Intel Compilers][1] page.

## Intel Math Kernel Library

Intel Math Kernel Library (Intel MKL) is a library of math kernel subroutines, extensively threaded and optimized for maximum performance. Intel MKL unites and provides these basic components: BLAS, LAPACK, ScaLapack, PARDISO, FFT, VML, VSL, Data fitting, Feast Eigensolver, and many more.

```console
$ ml imkl/2020.4.304-iimpi-2020b
```

Read more at the [Intel MKL][3] page.

## Intel Integrated Performance Primitives

Intel Integrated Performance Primitives, version 7.1.1, compiled for AVX is available via the `ipp` module. IPP is a library of highly optimized algorithmic building blocks for media and data applications. This includes signal, image, and frame processing algorithms, such as FFT, FIR, Convolution, Optical Flow, Hough transform, Sum, MinMax, and many more.

```console
$ ml ipp/2020.3.304
```

Read more at the [Intel IPP][4] page.

## Intel Threading Building Blocks

Intel Threading Building Blocks (Intel TBB) is a library that supports scalable parallel programming using standard ISO C++ code. It does not require special languages or compilers. It is designed to promote scalable data parallel programming. Additionally, it fully supports nested parallelism, so you can build larger parallel components from smaller parallel components. To use the library, you specify tasks, not threads, and let the library map tasks onto threads in an efficient manner.

```console
$ ml tbb/2020.3-GCCcore-10.2.0
```

Read more at the [Intel TBB][5] page.

[1]: intel-compilers.md
[2]: intel-debugger.md
[3]: intel-mkl.md
[4]: intel-integrated-performance-primitives.md
[5]: intel-tbb.md
