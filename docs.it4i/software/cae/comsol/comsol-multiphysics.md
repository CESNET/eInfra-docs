# COMSOL Multiphysics

## Introduction

[COMSOL][a] is a powerful environment for modelling and solving various engineering and scientific problems based on partial differential equations. COMSOL is designed to solve coupled or multiphysics phenomena. For many standard engineering problems, COMSOL provides add-on products such as electrical, mechanical, fluid flow, and chemical applications.

* [Structural Mechanics Module][b],
* [Heat Transfer Module][c],
* [CFD Module][d],
* [Acoustics Module][e].
* and [many others][f]

COMSOL also allows an interface support for equation-based modelling of partial differential equations.

## Execution

On the clusters, COMSOL is available in the latest stable version. There are two variants of the release:

* **Non commercial** or so called **EDU variant**, which can be used for research and educational purposes.

* **Commercial** or so called **COM variant**, which can used also for commercial activities. **COM variant** has only subset of features compared to the **EDU variant** available. More about licensing [here][1].

To load the `COMSOL` module, use:

```console
$ ml COMSOL
```

By default, the **EDU variant** will be loaded. If you needs other version or variant, load the particular version. To obtain the list of available versions, use:

```console
$ ml av COMSOL
```

To prepare COMSOL jobs in the interactive mode, we recommend using COMSOL on the compute nodes via the PBS Pro scheduler. To run the COMSOL Desktop GUI on Windows.

!!! Note
    We recommend using the [Virtual Network Computing (VNC)][2].

Example for Barbora:

```console
$ qsub -I -X -A PROJECT_ID -q qprod -l select=1:ncpus=36
$ ml av COMSOL

------------------------------ /apps/modules/phys ------------------------------
   COMSOL/5.2.0-COM    COMSOL/5.2.0-EDU (D)

$ ml COMSOL/5.2.0-EDU
$ comsol -3drend sw
```

!!! info
    If you receive errors at startup, for example, of the following type:
    
    ```console
FL3D: error at line 814 in file fl3dglcontext_x11common.c:
   PBuffers are not supported by the system.
FL3D: error at line 235 in file fl3dglcontext_x11common.c:
   assert: x11Handle
   ```

   you need to run COMSOL with additional parameters:

   ```console
$ comsol -3drend sw
   ```

To run COMSOL in batch mode without the COMSOL Desktop GUI environment, utilize the default (comsol.pbs) job script and execute it via the `qsub` command:

```bash
#!/bin/bash
#PBS -l select=3:ppn=24
#PBS -q qprod
#PBS -N JOB_NAME
#PBS -A PROJECT_ID

cd /scratch/work/user/$USER/ || exit

echo Time is `date`
echo Directory is `pwd`
echo '**PBS_NODEFILE***START*******'
cat $PBS_NODEFILE
echo '**PBS_NODEFILE***END*********'

text_nodes < cat $PBS_NODEFILE

ml COMSOL
# ml COMSOL/51-EDU

ntask=$(wc -l $PBS_NODEFILE)

comsol -nn ${ntask} batch -configuration /tmp –mpiarg –rmk –mpiarg pbs -tmpdir /scratch/.../$USER/ -inputfile name_input_f.mph -outputfile name_output_f.mph -batchlog name_log_f.log
```

A working directory has to be created before sending the (comsol.pbs) job script into the queue. The input file (name_input_f.mph) has to be in the working directory or a full path to the input file has to be specified. The appropriate path to the temp directory of the job has to be set by the `-tmpdir` command option.

## LiveLink for MATLAB

COMSOL is a software package for the numerical solution of partial differential equations. LiveLink for MATLAB allows connection to the COMSOL API (Application Programming Interface) with the benefits of the programming language and computing environment of the MATLAB.

LiveLink for MATLAB is available in both **EDU** and **COM** **variant** of the COMSOL release. On the clusters there is 1 commercial (**COM**) and 5 educational (**EDU**) licenses of LiveLink for MATLAB (see the [ISV Licenses][3]). The following example shows how to start COMSOL model from MATLAB via LiveLink in the interactive mode.

```console
$ xhost +
$ qsub -I -X -A PROJECT_ID -q qexp -l select=1:ppn=24
$ ml MATLAB
$ ml COMSOL
$ comsol server MATLAB
```

On the first start of the LiveLink for MATLAB (client-MATLAB/server-COMSOL connection), the login and password is requested; this information is not requested again.

To run LiveLink for MATLAB in batch mode with (comsol_matlab.pbs) job script, you can utilize/modify the following script and execute it via the `qsub` command.

```bash
#!/bin/bash
#PBS -l select=3:ppn=24
#PBS -q qprod
#PBS -N JOB_NAME
#PBS -A PROJECT_ID

cd /scratch/work/user/$USER || exit

echo Time is `date`
echo Directory is `pwd`
echo '**PBS_NODEFILE***START*******'
cat $PBS_NODEFILE
echo '**PBS_NODEFILE***END*********'

text_nodes < cat $PBS_NODEFILE

ml MATLAB
ml COMSOL/51-EDU

ntask=$(wc -l $PBS_NODEFILE)

comsol -nn ${ntask} server -configuration /tmp -mpiarg -rmk -mpiarg pbs -tmpdir /scratch/work/user/$USER/work &
cd /apps/cae/COMSOL/51/mli
matlab -nodesktop -nosplash -r "mphstart; addpath /scratch/work/user/$USER/work; test_job"
```

This example shows how to run LiveLink for MATLAB with the following configuration: 3 nodes and 16 cores per node. A working directory has to be created before submitting (comsol_matlab.pbs) job script into the queue. The input file (test_job.m) has to be in the working directory or a full path to the input file has to be specified. The Matlab command option (`-r ”mphstart”`) created a connection with a COMSOL server using the default port number.

[1]: licensing-and-available-versions.md
[2]: ../../../general/accessing-the-clusters/graphical-user-interface/x-window-system.md
[3]: ../../isv_licenses.md

[a]: http://www.comsol.com
[b]: http://www.comsol.com/structural-mechanics-module
[c]: http://www.comsol.com/heat-transfer-module
[d]: http://www.comsol.com/cfd-module
[e]: http://www.comsol.com/acoustics-module
[f]: http://www.comsol.com/products
