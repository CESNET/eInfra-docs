# Intel Numerical Libraries

Intel libraries for high performance in numerical computing.

## Intel Math Kernel Library

Intel Math Kernel Library (Intel MKL) is a library of math kernel subroutines, extensively threaded and optimized for maximum performance. Intel MKL unites and provides these basic components: BLAS, LAPACK, ScaLapack, PARDISO, FFT, VML, VSL, Data fitting, Feast Eigensolver, and many more.

```console
$ ml av mkl
------------------- /apps/modules/numlib -------------------
   imkl/2017.4.239-iimpi-2017c    imkl/2020.1.217-iimpi-2020a        imkl/2021.2.0-iimpi-2021a (D)
   imkl/2018.4.274-iimpi-2018a    imkl/2020.4.304-iimpi-2020b (L)    mkl/2020.4.304
   imkl/2019.1.144-iimpi-2019a    imkl/2020.4.304-iompi-2020b
```

!!! info
    `imkl` ... with intel toolchain. `mkl` with system toolchain.

For more information, see the [Intel MKL][1] section.

## Intel Integrated Performance Primitives

Intel Integrated Performance Primitives version 7.1.1, compiled for AVX is available via the `ipp` module. IPP is a library of highly optimized algorithmic building blocks for media and data applications. This includes signal, image, and frame processing algorithms, such as FFT, FIR, Convolution, Optical Flow, Hough transform, Sum, MinMax, and many more.

```console
$ ml av ipp
------------------- /apps/modules/perf -------------------
   ipp/2020.3.304
```

For more information, see the [Intel IPP][2] section.

## Intel Threading Building Blocks

Intel Threading Building Blocks (Intel TBB) is a library that supports scalable parallel programming using standard ISO C++ code. It does not require special languages or compilers. It is designed to promote scalable data parallel programming. Additionally, it fully supports nested parallelism, so you can build larger parallel components from smaller parallel components. To use the library, you specify tasks, not threads, and let the library map tasks onto threads in an efficient manner.

```console
$ ml av tbb
------------------- /apps/modules/lib -------------------
   tbb/2020.3-GCCcore-10.2.0

```

Read more at the [Intel TBB][3].

## Python Hooks for Intel Math Kernel Library

Python hooks for Intel(R) Math Kernel Library runtime control settings.

```console
$ ml av mkl-service
------------------- /apps/modules/data -------------------
   mkl-service/2.3.0-intel-2020b
```

Read more at the [hooks][a].

[1]: ../intel/intel-suite/intel-mkl.md
[2]: ../intel/intel-suite/intel-integrated-performance-primitives.md
[3]: ../intel/intel-suite/intel-tbb.md

[a]: https://github.com/IntelPython/mkl-service
