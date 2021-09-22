# Octave

## Introduction

GNU Octave is a high-level interpreted language, primarily intended for numerical computations. It provides capabilities for the numerical solution of linear and nonlinear problems, and for performing other numerical experiments. It also provides extensive graphics capabilities for data visualization and manipulation. Octave is normally used through its interactive command line interface, but it can also be used to write non-interactive programs. The Octave language is quite similar to Matlab so that most programs are easily portable. Read more [here][a].

For a list of available modules, type:

```console
$ ml av octave
------------------------------- /apps/modules/math -------------------------------
   Octave/6.3.0-intel-2020b-without-X11
```

## Modules and Execution

To load the latest version of Octave load the module:

```console
$ ml Octave
```

Octave on clusters is linked to a highly optimized MKL mathematical library. This provides threaded parallelization to many Octave kernels, notably the linear algebra subroutines. Octave runs these heavy calculation kernels without any penalty. By default, Octave would parallelize to 128 threads on Karolina. You may control the threads by setting the `OMP_NUM_THREADS` environment variable.

To run Octave interactively, log in with the `ssh -X` parameter for X11 forwarding. Run Octave:

```console
$ octave
```

To run Octave in batch mode, write an Octave script, then write a bash jobscript and execute via the `qsub` command. By default, Octave will use 128 threads on Karolina when running MKL kernels.

```bash
#!/bin/bash

# change to local scratch directory
DIR=/scratch/project/PROJECT_ID/$PBS_JOBID
mkdir -p "$DIR"
cd "$DIR" || exit

# copy input file to scratch
cp $PBS_O_WORKDIR/octcode.m .

# load octave module
ml  Octave/6.3.0-intel-2020b-without-X11

# execute the calculation
octave -q --eval octcode > output.out

# copy output file to home
cp output.out $PBS_O_WORKDIR/.

#exit
exit
```

This script may be submitted directly to the PBS workload manager via the `qsub` command. The inputs are in the octcode.m file, outputs in the output.out file. See the single node jobscript example in the [Job execution section][1].

The Octave c compiler `mkoctfile` calls the GNU GCC 6.3.0 for compiling native C code. This is very useful for running native C subroutines in Octave environment.

```console
$ mkoctfile -v
mkoctfile, version 6.3.0
```

Octave may use MPI for interprocess communication This functionality is currently not supported on the clusters. In case you require the Octave interface to MPI, contact [support][b].

[1]: ../../general/job-submission-and-execution.md

[a]: https://www.gnu.org/software/octave/
[b]: https://support.it4i.cz/rt/
[c]: https://octave.sourceforge.net/parallel/
