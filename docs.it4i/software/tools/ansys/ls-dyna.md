# LS-DYNA

[LS-DYNA][a] is a multi-purpose, explicit and implicit finite element program used to analyze the nonlinear dynamic response of structures. Its fully automated contact analysis capability, a wide range of constitutive models to simulate a whole range of engineering materials (steels, composites, foams, concrete, etc.), error-checking features, and the high scalability have enabled users worldwide to solve successfully many complex problems. Additionally LS-DYNA is extensively used to simulate impacts on structures from drop tests, underwater shock, explosions or high-velocity impacts. Explosive forming, process engineering, accident reconstruction, vehicle dynamics, thermal brake disc analysis, or nuclear safety are further areas in the broad range of possible applications. In leading-edge research, LS-DYNA is used to investigate the behavior of materials like composites, ceramics, concrete, or wood. Moreover, it is used in biomechanics, human modeling, molecular structures, casting, forging, or virtual testing.

!!! Info
    We provide **1 commercial license of LS-DYNA without HPC** support, now.

To run LS-DYNA in batch mode, you can utilize/modify the default lsdyna.pbs script and execute it via the qsub command:

```bash
#!/bin/bash
#PBS -l select=5:ncpus=16:mpiprocs=16
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

ml lsdyna

/apps/engineering/lsdyna/lsdyna700s i=input.k
```

The header of the PBS file (above) is common and the description can be found on [this site][1]. [SVS FEM][b] recommends utilizing sources by keywords: nodes, ppn. These keywords allow addressing directly the number of nodes (computers) and cores (ppn) utilized in the job. In addition, the rest of the code assumes such structure of allocated resources.

A working directory has to be created before sending the PBS job into the queue. The input file should be in the working directory or a full path to input file has to be specified. The input file has to be defined by a common LS-DYNA **.k** file which is attached to the LS-DYNA solver via the `i=`  parameter.

[1]: ../../../general/job-submission-and-execution.md

[a]: http://www.lstc.com/
[b]: http://www.svsfem.cz
