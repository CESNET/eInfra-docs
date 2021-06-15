# ANSYS CFX

[ANSYS CFX][a] is a high-performance, general purpose fluid dynamics program that has been applied to solve wide-ranging fluid flow problems for over 20 years. At the heart of ANSYS CFX is its advanced solver technology, the key to achieving reliable and accurate solutions quickly and robustly. The modern, highly parallelized solver is the foundation for an abundant choice of physical models to capture virtually any type of phenomena related to fluid flow. The solver and its many physical models are wrapped in a modern, intuitive, and flexible GUI and user environment, with extensive capabilities for customization and automation using session files, scripting and a powerful expression language.

To run ANSYS CFX in batch mode, you can utilize/modify the default cfx.pbs script and execute it via the `qsub` command:

```bash
#!/bin/bash
#PBS -l select=5:ncpus=24:mpiprocs=24
#PBS -q qprod
#PBS -N ANSYS-test
#PBS -A XX-YY-ZZ

#! Mail to user when job terminate or abort
#PBS -m ae

#!change the working directory (default is home directory)
#cd <working directory> (working directory must exists)
WORK_DIR="/scratch/$USER/work"
cd $WORK_DIR

echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo This jobs runs on the following processors:
echo `cat $PBS_NODEFILE`

ml ANSYS/19.1-intel-2017c

#### Set number of processors per host listing
#### (set to 1 as $PBS_NODEFILE lists each node twice if :ppn=2)
procs_per_host=1
#### Create host list
hl=""
for host in `cat $PBS_NODEFILE`
do
 if ["$hl" = "" ]
 then hl="$host:$procs_per_host"
 else hl="${hl}:$host:$procs_per_host"
 fi
done

echo Machines: $hl

#-dev input.def includes the input of CFX analysis in DEF format
#-P the name of prefered license feature (aa_r=ANSYS Academic Research, ane3fl=Multiphysics(commercial))
cfx5solve -def input.def -size 4 -size-ni 4x -part-large -start-method "Platform MPI Distributed Parallel" -par-dist $hl -P aa_r
```

The header of the PBS file (above) is common and the description can be found on [this site][1]. SVS FEM recommends utilizing sources by keywords: nodes, ppn. These keywords allow addressing directly the number of nodes (computers) and cores (ppn) utilized in the job. In addition, the rest of the code assumes such structure of allocated resources.

A working directory has to be created before sending the PBS job into the queue. The input file should be in the working directory or a full path to the input file has to be specified. The input file has to be defined by a common CFX def file which is attached to the CFX solver via the `-def` parameter.

The **license** should be selected by the `-P` parameter. Licensed products are: `aa_r` (ANSYS **Academic** Research) and `ane3fl` (ANSYS Multiphysics-**Commercial**).

[1]: ../../../general/job-submission-and-execution.md

[a]: http://www.ansys.com/products/fluids/ansys-cfx
