# NWChem

## Introduction

[NWChem][a] aims to provide its users with computational chemistry tools that are scalable both in their ability to treat large scientific computational chemistry problems efficiently, and in their use of available parallel computing resources from high-performance parallel supercomputers to conventional workstation clusters.

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av NWChem
```

## Running

NWChem is compiled for parallel MPI execution. A standard procedure for MPI jobs applies. A sample jobscript (for Karolina on 128 threads) using a sample input file [h2o.nw][1]:

```bash
#PBS -A IT4I-0-0
#PBS -q qprod
#PBS -l select=1:ncpus=128:mpiprocs=128

cd $PBS_O_WORKDIR
ml NWChem/7.0.2-intel-2020a-Python-3.8.2-karolina
mpirun nwchem h2o.nw
```

## Options

Refer to [the documentation][b] and set the following directives in the input file:

* MEMORY : controls the amount of memory NWChem will use
* SCRATCH_DIR : set this to a directory in SCRATCH filesystem (or run the calculation completely in a scratch directory). For certain calculations, it might be advisable to reduce I/O by forcing the `direct` mode, e.g. `scf direct`

[1]: ./files-nwchem/h2o.nw

[a]: https://www.nwchem-sw.org/index.php/Main_Page
[b]: https://github.com/nwchemgit/nwchem/wiki
