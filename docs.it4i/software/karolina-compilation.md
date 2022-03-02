# Karolina Compilation

Since Karolina's nodes are equipped with AMD Zen 2 and Zen 3 processors,
we recommend to follow these instructions in order to avoid degraded performance when compiling your code:

## 1. Select Compilers Flags

When compiling your code, it is important to select right compiler flags;
otherwise, the code will not be SIMD vectorized, resulting in severely degraded performance.
Depending on the compiler, you should use these flags:

!!! important
    `-Ofast` optimization may result in unpredictable behavior (e.g. a floating point overflow).

| Compiler | Module   | Command | Flags                   |
| -------- |----------| --------|-------------------------|
| AOCC     | ml AOCC  | clang   |-O3 -mavx2 -march=znver2 |
| INTEL    | ml intel | icc     |-O3 -xCORE-AVX2          |
| GCC      | ml GCC   | gcc     |-O3 -mavx2               |

The compiler flags and the resulting compiler performance may be verified with our benchmark,
see: [Lorenz Compiler performance benchmark][a].

## 2. Use BLAS Library

It is important to use the BLAS library that performs well on AMD processors.
We have measured the best performance with the MKL;
however, the MKL BLAS must be ‘tricked’ to believe it is working with an Intel CPU.

```code
ml mkl
ml KAROLINA/FAKEintel
```

Further, it is very important to pin the BLAS threads to the cores
and also to restrict BLAS threads to run on a single socket of an AMD processor.

```code
OMP_NUM_THREADS = 64
GOMP_CPU_AFFINITY=0:63:1
```

However, to get full performance, you have to execute two jobs on the two Karolina sockets at the time.
Other BLAS libraries may be used, however none performs as well as the MKL.

The choice of BLAS library and its performance may be verified with our benchmark,
see [Lorenz BLAS performance benchmark][a].

[a]: https://code.it4i.cz/jansik/lorenz/-/blob/main/README.md
