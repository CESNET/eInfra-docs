# Capacity Computing

## Introduction

In many cases, it is useful to submit a huge (>100) number of computational jobs into the PBS queue system. A huge number of (small) jobs is one of the most effective ways to execute embarrassingly parallel calculations, achieving the best runtime, throughput, and computer utilization.

However, executing a huge number of jobs via the PBS queue may strain the system. This strain may result in slow response to commands, inefficient scheduling, and overall degradation of performance and user experience for all users. For this reason, the number of jobs is **limited to 100 jobs per user, 4,000 jobs and subjobs per user, 1,500 subjobs per job array**.

!!! note
    Follow one of the procedures below, in case you wish to schedule more than 100 jobs at a time.

* Use [Job arrays][1] when running a huge number of [multithread][2] (bound to one node only) or multinode (multithread across several nodes) jobs.
* Use [GNU parallel][3] when running single core jobs.
* Combine [GNU parallel with Job arrays][4] when running huge number of single core jobs.

## Policy

1. A user is allowed to submit at most 100 jobs. Each job may be [a job array][1].
1. The array size is at most 1,000 subjobs.

## Job Arrays

!!! note
    A huge number of jobs may easily be submitted and managed as a job array.

A job array is a compact representation of many jobs called subjobs. Subjobs share the same job script, and have the same values for all attributes and resources, with the following exceptions:

* each subjob has a unique index, $PBS_ARRAY_INDEX
* job Identifiers of subjobs only differ by their indices
* the state of subjobs can differ (R, Q, etc.)

All subjobs within a job array have the same scheduling priority and schedule as independent jobs. An entire job array is submitted through a single `qsub` command and may be managed by `qdel`, `qalter`, `qhold`, `qrls`, and `qsig` commands as a single job.

### Shared Jobscript

All subjobs in a job array use the very same single jobscript. Each subjob runs its own instance of the jobscript. The instances execute different work controlled by the `$PBS_ARRAY_INDEX` variable.

Example:

Assume we have 900 input files with the name of each beginning with "file" (e.g. file001, ..., file900). Assume we would like to use each of these input files with myprog.x program executable, each as a separate job.

First, we create a tasklist file (or subjobs list), listing all tasks (subjobs) - all input files in our example:

```console
$ find . -name 'file*' > tasklist
```

Then we create a jobscript:

#### Salomon

```bash
#!/bin/bash
#PBS -A PROJECT_ID
#PBS -q qprod
#PBS -l select=1:ncpus=24,walltime=02:00:00

# change to scratch directory
SCR=/scratch/work/user/$USER/$PBS_JOBID
mkdir -p $SCR ; cd $SCR || exit

# get individual tasks from tasklist with index from PBS JOB ARRAY
TASK=$(sed -n "${PBS_ARRAY_INDEX}p" $PBS_O_WORKDIR/tasklist)

# copy input file and executable to scratch
cp $PBS_O_WORKDIR/$TASK input ; cp $PBS_O_WORKDIR/myprog.x .

# execute the calculation
./myprog.x < input > output

# copy output file to submit directory
cp output $PBS_O_WORKDIR/$TASK.out
```

In this example, the submit directory contains the 900 input files, the myprog.x executable, and the jobscript file. As an input for each run, we take the filename of the input file from the created tasklist file. We copy the input file to the local scratch memory `/lscratch/$PBS_JOBID`, execute the myprog.x and copy the output file back to the submit directory, under the `$TASK.out` name. The myprog.x executable runs on one node only and must use threads to run in parallel. Be aware, that if the myprog.x **is not multithreaded**, then all the **jobs are run as single-thread programs in a sequential manner**. Due to the allocation of the whole node, the accounted time is equal to the usage of the whole node, while using only 1/16 of the node.

If running a huge number of parallel multicore (in means of multinode multithread, e.g. MPI enabled) jobs is needed, then a job array approach should be used. The main difference, as compared to the previous examples using one node, is that the local scratch memory should not be used (as it is not shared between nodes) and MPI or other techniques for parallel multinode processing has to be used properly.

### Submit the Job Array

To submit the job array, use the `qsub -J` command. The 900 jobs of the [example above][5] may be submitted like this:

#### Salomon

```console
$ qsub -N JOBNAME -J 1-900 jobscript
506493[].isrv5
```

In this example, we submit a job array of 900 subjobs. Each subjob will run on one full node and is assumed to take less than 2 hours (note the #PBS directives in the beginning of the jobscript file, do not forget to set your valid PROJECT_ID and desired queue).

Sometimes for testing purposes, you may need to submit a one-element only array. This is not allowed by PBSPro, but there is a workaround:

```console
$ qsub -N JOBNAME -J 9-10:2 jobscript
```

This will only choose the lower index (9 in this example) for submitting/running your job.

### Manage the Job Array

Check status of the job array using the `qstat` command.

```console
$ qstat -a 12345[].dm2

dm2:
                                                            Req'd Req'd   Elap
Job ID          Username Queue    Jobname    SessID NDS TSK Memory Time S Time
--------------- -------- --  |---|---| ------ --- --- ------ ----- - -----
12345[].dm2     user2    qprod    xx          13516   1 16    --  00:50 B 00:02
```

When the status is B, it means that some subjobs are already running.
Check the status of the first 100 subjobs using the `qstat` command.

```console
$ qstat -a 12345[1-100].dm2

dm2:
                                                            Req'd Req'd   Elap
Job ID          Username Queue    Jobname    SessID NDS TSK Memory Time S Time
--------------- -------- --  |---|---| ------ --- --- ------ ----- - -----
12345[1].dm2    user2    qprod    xx          13516   1 16    --  00:50 R 00:02
12345[2].dm2    user2    qprod    xx          13516   1 16    --  00:50 R 00:02
12345[3].dm2    user2    qprod    xx          13516   1 16    --  00:50 R 00:01
12345[4].dm2    user2    qprod    xx          13516   1 16    --  00:50 Q   --
     .             .        .      .             .    .   .     .    .   .    .
     ,             .        .      .             .    .   .     .    .   .    .
12345[100].dm2 user2    qprod    xx          13516   1 16    --  00:50 Q   --
```

Delete the entire job array. Running subjobs will be killed, queueing subjobs will be deleted.

```console
$ qdel 12345[].dm2
```

Deleting large job arrays may take a while.
Display status information for all user's jobs, job arrays, and subjobs.

```console
$ qstat -u $USER -t
```

Display status information for all user's subjobs.

```console
$ qstat -u $USER -tJ
```

For more information on job arrays, see the [PBSPro Users guide][6].

## GNU Parallel

!!! note
    Use GNU parallel to run many single core tasks on one node.

GNU parallel is a shell tool for executing jobs in parallel using one or more computers. A job can be a single command or a small script that has to be run for each of the lines in the input. GNU parallel is most useful when running single core jobs via the queue systems.

For more information and examples, see the parallel man page:

```console
$ module add parallel
$ man parallel
```

### GNU Parallel Jobscript

The GNU parallel shell executes multiple instances of the jobscript using all cores on the node. The instances execute different work, controlled by the `$PARALLEL_SEQ` variable.

Example:

Assume we have 101 input files with each name beginning with "file" (e.g. file001, ..., file101). Assume we would like to use each of these input files with the myprog.x program executable, each as a separate single core job. We call these single core jobs tasks.

First, we create a tasklist file listing all tasks - all input files in our example:

```console
$ find . -name 'file*' > tasklist
```

Then we create a jobscript:

```bash
#!/bin/bash
#PBS -A PROJECT_ID
#PBS -q qprod
#PBS -l select=1:ncpus=16,walltime=02:00:00

[ -z "$PARALLEL_SEQ" ] &&
{ module add parallel ; exec parallel -a $PBS_O_WORKDIR/tasklist $0 ; }

# change to local scratch directory
SCR=/lscratch/$PBS_JOBID/$PARALLEL_SEQ
mkdir -p $SCR ; cd $SCR || exit

# get individual task from tasklist
TASK=$1

# copy input file and executable to scratch
cp $PBS_O_WORKDIR/$TASK input

# execute the calculation
cat input > output

# copy output file to submit directory
cp output $PBS_O_WORKDIR/$TASK.out
```

In this example, tasks from the tasklist are executed via the GNU parallel. The jobscript executes multiple instances of itself in parallel, on all cores of the node. Once an instace of the jobscript is finished, a new instance starts until all entries in the tasklist are processed. Currently processed entries of the joblist may be retrieved via the `$1` variable. The `$TASK` variable expands to one of the input filenames from the tasklist. We copy the input file to the local scratch memory, execute myprog.x, and copy the output file back to the submit directory under the $TASK.out name.

### Submit the Job

To submit the job, use the `qsub` command. The 101 task job of the [example above][7] may be submitted as follows:

```console
$ qsub -N JOBNAME jobscript
12345.dm2
```

In this example, we submit a job of 101 tasks. 16 input files will be processed in parallel. The 101 tasks on 16 cores are assumed to complete in less than 2 hours.

!!! hint
    Use #PBS directives at the beginning of the jobscript file, do not forget to set your valid `PROJECT_ID` and the desired queue.

## Job Arrays and GNU Parallel

!!! note
    Combine the Job arrays and GNU parallel for the best throughput of single core jobs

While job arrays are able to utilize all available computational nodes, the GNU parallel can be used to efficiently run multiple single-core jobs on a single node. The two approaches may be combined to utilize all available (current and future) resources to execute single core jobs.

!!! note
    Every subjob in an array runs GNU parallel to utilize all cores on the node

### GNU Parallel, Shared jobscript

A combined approach, very similar to job arrays, can be taken. A job array is submitted to the queuing system. The subjobs run GNU parallel. The GNU parallel shell executes multiple instances of the jobscript using all of the cores on the node. The instances execute different work, controlled by the `$PBS_JOB_ARRAY` and the `$PARALLEL_SEQ` variables.

Example:

Assume we have 992 input files with each name beginning with "file" (e. g. file001, ..., file992). Assume we would like to use each of these input files with the myprog.x program executable, each as a separate single core job. We call these single core jobs tasks.

First, we create a tasklist file listing all tasks - all input files in our example:

```console
$ find . -name 'file*' > tasklist
```

Next we create a file, controlling how many tasks will be executed in one subjob:

```console
$ seq 32 > numtasks
```

Then we create a jobscript:

```bash
#!/bin/bash
#PBS -A PROJECT_ID
#PBS -q qprod
#PBS -l select=1:ncpus=16,walltime=02:00:00

[ -z "$PARALLEL_SEQ" ] &&
{ module add parallel ; exec parallel -a $PBS_O_WORKDIR/numtasks $0 ; }

# change to local scratch directory
SCR=/lscratch/$PBS_JOBID/$PARALLEL_SEQ
mkdir -p $SCR ; cd $SCR || exit

# get individual task from tasklist with index from PBS JOB ARRAY and index form Parallel
IDX=$(($PBS_ARRAY_INDEX + $PARALLEL_SEQ - 1))
TASK=$(sed -n "${IDX}p" $PBS_O_WORKDIR/tasklist)
[ -z "$TASK" ] && exit

# copy input file and executable to scratch
cp $PBS_O_WORKDIR/$TASK input

# execute the calculation
cat input > output

# copy output file to submit directory
cp output $PBS_O_WORKDIR/$TASK.out
```

In this example, the jobscript executes in multiple instances in parallel, on all cores of a computing node. The `$TASK` variable expands to one of the input filenames from the tasklist. We copy the input file to local scratch memory, execute myprog.x and copy the output file back to the submit directory, under the $TASK.out name.  The numtasks file controls how many tasks will be run per subjob. Once a task is finished, a new task starts, until the number of tasks in the numtasks file is reached.

!!! note
    Select the subjob walltime and the number of tasks per subjob carefully

When deciding these values, keep in mind the following guiding rules:

1. Let n=N/16. Inequality (n+1) \* T < W should hold. N is the number of tasks per subjob, T is the expected single task walltime and W is subjob walltime. A short subjob walltime improves scheduling and job throughput.
1. The number of tasks should be modulo 16.
1. These rules are valid only when all tasks have similar task walltimes T.

### Submit the Job Array (-J)

To submit the job array, use the `qsub -J` command. The 992 task jobs of the [example above][8] may be submitted like this:

```console
$ qsub -N JOBNAME -J 1-992:32 jobscript
12345[].dm2
```

In this example, we submit a job array of 31 subjobs. Note the -J 1-992:**32**, this must be the same as the number sent to numtasks file. Each subjob will run on one full node and process 16 input files in parallel, 32 in total per subjob. Every subjob is assumed to complete in less than 2 hours.

!!! hint
    Use #PBS directives at the beginning of the jobscript file, do not forget to set your valid PROJECT_ID and desired queue.

## Examples

Download the examples in [capacity.zip][9], illustrating the above listed ways to run a huge number of jobs. We recommend trying out the examples before using this for running production jobs.

Unzip the archive in an empty directory on cluster and follow the instructions in the README file-

```console
$ unzip capacity.zip
$ cat README
```

[1]: #job-arrays
[2]: #shared-jobscript-on-one-node
[3]: #gnu-parallel
[4]: #job-arrays-and-gnu-parallel
[5]: ##shared-jobscript
[6]: ../pbspro.md
[7]: #gnu-parallel-jobscript
[8]: #gnu-parallel-shared-jobscript
[9]: capacity.zip
