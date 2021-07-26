# ORCA

## Introduction

ORCA is a flexible, efficient, and easy-to-use general-purpose tool for quantum chemistry with specific emphasis on spectroscopic properties of open-shell molecules. It features a wide variety of standard quantum chemical methods ranging from semiempirical methods to DFT to single- and multireference correlated ab initio methods. It can also treat environmental and relativistic effects.

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av orca
```

## Serial Computation With ORCA

You can test a serial computation with this simple input file. Create a file called orca_serial.inp and fill it with the following ORCA commands:

```bash
    # Taken from the Orca manual
    # https://orcaforum.cec.mpg.de/OrcaManual.pdf
    ! HF SVP
    * xyz 0 1
      C 0 0 0
      O 0 0 1.13
    *
```

Next, create a PBS submission file (interactive job can be used too):

```bash
#!/bin/bash
#PBS -S /bin/bash
#PBS -N ORCA_SERIAL
#PBS -l select=1
#PBS -q qexp
#PBS -A OPEN-0-0

ml ORCA/4.0.1.2
orca orca_serial.inp
```

Submit the job to the queue and wait before it ends. Then you can find an output log in your working directory:

```console
$ qsub submit_serial.pbs
1417552.dm2

$ ll ORCA_SERIAL.*
-rw------- 1 hra0031 hra0031     0 Aug 21 12:24 ORCA_SERIAL.e1417552
-rw------- 1 hra0031 hra0031 20715 Aug 21 12:25 ORCA_SERIAL.o1417552

$ cat ORCA_SERIAL.o1417552

                                 *****************
                                 * O   R   C   A *
                                 *****************

           --- An Ab Initio, DFT and Semiempirical electronic structure package ---

                  #######################################################
                  #                        -***-                        #
                  #  Department of molecular theory and spectroscopy    #
                  #              Directorship: Frank Neese              #
                  # Max Planck Institute for Chemical Energy Conversion #
                  #                  D-45470 Muelheim/Ruhr              #
                  #                       Germany                       #
                  #                                                     #
                  #                  All rights reserved                #
                  #                        -***-                        #
                  #######################################################


                         Program Version 4.0.1.2 - RELEASE -

...

                             ****ORCA TERMINATED NORMALLY****
TOTAL RUN TIME: 0 days 0 hours 0 minutes 1 seconds 47 msec
```

## Running ORCA in Parallel

Your serial computation can be easily converted to parallel. Simply specify the number of parallel processes by the `%pal` directive. In this example, 4 nodes, 16 cores each are used.

!!! warning
    Do not use the `! PAL` directive as only PAL2 to PAL8 is recognized.

```bash
    # Taken from the Orca manual
    # https://orcaforum.cec.mpg.de/OrcaManual.pdf
    ! HF SVP
    %pal
      nprocs 64 # 4 nodes, 16 cores each
    end
    * xyz 0 1
      C 0 0 0
      O 0 0 1.13
    *
```

You also need to edit the previously used PBS submission file. You have to specify number of nodes, cores and MPI-processes to run:

```bash
#!/bin/bash
#PBS -S /bin/bash
#PBS -N ORCA_PARALLEL
#PBS -l select=4:ncpus=16:mpiprocs=16
#PBS -q qexp
#PBS -A OPEN-0-0

ml ORCA/4.0.1.2
/apps/all/ORCA/4.0.1.2/orca orca_parallel.inp > output.out
```

!!! note
    When running ORCA in parallel, ORCA should **NOT** be started with `mpirun` (e.g. `mpirun -np 4 orca`, etc.) like many MPI programs and **has to be called with a full pathname**.

Submit this job to the queue and see the output file.

```console
$ qsub submit_parallel.pbs
1417598.dm2

$ ll ORCA_PARALLEL.*
-rw-------  1 hra0031 hra0031     0 Aug 21 13:12 ORCA_PARALLEL.e1417598
-rw-------  1 hra0031 hra0031 23561 Aug 21 13:13 ORCA_PARALLEL.o1417598

$ cat ORCA_PARALLEL.o1417598

                                 *****************
                                 * O   R   C   A *
                                 *****************

           --- An Ab Initio, DFT and Semiempirical electronic structure package ---

                  #######################################################
                  #                        -***-                        #
                  #  Department of molecular theory and spectroscopy    #
                  #              Directorship: Frank Neese              #
                  # Max Planck Institute for Chemical Energy Conversion #
                  #                  D-45470 Muelheim/Ruhr              #
                  #                       Germany                       #
                  #                                                     #
                  #                  All rights reserved                #
                  #                        -***-                        #
                  #######################################################


                         Program Version 4.0.1.2 - RELEASE -
...

           ************************************************************
           *        Program running with 64 parallel MPI-processes    *
           *              working on a common directory               *
           ************************************************************

...
                             ****ORCA TERMINATED NORMALLY****
TOTAL RUN TIME: 0 days 0 hours 0 minutes 11 seconds 859 msec
```

You can see, that the program was running with 64 parallel MPI-processes. In version 4.0.1.2, only the following modules are parallelized:

* ANOINT
* CASSCF / NEVPT2
* CIPSI
* CIS/TDDFT
* CPSCF
* EPRNMR
* GTOINT
* MDCI (Canonical-, PNO-, DLPNO-Methods)
* MP2 and RI-MP2 (including Gradient and Hessian)
* MRCI
* PC
* ROCIS
* SCF
* SCFGRAD
* SCFHESS
* SOC
* Numerical Gradients and Frequencies

## Running ORCA version 5.0.0 in parallel

On Barbora cluster, version 5.0.0 is available. However, to run it in parallel you need to specify execution nodes via `inputfilename.nodes` file. Additionally, all calculations **must** be run on SCRATCH.

Example submission script would look like this:

```
#!/bin/bash
#PBS -S /bin/bash
#PBS -A OPEN-00-00
#PBS -N jobname
#PBS -q qprod
#PBS -l select=2
#PBS -l walltime=00:05:00

ml purge
ml ORCA/5.0.0-OpenMPI-4.1.1

echo $PBS_O_WORKDIR
cd $PBS_O_WORKDIR

# create /scratch dir
b=$(basename $PBS_O_WORKDIR)
SCRDIR=/scratch/project/OPEN-00-00/$USER/${b}_${PBS_JOBID}/
echo $SCRDIR
mkdir -p $SCRDIR
cd $SCRDIR || exit

### specify nodes used for the parallel run
cat $(echo $PBS_NODEFILE) > ${PBS_JOBNAME}.nodes
###

# get number of cores used for our job
ncpus=$(qstat -f $PBS_JOBID | grep resources_used.ncpus | awk '{print $3}')


### create ORCA input file
cat > ${PBS_JOBNAME}.inp <<EOF
! HF def2-TZVP
%pal
  nprocs $ncpus
end
* xyz 0 1
C 0.0 0.0
 0.0
O 0.0 0.0
 1.13
*
EOF
###

# copy input files to /scratch
cp -r $PBS_O_WORKDIR/* .

# run calculations
/apps/all/ORCA/5.0.0-OpenMPI-4.1.1/orca ${PBS_JOBNAME}.inp > $PBS_O_WORKDIR/${PBS_JOBNAME}.out

# copy output files to home, delete the rest
cp * $PBS_O_WORKDIR/ && cd $PBS_O_WORKDIR
rm -rf $SCRDIR
exit
```

## Register as a User

You are encouraged to register as a user of ORCA [here][a] in order to take advantage of updates, announcements, and the users forum.

## Documentation

A comprehensive [manual][b] is available online for registered users.

[a]: https://orcaforum.kofo.mpg.de/app.php/portal
[b]: https://orcaforum.kofo.mpg.de/app.php/dlext/?cat=1
