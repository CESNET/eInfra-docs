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

## Register as a User

You are encouraged to register as a user of ORCA [here][a] in order to take advantage of updates, announcements, and the users forum.

## Documentation

A comprehensive [manual][b] is available online.

[a]: https://orcaforum.kofo.mpg.de/
[b]: https://kofo.mpg.de/media/2/D19114521/4329011608/orca_manual-opt.pdf
