# ANSYS MAPDL

[ANSYS Multiphysics][a] offers a comprehensive product solution for both multiphysics and single-physics analysis. The product includes structural, thermal, fluid, and both high- and low-frequency electromagnetic analysis. The product also contains solutions for both direct and sequentially coupled physics problems including direct coupled-field elements and the ANSYS multi-field solver.

To run ANSYS MAPDL in batch mode you can utilize/modify the default mapdl.pbs script and execute it via the `qsub` command:

```bash
#!/bin/bash
#PBS -l select=5:ncpus=128:mpiprocs=128
#PBS -q qprod
#PBS -N ANSYS-test
#PBS -A XX-YY-ZZ

#!change the working directory (default is home directory)
#cd <working directory> (working directory must exists)
DIR=/scratch/project/PROJECT_ID/$PBS_JOBID
mkdir -p "$DIR"
cd "$DIR" || exit

echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo This jobs runs on the following processors:
echo `cat $PBS_NODEFILE`

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

#-i input.dat includes the input of analysis in APDL format
#-o file.out is output file from ansys where all text outputs will be redirected
#-p the name of license feature (aa_r=ANSYS Academic Research, ane3fl=Multiphysics(commercial), aa_r_dy=Academic AUTODYN)
ansys211 -b -dis -p aa_r -i input.dat -o file.out -machines $hl -dir $WORK_DIR
```

The header of the PBS file (above) is common and the description can be found on [this site][1]. [SVS FEM][b] recommends utilizing sources by keywords: nodes, ppn. These keywords allow addressing directly the number of nodes (computers) and cores (ppn) utilized in the job. In, addition the rest of the code assumes such structure of allocated resources.

A working directory has to be created before sending the PBS job into the queue. The input file should be in the working directory or a full path to the input file has to be specified. The input file has to be defined by a common APDL file which is attached to the ANSYS solver via the `-i` parameter.

The **license** should be selected by the `-p` parameter. Licensed products are the following: `aa_r` (ANSYS **Academic** Research), `ane3fl` (ANSYS Multiphysics-**Commercial**), and `aa_r_dy` (ANSYS **Academic** AUTODYN)

[1]: ../../../general/resources-allocation-policy.md

[a]: http://www.ansys.com/products/multiphysics
[b]: http://www.svsfem.cz
