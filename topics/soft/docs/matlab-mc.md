# MATLAB - MetaCentrum

## Matlab as Interactive Job

Interactive regime brings no significant speed-up comparing to running MATLAB locally on your machine unless parallelism is used.
Interactive regime is recommended for development of your code and its testing.

 **1. OnDemand Interface**

This is the easiest and most straighforward way to run MATLAB in graphical mode.
Follow the OnDemand tutorial.

**2. Interactive Job With Remote Desktop**

If you prefer working with command line or if you cannot use the web browser,
it is possible to run MATLAB as an interactive job and get the graphical output to your screen
by configuring remote desktop (recommended) or X-Window.
Follow the tutorials to learn how to setup the graphical connection.

After the graphical connection is set up, MATLAB can be run from the provided menu
or by typing the following code into a terminal window:

```console
$ module add matlab
$ matlab
```

**3. Interactive Job Without GUI**

It is possible to run MATLAB in the text regime only, when the graphical mode is not necessary
(you may even create figures, work with them, save them to a disk, though they are not visible).
The relevant keywords for this case are:

```console
$ matlab -nosplash -nodisplay -nodesktop
```

## Matlab as Batch Job

If you do not need the graphical environment, it is possible to run MATLAB in batch regime.
Create batch script `myjob.sh` with the following contents:

```console
#!/bin/bash

# set PATH to find MATLAB
module add matlab

# go to my working directory
cd $HOME/matlab/

# run MATLAB
matlab -nosplash -nodesktop -nodisplay -r "myFunction()"

# or in a different way:
#matlab -nosplash -nodesktop -nodisplay < myFunction.m > output.txt
```

Put all your MATLAB files (your `*.mat` and `*.m` files) to the `$HOME/matlab/` directory and submit this shell script:

```console
qsub -l select=1:ncpus=10:mem=1gb -l matlab=1 myjob.sh
```

Batch jobs are useful especially if you want to run more jobs in parallel
or if you do not want to block your local machine with running jobs.

**Turn Off Java Virtual Machine (JVM)**

MATLAB uses its own JVM for the desktop environment.
Many jobs can be sped-up by turning the JVM off (option `matlab -nojvm`).
Note that some internal functions and toolboxes (e.g. Distributed Computing Toolbox) need Java.

**Start MATLAB With Maple Symbolic Environment**

Since the Maple's symbolic environment is not fully compatible with the MATLAB's symbolic environment,
the MATLAB symbolic environment is used by default when starting the MATLAB within MetaCentrum environment.

In case the Maple symbolic environment is needed, it must be required explicitly:

```console
$ module add matlab
$ matlab-sym-maple       # the options of this command are the same as for the original 'matlab' command
                         # an alternative -- the 'matlab-sym-matlab' command -- explicitly requires the Matlab symbolic environment
```

### Distributed and Parallel Jobs in MATLAB

MATLAB now supports distributed and parallel jobs on multiprocessor machines
using the [Parallel Computing Toolbox](https://www.mathworks.com/products/parallel-computing.html) 
(the name of the licence is Distrib_Computing_Toolbox) and on clusters
using the [MATLAB Distributed Computing Server](https://www.mathworks.com/products/matlab-parallel-server.html)
(name of the licence is MATLAB_Distrib_Comp_Engine).

### Parallel MATLAB Computations in MetaCentrum

To prepare an environment for parallel computations, it is necessary to initialize a parallel pool of so-called workers
using the function parpool (called matlabpool in previous versions).
This standard initialization requires to specify an amount of workers to initialize;
moreover, thanks to shared filesystems, it may also result in a collision
when trying to initialize several pools simultaneously.

To make the initialization of parallel pool easier as well as to cope with the collision problems,
we have prepared a function MetaParPool:

```code
MetaParPool('open');        % initializes parallel pool (returns the number of initialized workers)
...
x = MetaParPool('size');    % allows to discover the size of parallel pool (returns the number of workers)
                            % may be called as MetaParPool('info'); as well
...
% a computation using parfor, spmd and other Matlab functions
...
MetaParPool('close');       % closing the parallel pool
```

#### Notes

* the function **automatically detects the number of cores assigned to a job** - the size of parallel pool is always automatically set based on resources assigned to a job
* it is necessary to ask for N computing cores on a single node (qsub -l select=1:ncpus=N ...)
* to make parallel computations using this function, there are **1 Matlab license and 1 Distributed Computing Toolbox license** and **N-1 MATLAB Distributed Computing Engine licenses** necessary (N denotes the number of requested cores)
* a reservation can be thus performed via -l matlab=1,matlab_Distrib_Computing_Toolbox=1
* **an example** of parallel computation using the MetaParPool function can be found in the /software/matlab-meta_ext/examples directory (file example-parallel.m shows the Matlab input file itself while the file run_parallel.sh shows an example startup script).

## CPU usage

Depending on the structure of script and functions being called,
MATLAB may use more CPUs than granted by the scheduler.
This may result in your job being killed by the scheduler.

Incorrect CPU usage can be prevented by resorting to one of the extremes:

#### 1. Force MATLAB to Work on One CPU Only by Using `--singleCompThread` Option

```console
qsub ... ncpus=1 ...
matlab ... -nojvm --singleCompThread ...
```

Obvious disadvantage is no speedup due to parallelization.
On poorly (or partly) parallelized codes, or if the 1-CPU-speed-only is not an issue, 
`--singleCompThread` is often a good choice.

#### 2. Reserve Whole Computational Node by `exclhost` Option

```console
qsub -l select=1:ncpus=1 -l place=exclhost
```

This requirement is done on the PBS level and essentially asks the PBS to grant whole computational node to your job only.
Being so, even if MATLAB code uses all' available CPUs, your job won't be killed.

On the other hand, `exclhost` is a large requirement.
If the grid is busy, jobs with exclhost may wait for a long time (even several days!) to run.

`exclhost` may be effective in case you have a number of MATLAB jobs which use parallelization only in some critical part.
You can group them into one PBS job and run them all at once in background, e.g.

```code
qsub ... place=exclhost ...
(cd Dataset1; matlab ... ) &
(cd Dataset2; matlab ... ) &
...
(cd DatasetN; matlab ... )
```

#### 3. Find Optimal Number of CPUs Using cgroups

If you need some level of parallelizations, but don't want to use `exclhost`,
you can limit number of available CPUs by using cgroups, which is Linux kernel tool. 
Only some machines are able to use cgroups.

```console
qsub -l select=1:ncpus=N:cgroups=cpuset ... # N is the the optimal number of CPUs
```

Finding the optimal number (N) of CPUs can be tricky and sometimes reduced to trial-and-error approach,
especially if your code calls external libraries.
You can use top command to watch the CPU load.

## Links

[Old MetaCentrum wiki documentation](https://wiki.metacentrum.cz/wiki/Matlab).
