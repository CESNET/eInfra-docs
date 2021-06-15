# OpenFOAM

A free, open source CFD software package.

## Introduction

[OpenFOAM][a] is a free, open source CFD software package developed by [OpenCFD Ltd][b] at [ESI Group][c] and distributed by the [OpenFOAM Foundation][d]. It has a large user base across most areas of engineering and science from both commercial and academic organizations.

### Installed Version

Currently, several versions are available compiled by GCC/ICC compilers in single/double precision with several versions of OpenMPI.

The naming convention of the installed versions is:

`openfoam/<VERSION>-<COMPILER>-<openmpiVERSION>-<PRECISION>`

* `VERSION` - version of openfoam
* `COMPILER` - version of used compiler
* `openmpiVERSION` - version of used openmpi/impi
* `PRECISION` - DP/SP – double/single precision

Example of the available OpenFOAM modules syntax is `openfoam/2.2.1-icc-openmpi1.6.5-DP`

This means OpenFOAM version 2.2.1 compiled by the ICC compiler with openmpi1.6.5 in double precision.

### Available OpenFOAM Modules

To check the available modules, use:

```console
$ ml av
```

In /opt/modules/modulefiles/engineering, you can see the installed engineering softwares:

```console
    ------------------------------------ /opt/modules/modulefiles/engineering -------------------------------------------------------------
    ansys/14.5.x               matlab/R2013a-COM                                openfoam/2.2.1-icc-impi4.1.1.036-DP
    comsol/43b-COM             matlab/R2013a-EDU                                openfoam/2.2.1-icc-openmpi1.6.5-DP
    comsol/43b-EDU             openfoam/2.2.1-gcc481-openmpi1.6.5-DP            paraview/4.0.1-gcc481-bullxmpi1.2.4.1-osmesa10.0
    lsdyna/7.x.x               openfoam/2.2.1-gcc481-openmpi1.6.5-SP
```

For information on how to use modules, look [here][1].

## Getting Started

To create OpenFOAM environment on Anselm, use the commands:

```console
$ ml openfoam/2.2.1-icc-openmpi1.6.5-DP
$ source $FOAM_BASHRC
```

!!! note
    Load the correct module with your requirements “compiler - GCC/ICC, precision - DP/SP”.

Create a project directory within the $HOME/OpenFOAM directory named `<USER>-<OFversion>` and create a directory named `run` within it:

```console
$ mkdir -p $FOAM_RUN
```

The project directory is now available by typing:

```console
$ cd /home/<USER>/OpenFOAM/<USER>-<OFversion>/run
```

`<OFversion>` - for example `2.2.1`

or

```console
$ cd $FOAM_RUN
```

Copy the tutorial examples directory in the OpenFOAM distribution to the run directory:

```console
$ cp -r $FOAM_TUTORIALS $FOAM_RUN
```

Now you can run the first case, for example incompressible laminar flow in a cavity.

## Running Serial Applications

Create a test.sh Bash script:

```bash
#!/bin/bash

ml openfoam/2.2.1-icc-openmpi1.6.5-DP
source $FOAM_BASHRC

# source to run functions
. $WM_PROJECT_DIR/bin/tools/RunFunctions

cd $FOAM_RUN/tutorials/incompressible/icoFoam/cavity

runApplication blockMesh
runApplication icoFoam
```

Job submission (example for Anselm):

```console
$ qsub -A OPEN-0-0 -q qprod -l select=1:ncpus=16,walltime=03:00:00 test.sh
```

For information about job submission, look [here][2].

## Running Applications in Parallel

Run the second case, for example external incompressible turbulent flow - case - motorBike.

First we must run the serial application bockMesh and decomposePar for preparation of parallel computation.

!!! note
    Create a test.sh Bash scrip:

```bash
#!/bin/bash

ml openfoam/2.2.1-icc-openmpi1.6.5-DP
source $FOAM_BASHRC

# source to run functions
. $WM_PROJECT_DIR/bin/tools/RunFunctions

cd $FOAM_RUN/tutorials/incompressible/simpleFoam/motorBike

runApplication blockMesh
runApplication decomposePar
```

Job submission

```console
$ qsub -A OPEN-0-0 -q qprod -l select=1:ncpus=16,walltime=03:00:00 test.sh
```

This job creates a simple block mesh and domain decomposition. Check your decomposition and submit parallel computation:

!!! note
    Create a testParallel.pbs PBS script:

```bash
#!/bin/bash
#PBS -N motorBike
#PBS -l select=2:ncpus=16
#PBS -l walltime=01:00:00
#PBS -q qprod
#PBS -A OPEN-0-0

ml openfoam/2.2.1-icc-openmpi1.6.5-DP
source $FOAM_BASHRC

cd $FOAM_RUN/tutorials/incompressible/simpleFoam/motorBike

nproc = 32

mpirun -hostfile ${PBS_NODEFILE} -np $nproc snappyHexMesh -overwrite -parallel | tee snappyHexMesh.log

mpirun -hostfile ${PBS_NODEFILE} -np $nproc potentialFoam -noFunctionObject-writep -parallel | tee potentialFoam.log

mpirun -hostfile ${PBS_NODEFILE} -np $nproc simpleFoam -parallel | tee simpleFoam.log
```

`nproc` – the number of subdomains

Job submission

```console
$ qsub testParallel.pbs
```

## Compile Your Own Solver

Initialize the OpenFOAM environment before compiling your solver:

```console
$ ml openfoam/2.2.1-icc-openmpi1.6.5-DP
$ source $FOAM_BASHRC
$ cd $FOAM_RUN/
```

Create the applications/solvers directory in the user directory:

```console
$ mkdir -p applications/solvers
$ cd applications/solvers
```

Copy icoFoam solver’s source files:

```console
$ cp -r $FOAM_SOLVERS/incompressible/icoFoam/ My_icoFoam
$ cd My_icoFoam
```

Rename icoFoam.C to My_icoFOAM.C:

```console
$ mv icoFoam.C My_icoFoam.C
```

Edit the _files_ file in the _Make_ directory:

```bash
    icoFoam.C
    EXE = $(FOAM_APPBIN)/icoFoam
```

and change to:

```bash
    My_icoFoam.C
    EXE = $(FOAM_USER_APPBIN)/My_icoFoam
```

In the My_icoFoam directory, use the compilation command:

```console
$ wmake
```

[1]: ../../environment-and-modules.md
[2]: ../../general/job-submission-and-execution.md

[a]: http://www.openfoam.com/
[b]: http://www.openfoam.com/about
[c]: http://www.esi-group.com/
[d]: http://www.openfoam.org/
