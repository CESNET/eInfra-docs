# MATLAB

## Introduction

MATLAB is available in versions R2015a and R2015b. There are always two variants of the release:

* Non-commercial or so-called EDU variant, which can be used for common research and educational purposes.
* Commercial or so-called COM variant, which can used also for commercial activities. Commercial licenses are much more expensive, so usually the commercial license has only a subset of features compared to the available EDU license.

To load the latest version of MATLAB load the module:

```console
$ ml MATLAB
```

The EDU variant is marked as default. If you need other version or variant, load the particular version. To obtain the list of available versions, use:

```console
$ ml av MATLAB
------------------------------------------------ /apps/modules/math -------------------------------------------------
   MATLAB/R2015b    MATLAB/2021a (D)
```

!!! info
    Version 2021a is e-infra licence, without cluster licenses - only basic functionality.

If you need to use the MATLAB GUI to prepare your MATLAB programs, you can use MATLAB directly on the login nodes. However, for all computations, use MATLAB on the compute nodes via PBS Pro scheduler.

If you require the MATLAB GUI, follow the general information about [running graphical applications][1].

MATLAB GUI is quite slow using the X forwarding built in the PBS (`qsub -X`), so using X11 display redirection either via SSH or directly by `xauth` (see the [GUI Applications on Compute Nodes over VNC][1] section) is recommended.

To run MATLAB with GUI, use:

```console
$ matlab
```

To run MATLAB in text mode, without the MATLAB Desktop GUI environment, use:

```console
$ matlab -nodesktop -nosplash
```

plots, images, etc. will be still available.

## Running Parallel MATLAB Using Distributed Computing Toolbox / Engine

Distributed toolbox is available only for the EDU variant

The MPIEXEC mode available in previous versions is no longer available in MATLAB 2015. In addition, the programming interface has changed. Refer to [Release Notes][a].

Delete previously used file mpiLibConf.m, we have observed crashes when using Intel MPI.

To use Distributed Computing, you first need to setup a parallel profile. We have provided the profile for you, you can either import it in the MATLAB command line:

* Karolina cluster - KarolinaPBSPro.settings
* Barbora cluster - BarboraPBSPro.settings

```console
> parallel.importProfile('/apps/all/MATLAB/R2015b/KarolinaPBSPro.settings')

ans =

KarolinaPBSPro
```

or in the GUI, go to tab *HOME -> Parallel -> Manage Cluster Profiles...*, click *Import* and navigate to:

/apps/all/MATLAB/R2015b/KarolinaPBSPro.settings

With the new mode, MATLAB itself launches the workers via PBS, so you can use either an interactive mode or a batch mode on one node, but the actual parallel processing will be done in a separate job started by MATLAB itself. Alternatively, you can use a "local" mode to run parallel code on just a single node.

### Parallel MATLAB Interactive Session

The following example shows how to start the interactive session with support for MATLAB GUI. For more information about GUI based applications, see [this page][1].

```console
$ qsub -I -X -q qexp -l select=1 -l walltime=00:30:00 -l license__matlab-edu__MATLAB=1
```

This `qsub` command example shows how to run MATLAB on a single node.

The second part of the command shows how to request all necessary licenses. In this case, 1 MATLAB-EDU license and 48 Distributed Computing Engines licenses.

Once the access to compute nodes is granted by PBS, the user can load following modules and start MATLAB:

```console
$ ml MATLAB/R2015b
$ matlab &
```

### Parallel MATLAB Batch Job in Local Mode

To run MATLAB in a batch mode, write a MATLAB script, then write a bash jobscript and execute via the `qsub` command. By default, MATLAB will execute one MATLAB worker instance per allocated core.

```bash
#!/bin/bash
#PBS -A PROJECT ID
#PBS -q qprod
#PBS -l select=1:ncpus=128:mpiprocs=128:ompthreads=1

# change to shared scratch directory
DIR=/scratch/project/PROJECT_ID/$PBS_JOBID
mkdir -p "$DIR"
cd "$DIR" || exit

# copy input file to scratch
cp $PBS_O_WORKDIR/matlabcode.m .

# load modules
ml MATLAB/R2015b

# execute the calculation
matlab -nodisplay -r matlabcode > output.out

# copy output file to home
cp output.out $PBS_O_WORKDIR/.

# remove scratch folder
rm -rf $SCR

# exit
exit
```

This script may be submitted directly to the PBS workload manager via the `qsub` command.  The inputs and the MATLAB script are in the matlabcode.m file, outputs in the output.out file. Note the missing .m extension in the `matlab -r matlabcodefile` call, **the .m must not be included**.  Note that the **shared /scratch must be used**. Further, it is **important to include the `quit`** statement at the end of the matlabcode.m script.

Submit the jobscript using `qsub`:

```console
$ qsub ./jobscript
```

### Parallel Matlab Local Mode Program Example

The last part of the configuration is done directly in the user's MATLAB script before Distributed Computing Toolbox is started.

```console
cluster = parcluster('local')
```

This script creates the scheduler object *cluster* of the type *local* that starts workers locally.

!!! hint
    Every MATLAB script that needs to initialize/use `matlabpool` has to contain these three lines prior to calling the `parpool(sched, ...)` function.

The last step is to start `matlabpool` with the *cluster* object and a correct number of workers. We have 128 cores per node, so we start 128 workers.

```console
parpool(cluster,128);


... parallel code ...


parpool close
```

The complete example showing how to use Distributed Computing Toolbox in local mode is shown here.

```matlab
cluster = parcluster('local');
cluster

parpool(cluster,128);

n=2000;

W = rand(n,n);
W = distributed(W);
x = (1:n)';
x = distributed(x);
spmd
[~, name] = system('hostname')

    T = W*x; % Calculation performed on labs, in parallel.
             % T and W are both codistributed arrays here.
end
T;
whos         % T and W are both distributed arrays here.

delete(gcp('nocreate')) % close parpool
quit
```

You can copy and paste the example in a .m file and execute. Note that the `parpool` size should correspond to the **total number of cores** available on allocated nodes.

### Parallel MATLAB Batch Job Using PBS Mode (Workers Spawned in a Separate Job)

This mode uses the PBS scheduler to launch the parallel pool. It uses the KarolinaPBSPro profile that needs to be imported to Cluster Manager, as mentioned before. This method uses MATLAB's PBS Scheduler interface - it spawns the workers in a separate job submitted by MATLAB using qsub.

This is an example of an m-script using the PBS mode:

```matlab
cluster = parcluster('KarolinaPBSPro');
set(cluster, 'SubmitArguments', '-A OPEN-0-0');
set(cluster, 'ResourceTemplate', '-q qprod -l select=10:ncpus=128');
set(cluster, 'NumWorkers', 1280);

pool = parpool(cluster,1280);

n=2000;

W = rand(n,n);
W = distributed(W);
x = (1:n)';
x = distributed(x);
spmd
[~, name] = system('hostname')

    T = W*x; % Calculation performed on labs, in parallel.
             % T and W are both codistributed arrays here.
end
whos         % T and W are both distributed arrays here.

% shut down parallel pool
delete(gcp('nocreate'))
quit
```

Note that we first construct a cluster object using the imported profile, then set some important options, namely: `SubmitArguments`, where you need to specify accounting id, and `ResourceTemplate`, where you need to specify the number of nodes to run the job.

You can start this script using the batch mode the same way as in the Local mode example.

### Non-Interactive Session and Licenses

If you want to run batch jobs with MATLAB, be sure to request appropriate license features with the PBS Pro scheduler, at least the `-l license__matlab-edu__MATLAB=1` for the EDU variant of MATLAB. For more information about how to check the license features states and how to request them with PBS Pro, [look here][3].

In case of non-interactive session, read the [following information][3] on how to modify the `qsub` command to test for available licenses prior getting the resource allocation.

[1]: ../../general/accessing-the-clusters/graphical-user-interface/vnc.md#gui-applications-on-compute-nodes-over-vnc
[2]: #running-parallel-matlab-using-distributed-computing-toolbox---engine
[3]: ../isv_licenses.md
[4]: #parallel-matlab-batch-job-in-local-mode

[a]: https://www.mathworks.com/help/parallel-computing/release-notes.html
[b]: https://www.e-infra.cz/en

<!---
2021-04-08

Matlab 2018 requires a license in order to be run.

2021-03-31

## Todo

* tested MATLAB/2015a-EDU and MATLAB/2015b-EDU, others don't have the PBSPro profile created
* barbora works fine

## Obsolete 2021-03-31

* MATLAB/2017a-runtime and MATLAB/2018a-EDU don't seem to have a matlab binary? (or no license provided?)

-->
