# Octave

## Introduction

GNU Octave is a high-level interpreted language, primarily intended for numerical computations. It provides capabilities for the numerical solution of linear and nonlinear problems, and for performing other numerical experiments. It also provides extensive graphics capabilities for data visualization and manipulation. Octave is normally used through its interactive command line interface, but it can also be used to write non-interactive programs. The Octave language is quite similar to Matlab so that most programs are easily portable. Read more [here][a].

For a list of available modules, type:

```console
$ ml av octave
```

## Modules and Execution

```console
$ ml Octave
```

Octave on clusters is linked to a highly optimized MKL mathematical library. This provides threaded parallelization to many Octave kernels, notably the linear algebra subroutines. Octave runs these heavy calculation kernels without any penalty. By default, Octave would parallelize to 24 threads on Salomon. You may control the threads by setting the `OMP_NUM_THREADS` environment variable.

To run Octave interactively, log in with the `ssh -X` parameter for X11 forwarding. Run Octave:

```console
$ octave
```

To run Octave in batch mode, write an Octave script, then write a bash jobscript and execute via the `qsub` command. By default, Octave will use 24 threads on Salomon when running MKL kernels.

```bash
#!/bin/bash

# change to local scratch directory
cd /lscratch/$PBS_JOBID || exit

# copy input file to scratch
cp $PBS_O_WORKDIR/octcode.m .

# load octave module
ml octave

# execute the calculation
octave -q --eval octcode > output.out

# copy output file to home
cp output.out $PBS_O_WORKDIR/.

#exit
exit
```

This script may be submitted directly to the PBS workload manager via the `qsub` command. The inputs are in the octcode.m file, outputs in the output.out file. See the single node jobscript example in the [Job execution section][1].

The Octave c compiler `mkoctfile` calls the GNU GCC 4.8.1 for compiling native C code. This is very useful for running native C subroutines in Octave environment.

```console
$ mkoctfile -v
```

Octave may use MPI for interprocess communication This functionality is currently not supported on the clusters. In case you require the Octave interface to MPI, contact [support][b].

## Xeon Phi Support

<!--- not tested -->
Octave may take advantage of the Xeon Phi accelerators. This will only work on the [Intel Xeon Phi][2] [accelerated nodes][3].

### Automatic Offload Support

Octave can accelerate BLAS type operations (in particular the Matrix Matrix multiplications] on the Xeon Phi accelerator, via [Automatic Offload using the MKL library][2].

Example

```octave
$ export OFFLOAD_REPORT=2
$ export MKL_MIC_ENABLE=1
$ ml octave
$ octave -q
    octave:1> A=rand(10000); B=rand(10000);
    octave:2> tic; C=A*B; toc
    [MKL] [MIC --] [AO Function]    DGEMM
    [MKL] [MIC --] [AO DGEMM Workdivision]    0.32 0.68
    [MKL] [MIC 00] [AO DGEMM CPU Time]    2.896003 seconds
    [MKL] [MIC 00] [AO DGEMM MIC Time]    1.967384 seconds
    [MKL] [MIC 00] [AO DGEMM CPU->MIC Data]    1347200000 bytes
    [MKL] [MIC 00] [AO DGEMM MIC->CPU Data]    2188800000 bytes
    Elapsed time is 2.93701 seconds.
```

In this example, the calculation was automatically divided among the CPU cores and the Xeon Phi MIC accelerator, reducing the total runtime from 6.3 secs down to 2.9 secs.

### Native Support

<!--- not tested -->
A version of [native][2] Octave is compiled for Xeon Phi accelerators. Some limitations apply for this version:

* Only command line support. GUI, graph plotting, etc. is not supported.
* Command history in interactive mode is not supported.

Octave is linked with parallel Intel MKL, so it is best suited for batch processing of tasks that utilize BLAS, LAPACK, and FFT operations. By default, the number of threads is set to 120, you can control this with the `OMP_NUM_THREADS` environment variable.

!!! note
    Calculations that do not employ parallelism (either by using parallel MKL e.g. via matrix operations, `fork()` function, [parallel package][c], or other mechanism) will actually run slower than on host CPU.

To use Octave on a node with Xeon Phi:

```console
$ ssh mic0                                               # login to the MIC card
$ source /apps/tools/octave/3.8.2-mic/bin/octave-env.sh  # set up environment variables
$ octave -q /apps/tools/octave/3.8.2-mic/example/test0.m # run an example
```

[1]: ../../general/job-submission-and-execution.md
[2]: ../intel/intel-xeon-phi-salomon.md
[3]: ../../salomon/compute-nodes.md

[a]: https://www.gnu.org/software/octave/
[b]: https://support.it4i.cz/rt/
[c]: https://octave.sourceforge.net/parallel/
