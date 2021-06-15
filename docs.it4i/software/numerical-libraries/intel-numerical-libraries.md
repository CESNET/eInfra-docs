# Intel Numerical Libraries

Intel libraries for high performance in numerical computing.

## Intel Math Kernel Library

Intel Math Kernel Library (Intel MKL) is a library of math kernel subroutines, extensively threaded and optimized for maximum performance. Intel MKL unites and provides these basic components: BLAS, LAPACK, ScaLapack, PARDISO, FFT, VML, VSL, Data fitting, Feast Eigensolver, and many more.

```console
$ ml mkl **or** ml imkl
```

For more information, see the [Intel MKL][1] section.

## Intel Integrated Performance Primitives

Intel Integrated Performance Primitives version 7.1.1, compiled for AVX is available via the `ipp` module. IPP is a library of highly optimized algorithmic building blocks for media and data applications. This includes signal, image, and frame processing algorithms, such as FFT, FIR, Convolution, Optical Flow, Hough transform, Sum, MinMax, and many more.

```console
$ ml ipp
```

For more information, see the [Intel IPP][2] section.

## Intel Threading Building Blocks

Intel Threading Building Blocks (Intel TBB) is a library that supports scalable parallel programming using standard ISO C++ code. It does not require special languages or compilers. It is designed to promote scalable data parallel programming. Additionally, it fully supports nested parallelism, so you can build larger parallel components from smaller parallel components. To use the library, you specify tasks, not threads, and let the library map tasks onto threads in an efficient manner.

```console
$ ml tbb
```

Read more at the [Intel TBB][3].

[1]: ../intel/intel-suite/intel-mkl.md
[2]: ../intel/intel-suite/intel-integrated-performance-primitives.md
[3]: ../intel/intel-suite/intel-tbb.md
