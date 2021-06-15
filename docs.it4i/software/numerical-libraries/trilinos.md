# Trilinos

Packages for large-scale scientific and engineering problems. Provides MPI and hybrid parallelization.

## Introduction

Trilinos is a collection of software packages for the numerical solution of large-scale scientific and engineering problems. It is based on C++ and features modern object-oriented design. Both serial as well as parallel computations based on MPI and hybrid parallelization are supported within Trilinos packages.

## Installed Packages

Current Trilinos installation contains (among others) the following main packages:

* **Epetra** - core linear algebra package containing classes for manipulation with serial and distributed vectors, matrices, and graphs. Dense linear solvers are supported via interface to BLAS and LAPACK (Intel MKL). Its extension **EpetraExt** contains, for example, methods for matrix-matrix multiplication.
* **Tpetra** - next-generation linear algebra package. Supports 64-bit indexing and arbitrary data type using C++ templates.
* **Belos** - library of various iterative solvers (CG, block CG, GMRES, block GMRES, etc.).
* **Amesos** - interface to direct sparse solvers.
* **Anasazi** - framework for large-scale eigenvalue algorithms.
* **IFPACK** - distributed algebraic preconditioner (includes, for example, incomplete LU factorization).
* **Teuchos** - common tools packages. This package contains classes for memory management, output, performance monitoring, BLAS and LAPACK wrappers, etc.

For the full list of Trilinos packages, descriptions of their capabilities, and user manuals, see [the webpage][a].

## Installed Version

For the list of available versions, use the command:

```console
$ ml av trilinos
```

## Compiling Against Trilinos

First, load the appropriate module:

```console
$ ml trilinos
```

For the compilation of CMake-aware project, Trilinos provides the `FIND_PACKAGE( Trilinos )` capability, which makes it easy to build against Trilinos, including linking against the correct list of libraries.

For compiling using simple Makefiles, Trilinos provides `Makefile.export` system, which allows users to include important Trilinos variables directly into their Makefiles. This can be done simply by inserting the following line into the Makefile:

```cpp
include Makefile.export.Trilinos
```

or

```cpp
include Makefile.export.<package>
```

if you are interested only in a specific Trilinos package. This will give you access to the variables such as `Trilinos_CXX_COMPILER`, `Trilinos_INCLUDE_DIRS`, `Trilinos_LIBRARY_DIRS`, etc.

[a]: http://www.mcs.anl.gov/petsc/miscellaneous/external.html
