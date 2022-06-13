# PETSc

PETSc is a suite of building blocks for the scalable solution of scientific and engineering applications modeled by partial differential equations. It supports MPI, shared memory, and GPU through CUDA or OpenCL, as well as hybrid MPI-shared memory or MPI-GPU parallelism.

## Introduction

PETSc (Portable, Extensible Toolkit for Scientific Computation) is a suite of building blocks (data structures and routines) for the scalable solution of scientific and engineering applications modelled by partial differential equations. It allows thinking in terms of high-level objects (matrices) instead of low-level objects (raw arrays). Written in C language but can also be called from FORTRAN, C++, Python, and Java codes. It supports MPI, shared memory, and GPUs through CUDA or OpenCL, as well as hybrid MPI-shared memory or MPI-GPU parallelism.

## Resources

* [project webpage][a]
* [documentation][b]
  * [PETSc Users Manual (PDF)][c]
  * [index of all manual pages][d]
* PRACE Video Tutorial [part1][e], [part2][f], [part3][g], [part4][h], [part5][i]

## Modules

For the current list of installed versions, use:

```console
$ ml av petsc

```

## External Libraries

PETSc needs at least MPI, BLAS, and LAPACK. These dependencies are currently satisfied with Intel MPI and Intel MKL in `petsc` modules.

PETSc can be linked with a plethora of [external numerical libraries][k], extending PETSc functionality, e.g. direct linear system solvers, preconditioners, or partitioners. See below the list of libraries currently included in `petsc` modules.

All these libraries can also be used alone, without PETSc. Their static or shared program libraries are available in
`$PETSC_DIR/$PETSC_ARCH/lib` and header files in `$PETSC_DIR/$PETSC_ARCH/include`. `PETSC_DIR` and `PETSC_ARCH` are environment variables pointing to a specific PETSc instance based on the PETSc module loaded.

* dense linear algebra
  * [Elemental][l]
* sparse linear system solvers
  * [Intel MKL Pardiso][m]
  * [MUMPS][n]
  * [PaStiX][o]
  * [SuiteSparse][p]
  * [SuperLU][q]
  * [SuperLU_Dist][r]
* input/output
  * [ExodusII][s]
  * [HDF5][t]
  * [NetCDF][u]
* partitioning
  * [Chaco][v]
  * [METIS][w]
  * [ParMETIS][x]
  * [PT-Scotch][y]
* preconditioners & multigrid
  * [Hypre][z]
  * [SPAI - Sparse Approximate Inverse][aa]

[a]: http://www.mcs.anl.gov/petsc/
[b]: http://www.mcs.anl.gov/petsc/documentation/
[c]: http://www.mcs.anl.gov/petsc/petsc-current/docs/manual.pdf
[d]: http://www.mcs.anl.gov/petsc/petsc-current/docs/manualpages/singleindex.html
[e]: http://www.youtube.com/watch?v=asVaFg1NDqY
[f]: http://www.youtube.com/watch?v=ubp_cSibb9I
[g]: http://www.youtube.com/watch?v=vJAAAQv-aaw
[h]: http://www.youtube.com/watch?v=BKVlqWNh8jY
[i]: http://www.youtube.com/watch?v=iXkbLEBFjlM
[j]: https://www.mcs.anl.gov/petsc/miscellaneous/petscthreads.html
[k]: http://www.mcs.anl.gov/petsc/miscellaneous/external.html
[l]: http://libelemental.org/
[m]: https://software.intel.com/en-us/node/470282
[n]: http://mumps.enseeiht.fr/
[o]: http://pastix.gforge.inria.fr/
[p]: http://faculty.cse.tamu.edu/davis/suitesparse.html
[q]: http://crd.lbl.gov/~xiaoye/SuperLU/#superlu
[r]: http://crd.lbl.gov/~xiaoye/SuperLU/#superlu_dist
[s]: http://sourceforge.net/projects/exodusii/
[t]: http://www.hdfgroup.org/HDF5/
[u]: http://www.unidata.ucar.edu/software/netcdf/
[v]: http://www.cs.sandia.gov/CRF/chac.html
[w]: http://glaros.dtc.umn.edu/gkhome/metis/metis/overview
[x]: http://glaros.dtc.umn.edu/gkhome/metis/parmetis/overview
[y]: http://www.labri.fr/perso/pelegrin/scotch/
[z]: http://www.nersc.gov/users/software/programming-libraries/math-libraries/petsc/
[aa]: https://bitbucket.org/petsc/pkg-spai
