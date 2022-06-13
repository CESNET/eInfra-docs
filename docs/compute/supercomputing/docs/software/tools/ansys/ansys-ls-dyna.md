# ANSYS LS-DYNA

[ANSYSLS-DYNA][a] provides convenient and easy-to-use access to the technology-rich, time-tested explicit solver without the need to contend with the complex input requirements of this sophisticated program. Introduced in 1996, ANSYS LS-DYNA capabilities have helped customers in numerous industries to resolve highly intricate design issues. ANSYS Mechanical users have been able to take advantage of complex explicit solutions for a long time utilizing the traditional ANSYS Parametric Design Language (APDL) environment. These explicit capabilities are available to ANSYS Workbench users as well. The Workbench platform is a powerful, comprehensive, easy-to-use environment for engineering simulation. CAD import from all sources, geometry cleanup, automatic meshing, solution, parametric optimization, result visualization, and comprehensive report generation are all available within a single fully interactive modern graphical user environment.

To run ANSYS LS-DYNA in batch mode, you can utilize/modify the default ansysdyna.pbs script and execute it via the qsub command:

```bash
#!/bin/bash
#PBS -l select=5:ncpus=128:mpiprocs=128
#PBS -q qprod
#PBS -N ANSYS-test
#PBS -A XX-YY-ZZ

#!change the working directory (default is home directory)
#cd <working directory>
DIR=/scratch/project/PROJECT_ID/$PBS_JOBID
mkdir -p "$DIR"
cd "$DIR" || exit

echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo This jobs runs on the following processors:
echo `cat $PBS_NODEFILE`

#! Counts the number of processors
NPROCS=`wc -l < $PBS_NODEFILE`

echo This job has allocated $NPROCS nodes

ml ANSYS/21.1-intel-2018a

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

ansys211 -dis -lsdynampp i=input.k -machines $hl
```

The header of the PBS file (above) is common and the description can be found on [this site][1]. [SVS FEM][b] recommends to utilize sources by keywords: nodes, ppn. These keywords allows addressing directly the number of nodes (computers) and cores (ppn) utilized in the job. In addition, the rest of the code assumes such structure of allocated resources.

[1]: ../../../general/job-submission-and-execution.md

[a]: http://www.ansys.com/products/structures/ansys-ls-dyna
[b]: http://www.svsfem.cz
