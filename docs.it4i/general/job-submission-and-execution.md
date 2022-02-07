# Job Submission and Execution

## Job Submission

When allocating computational resources for the job, specify:

1. a suitable queue for your job (the default is qprod)
1. the number of computational nodes required
1. the number of cores per node required
1. the maximum wall time allocated to your calculation, note that jobs exceeding the maximum wall time will be killed
1. your Project ID
1. a Jobscript or interactive switch

Submit the job using the `qsub` command:

```console
$ qsub -A Project_ID -q queue -l select=x:ncpus=y,walltime=[[hh:]mm:]ss[.ms] jobscript
```

The qsub command submits the job to the queue, i.e. the qsub command creates a request to the PBS Job manager for allocation of specified resources. The resources will be allocated when available, subject to the above described policies and constraints. **After the resources are allocated, the jobscript or interactive shell is executed on the first of the allocated nodes.**

### Job Submission Examples

!!! note
    Barbora: ncpus=36, or ncpus=24 for accelerate node

```console
$ qsub -A OPEN-0-0 -q qprod -l select=64:ncpus=24,walltime=03:00:00 ./myjob
```

In this example, we allocate 64 nodes, 24 cores per node, for 3 hours. We allocate these resources via the qprod queue, consumed resources will be accounted to the Project identified by Project ID OPEN-0-0. The jobscript 'myjob' will be executed on the first node in the allocation.

```console
$ qsub -q qexp -l select=4:ncpus=24 -I
```

In this example, we allocate 4 nodes, 24 cores per node, for 1 hour. We allocate these resources via the qexp queue. The resources will be available interactively.

```console
$ qsub -A OPEN-0-0 -q qnvidia -l select=10:ncpus=24 ./myjob
```

In this example, we allocate 10 NVIDIA accelerated nodes, 24 cores per node, for 24 hours. We allocate these resources via the qnvidia queue. The jobscript 'myjob' will be executed on the first node in the allocation.

```console
$ qsub -A OPEN-0-0 -q qfree -l select=10:ncpus=24 ./myjob
```

In this example, we allocate 10 nodes, 24 cores per node, for 12 hours. We allocate these resources via the qfree queue. It is not required that the project OPEN-0-0 has any available resources left. Consumed resources are still accounted for. The jobscript myjob will be executed on the first node in the allocation.

All qsub options may be [saved directly into the jobscript][1]. In such cases, it is not necessary to specify any options for qsub.

```console
$ qsub ./myjob
```

By default, the PBS batch system sends an email only when the job is aborted. Disabling mail events completely can be done as follows:

```console
$ qsub -m n
```

#### Dependency Job Submission

To submit dependent jobs in sequence, use the `depend` function of `qsub`.

First submit the first job in a standard manner:

```console
$ qsub -A OPEN-0-0 -q qprod -l select=64:ncpus=36,walltime=02:00:00 ./firstjob
123456[].isrv1
```

Then submit the second job using the `depend` function:

```console
qsub -W depend=afterok:123456 ./secondjob
```

Both jobs will be queued, but the second job won't start until the first job has finished successfully.

Below is the list of arguments that can be used with `-W depend=dependency:jobid`:

| Argument    | Description                                                     |
| ----------- | --------------------------------------------------------------- |
| after       | This job is scheduled after `jobid` begins execution.       |
| afterok     | This job is scheduled after `jobid` finishes successfully.  |
| afternotok  | This job is scheduled after `jobid` finishes unsucessfully. |
| afterany    | This job is scheduled after `jobid` finishes in any state.  |
| before      | This job must begin execution before `jobid` is scheduled.  |
| beforeok    | This job must finish successfully before `jobid` begins.        |
| beforenotok | This job must finish unsuccessfully before `jobid` begins.      |
| beforeany   | This job must finish in any state before `jobid` begins.        |

### Salomon - UV2000 SMP

!!! note
    13 NUMA nodes available on UV2000
    Per NUMA node allocation.
    Jobs are isolated by cpusets.

The UV2000 (node uv1) offers 3TB of RAM and 104 cores, distributed in 13 NUMA nodes. A NUMA node packs 8 cores and approx. 247GB RAM (with exception, node 11 has only 123GB RAM). In the PBS the UV2000 provides 13 chunks, a chunk per NUMA node (see [Resource allocation policy][2]). The jobs on UV2000 are isolated from each other by cpusets, so that a job by one user may not utilize CPU or memory allocated to a job by other user. Always, full chunks are allocated, a job may only use resources of the NUMA nodes allocated to itself.

```console
 $ qsub -A OPEN-0-0 -q qfat -l select=13 ./myjob
```

In this example, we allocate all 13 NUMA nodes (corresponds to 13 chunks), 104 cores of the SGI UV2000 node for 24 hours. The myjob jobscript will be executed on the uv1 node.

```console
$ qsub -A OPEN-0-0 -q qfat -l select=1:mem=2000GB ./myjob
```

In this example, we allocate 2000GB of memory on the UV2000 for 24 hours. By requesting 2000GB of memory, memory from 10 chunks and 8 cores is allocated. The myjob jobscript will be executed on the uv1 node.

```console
$ qsub -A OPEN-0-0 -q qfat -l select=1:mem=3099GB,walltime=48:00:00 ./myjob
```

In this example, we allocate 3099GB of memory on the UV2000 for 48 hours. By requesting 3099GB of memory, memory from all 13 chunks and 8 cores is allocated. The myjob jobscript will be executed on the uv1 node.

```console
$ qsub -A OPEN-0-0 -q qfat -l select=2:mem=1000GB,walltime=48:00:00 ./myjob
```

In this example, we allocate 2000GB of memory and 16 cores on the UV2000 for 48 hours. By requesting 1000GB of memory per chunk, 2000GB of memory and 16 cores are allocated. The myjob jobscript will be executed on the uv1 node.

### Useful Tricks

All qsub options may be [saved directly into the jobscript][1]. In such a case, no options to qsub are needed.

```console
$ qsub ./myjob
```

By default, the PBS batch system sends an email only when the job is aborted. Disabling mail events completely can be done like this:

```console
$ qsub -m n
```

## Advanced Job Placement

### Placement by Name

Specific nodes may be allocated via PBS:

```console
$ qsub -A OPEN-0-0 -q qprod -l select=1:ncpus=24:host=r24u35n680+1:ncpus=24:host=r24u36n681 -I
```

In this example, we allocate on Salomon nodes r24u35n680 and r24u36n681, all 24 cores per node, for 24 hours. Consumed resources will be accounted to the Project identified by Project ID OPEN-0-0. The resources will be available interactively.

### Salomon - Placement by Network Location

The network location of allocated nodes in the [InfiniBand network][3] influences efficiency of network communication between nodes of job. Nodes on the same InfiniBand switch communicate faster with lower latency than distant nodes. To improve communication efficiency of jobs, PBS scheduler on Salomon is configured to allocate nodes (from currently available resources), which are as close as possible in the network topology.

For communication intensive jobs, it is possible to set stricter requirement - to require nodes directly connected to the same InfiniBand switch or to require nodes located in the same dimension group of the InfiniBand network.

### Salomon - Placement by InfiniBand Switch

Nodes directly connected to the same InfiniBand switch can communicate most efficiently. Using the same switch prevents hops in the network and provides for unbiased, most efficient network communication. There are 9 nodes directly connected to every InfiniBand switch.

!!! note
    We recommend allocating compute nodes of a single switch when the best possible computational network performance is required to run job efficiently.

Nodes directly connected to the one InfiniBand switch can be allocated using node grouping on the PBS resource attribute `switch`.

In this example, we request all 9 nodes directly connected to the same switch using node grouping placement.

```console
$ qsub -A OPEN-0-0 -q qprod -l select=9:ncpus=24 -l place=group=switch ./myjob
```

### Salomon - Placement by Specific InfiniBand Switch

!!! note
    Not useful for ordinary computing, suitable for testing and management tasks.

Nodes directly connected to the specific InfiniBand switch can be selected using the PBS resource attribute `switch`.

In this example, we request all 9 nodes directly connected to the r4i1s0sw1 switch.

```console
$ qsub -A OPEN-0-0 -q qprod -l select=9:ncpus=24:switch=r4i1s0sw1 ./myjob
```

List of all InfiniBand switches:

```console
$ qmgr -c 'print node @a' | grep switch | awk '{print $6}' | sort -u
r1i0s0sw0
r1i0s0sw1
r1i1s0sw0
r1i1s0sw1
r1i2s0sw0
...
```

List of all nodes directly connected to the specific InfiniBand switch:

```console
$ qmgr -c 'p n @d' | grep 'switch = r36sw3' | awk '{print $3}' | sort
r36u31n964
r36u32n965
r36u33n966
r36u34n967
r36u35n968
r36u36n969
r37u32n970
r37u33n971
r37u34n972
```

### Salomon - Placement by Hypercube Dimension

Nodes located in the same dimension group may be allocated using node grouping on the PBS resource attribute `ehc\_[1-7]d`.

| Hypercube dimension | node_group_key | #nodes per group |
| ------------------- | -------------- | ---------------- |
| 1D                  | ehc_1d         | 18               |
| 2D                  | ehc_2d         | 36               |
| 3D                  | ehc_3d         | 72               |
| 4D                  | ehc_4d         | 144              |
| 5D                  | ehc_5d         | 144, 288         |
| 6D                  | ehc_6d         | 432, 576         |
| 7D                  | ehc_7d         | all              |

In this example, we allocate 16 nodes in the same [hypercube dimension][5] 1 group.

```console
$ qsub -A OPEN-0-0 -q qprod -l select=16:ncpus=24 -l place=group=ehc_1d -I
```

For better understanding:

List of all groups in dimension 1:

```console
$ qmgr -c 'p n @d' | grep ehc_1d | awk '{print $6}' | sort |uniq -c
     18 r1i0
     18 r1i1
     18 r1i2
     18 r1i3
...
```

List of all nodes in specific dimension 1 group:

```console
$ qmgr -c 'p n @d' | grep 'ehc_1d = r1i0' | awk '{print $3}' | sort
r1i0n0
r1i0n1
r1i0n10
r1i0n11
...
```

## Advanced Job Handling

### Selecting Turbo Boost Off

Intel Turbo Boost Technology is on by default. We strongly recommend keeping the default.

If necessary (such as in the case of benchmarking), you can disable the Turbo for all nodes of the job by using the PBS resource attribute cpu_turbo_boost:

```console
$ qsub -A OPEN-0-0 -q qprod -l select=4:ncpus=16 -l cpu_turbo_boost=0 -I
```

More information about the Intel Turbo Boost can be found in the TurboBoost section

### Advanced Examples

In the following example, we select an allocation for benchmarking a very special and demanding MPI program. We request Turbo off, and 2 full chassis of compute nodes (nodes sharing the same IB switches) for 30 minutes:

```console
$ qsub -A OPEN-0-0 -q qprod
    -l select=18:ncpus=16:ibswitch=isw10:mpiprocs=1:ompthreads=16+18:ncpus=16:ibswitch=isw20:mpiprocs=16:ompthreads=1
    -l cpu_turbo_boost=0,walltime=00:30:00
    -N Benchmark ./mybenchmark
```

The MPI processes will be distributed differently on the nodes connected to the two switches. On the isw10 nodes, we will run 1 MPI process per node with 16 threads per process, on isw20 nodes we will run 16 plain MPI processes.

Although this example is somewhat artificial, it demonstrates the flexibility of the qsub command options.

## Job Management

!!! note
    Check the status of your jobs using the `qstat` and `check-pbs-jobs` commands

```console
$ qstat -a
$ qstat -a -u username
$ qstat -an -u username
$ qstat -f 12345.srv11
```

Example:

```console
$ qstat -a

srv11:
                                                            Req'd Req'd   Elap
Job ID          Username Queue    Jobname    SessID NDS TSK Memory Time S Time
--------------- -------- --  |---|---| ------ --- --- ------ ----- - -----
16287.srv11     user1    qlong    job1         6183   4 64    --  144:0 R 38:25
16468.srv11     user1    qlong    job2         8060   4 64    --  144:0 R 17:44
16547.srv11     user2    qprod    job3x       13516   2 32    --  48:00 R 00:58
```

In this example user1 and user2 are running jobs named job1, job2, and job3x. The jobs job1 and job2 are using 4 nodes, 16 cores per node each. job1 has already run for 38 hours and 25 minutes, and job2 for 17 hours 44 minutes. job1 has already consumed `64 x 38.41 = 2458.6` core hours. job3x has already consumed `0.96 x 32 = 30.93` core hours. These consumed core hours will be accounted for on the respective project accounts, regardless of whether the allocated cores were actually used for computations.

The following commands allow you to check the status of your jobs using the check-pbs-jobs command, check for the presence of user's PBS jobs' processes on execution hosts, display load and processes, display job standard and error output, and continuously display (tail -f) job standard or error output.

```console
$ check-pbs-jobs --check-all
$ check-pbs-jobs --print-load --print-processes
$ check-pbs-jobs --print-job-out --print-job-err
$ check-pbs-jobs --jobid JOBID --check-all --print-all
$ check-pbs-jobs --jobid JOBID --tailf-job-out
```

Examples:

```console
$ check-pbs-jobs --check-all
JOB 35141.dm2, session_id 71995, user user2, nodes cn164,cn165
Check session id: OK
Check processes
cn164: OK
cn165: No process
```

In this example we see that job 35141.dm2 is not currently running any processes on the allocated node cn165, which may indicate an execution error:

```console
$ check-pbs-jobs --print-load --print-processes
JOB 35141.dm2, session_id 71995, user user2, nodes cn164,cn165
Print load
cn164: LOAD: 16.01, 16.01, 16.00
cn165: LOAD:  0.01,  0.00,  0.01
Print processes
       %CPU CMD
cn164:  0.0 -bash
cn164:  0.0 /bin/bash /var/spool/PBS/mom_priv/jobs/35141.dm2.SC
cn164: 99.7 run-task
...
```

In this example, we see that job 35141.dm2 is currently running a process run-task on node cn164, using one thread only, while node cn165 is empty, which may indicate an execution error.

```console
$ check-pbs-jobs --jobid 35141.dm2 --print-job-out
JOB 35141.dm2, session_id 71995, user user2, nodes cn164,cn165
Print job standard output:
======================== Job start  ==========================
Started at    : Fri Aug 30 02:47:53 CEST 2013
Script name   : script
Run loop 1
Run loop 2
Run loop 3
```

In this example, we see the actual output (some iteration loops) of the job 35141.dm2.

!!! note
    Manage your queued or running jobs, using the `qhold`, `qrls`, `qdel`, `qsig`, or `qalter` commands

You may release your allocation at any time, using the `qdel` command

```console
$ qdel 12345.srv11
```

You may kill a running job by force, using the `qsig` command

```console
$ qsig -s 9 12345.srv11
```

Learn more by reading the PBS man page

```console
$ man pbs_professional
```

## Job Execution

### Jobscript

!!! note
    Prepare the jobscript to run batch jobs in the PBS queue system

The Jobscript is a user made script controlling a sequence of commands for executing the calculation. It is often written in bash, though other scripts may be used as well. The jobscript is supplied to the PBS `qsub` command as an argument, and is executed by the PBS Professional workload manager.

!!! note
    The jobscript or interactive shell is executed on first of the allocated nodes.

```console
$ qsub -q qexp -l select=4:ncpus=16 -N Name0 ./myjob
$ qstat -n -u username

srv11:
                                                            Req'd Req'd   Elap
Job ID          Username Queue    Jobname    SessID NDS TSK Memory Time S Time
--------------- -------- --  |---|---| ------ --- --- ------ ----- - -----
15209.srv11     username qexp     Name0        5530   4 64    --  01:00 R 00:00
   cn17/0*16+cn108/0*16+cn109/0*16+cn110/0*16
```

In this example, the nodes cn17, cn108, cn109, and cn110 were allocated for 1 hour via the qexp queue. The myjob jobscript will be executed on the node cn17, while the nodes cn108, cn109, and cn110 are available for use as well.

The jobscript or interactive shell is by default executed in the home directory:

```console
$ qsub -q qexp -l select=4:ncpus=16 -I
qsub: waiting for job 15210.srv11 to start
qsub: job 15210.srv11 ready

$ pwd
/home/username
```

In this example, 4 nodes were allocated interactively for 1 hour via the qexp queue. The interactive shell is executed in the home directory.

!!! note
    All nodes within the allocation may be accessed via SSH. Unallocated nodes are not accessible to the user.

The allocated nodes are accessible via SSH from login nodes. The nodes may access each other via SSH as well.

Calculations on allocated nodes may be executed remotely via the MPI, SSH, pdsh, or clush. You may find out which nodes belong to the allocation by reading the $PBS_NODEFILE file

```console
qsub -q qexp -l select=4:ncpus=16 -I
qsub: waiting for job 15210.srv11 to start
qsub: job 15210.srv11 ready

$ pwd
/home/username

$ sort -u $PBS_NODEFILE
cn17.bullx
cn108.bullx
cn109.bullx
cn110.bullx

$ pdsh -w cn17,cn[108-110] hostname
cn17: cn17
cn108: cn108
cn109: cn109
cn110: cn110
```

In this example, the hostname program is executed via pdsh from the interactive shell. The execution runs on all four allocated nodes. The same result would be achieved if the pdsh were called from any of the allocated nodes or from the login nodes.

### Example Jobscript for MPI Calculation

!!! note
    Production jobs must use the /scratch directory for I/O

The recommended way to run production jobs is to change to the /scratch directory early in the jobscript, copy all inputs to /scratch, execute the calculations, and copy outputs to the home directory.

```bash
#!/bin/bash

# change to scratch directory, exit on failure
SCRDIR=/scratch/$USER/myjob
mkdir -p $SCRDIR
cd $SCRDIR || exit

# copy input file to scratch
cp $PBS_O_WORKDIR/input .
cp $PBS_O_WORKDIR/mympiprog.x .

# load the MPI module
# (Always specify the module's name and version in your script;
# for the reason, see https://docs.it4i.cz/software/modules/lmod/#loading-modules.)
ml OpenMPI/4.1.1-GCC-10.2.0-Java-1.8.0_221

# execute the calculation
mpirun -pernode ./mympiprog.x

# copy output file to home
cp output $PBS_O_WORKDIR/.

#exit
exit
```

In this example, a directory in /home holds the input file input and the mympiprog.x executable. We create the myjob directory on the /scratch filesystem, copy input and executable files from the /home directory where the qsub was invoked ($PBS_O_WORKDIR) to /scratch, execute the MPI program mympiprog.x and copy the output file back to the /home directory. mympiprog.x is executed as one process per node, on all allocated nodes.

!!! note
    Consider preloading inputs and executables onto [shared scratch][6] memory before the calculation starts.

In some cases, it may be impractical to copy the inputs to the scratch memory and the outputs to the home directory. This is especially true when very large input and output files are expected, or when the files should be reused by a subsequent calculation. In such cases, it is the users' responsibility to preload the input files on shared /scratch memory before the job submission, and retrieve the outputs manually after all calculations are finished.

!!! note
    Store the qsub options within the jobscript. Use the `mpiprocs` and `ompthreads` qsub options to control the MPI job execution.

### Example Jobscript for MPI Calculation With Preloaded Inputs

Example jobscript for an MPI job with preloaded inputs and executables, options for qsub are stored within the script:

```bash
#!/bin/bash
#PBS -q qprod
#PBS -N MYJOB
#PBS -l select=100:ncpus=16:mpiprocs=1:ompthreads=16
#PBS -A OPEN-0-0

# change to scratch directory, exit on failure
SCRDIR=/scratch/$USER/myjob
cd $SCRDIR || exit

# load the MPI module
# (Always specify the module's name and version in your script;
# for the reason, see https://docs.it4i.cz/software/modules/lmod/#loading-modules.)
ml OpenMPI/4.1.1-GCC-10.2.0-Java-1.8.0_221

# execute the calculation
mpirun ./mympiprog.x

#exit
exit
```

In this example, input and executable files are assumed to be preloaded manually in the /scratch/$USER/myjob directory. Note the `mpiprocs` and `ompthreads` qsub options controlling the behavior of the MPI execution. mympiprog.x is executed as one process per node, on all 100 allocated nodes. If mympiprog.x implements OpenMP threads, it will run 16 threads per node.

### Example Jobscript for Single Node Calculation

!!! note
    The local scratch directory is often useful for single node jobs. Local scratch memory will be deleted immediately after the job ends.

Example jobscript for single node calculation, using [local scratch][6] memory on the node:

```bash
#!/bin/bash

# change to local scratch directory
cd /lscratch/$PBS_JOBID || exit

# copy input file to scratch
cp $PBS_O_WORKDIR/input .
cp $PBS_O_WORKDIR/myprog.x .

# execute the calculation
./myprog.x

# copy output file to home
cp output $PBS_O_WORKDIR/.

#exit
exit
```

In this example, a directory in /home holds the input file input and executable myprog.x . We copy input and executable files from the home directory where the qsub was invoked ($PBS_O_WORKDIR) to local scratch memory /lscratch/$PBS_JOBID, execute myprog.x and copy the output file back to the /home directory. myprog.x runs on one node only and may use threads.

### Other Jobscript Examples

Further jobscript examples may be found in the software section and the [Capacity computing][9] section.

[1]: #example-jobscript-for-mpi-calculation-with-preloaded-inputs
[2]: resources-allocation-policy.md
[3]: ../salomon/network.md
[5]: ../salomon/7d-enhanced-hypercube.md
[6]: ../salomon/storage.md
[9]: capacity-computing.md
