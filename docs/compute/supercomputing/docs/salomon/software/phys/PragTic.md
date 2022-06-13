# PragTic

## Introduction

PragTic is a freeware tool for an automated fatigue damage calculation based on a FE-solution or done at an isolated point with no relation to FEA. More details of PragTic are available on its [website][a]. Here is the HPC version parallelized using MPI library.

## Modules

PragTic version 0.1 is available on Salomon via the PragTic module:

```sh
$ ml PragTic
```

The module sets up environment variables and loads some other modules, required for running PragTic simulations. This particular command loads the default module PragTic/0.1-GCC-5.3.0-2.25 and modules:

```console
GCCcore/5.3.0
binutils/2.25-GCCcore-5.3.0
GCC/5.3.0-2.25
MPICH/3.2-GCC-5.3.0-2.25.
```

## Running

Follow the next step to compute simulations sequentially:

```sh
pragtic DATABASE ANSET SET_OF_POINTS LOAD_REGIME METHOD RESULT_FILE
```

and this step to compute it in parallel:

```sh
mpirun -np NP pragtic DATABASE ANSET SET_OF_POINTS LOAD_REGIME METHOD RESULT_FILE
```

where

| Parameter       | Description                                  |
| --------------- | -------------------------------------------- |
| *NP*            | number of processes                          |
| *DATABASE*      | .fdb database specially prepared for PragTic |
| *ANSET*         | analyse setup name                           |
| *SET_OF_POINTS* | set of points name                           |
| *LOAD_REGIME*   | load regime name                             |
| *METHOD*        | method name                                  |
| *RESULT_FILE*   | file where results will be saved             |

## Results

After computation, the newly created result file *RESULT_FILE* in the current directory should contain results. More detailed result informations should be found in the *res.txt* file which is in every single randomly named folder created by PragTic in the current directory.

[a]: http://www.pragtic.com/
