# NWChem

## Introduction

[NWChem][a] aims to provide its users with computational chemistry tools that are scalable both in their ability to treat large scientific computational chemistry problems efficiently, and in their use of available parallel computing resources from high-performance parallel supercomputers to conventional workstation clusters.

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av NWChem
```

## Running

NWChem is compiled for parallel MPI execution. A standard procedure for MPI jobs applies. A sample jobscript (for Salomon on 24 threads) using a sample input file [h2o.nw][1]:

```bash
#PBS -A IT4I-0-0
#PBS -q qprod
#PBS -l select=1:ncpus=24:mpiprocs=24

cd $PBS_O_WORKDIR
ml NWChem
mpirun nwchem h2o.nw
```

## Options

Refer to [the documentation][b] and set the following directives in the input file:

* MEMORY : controls the amount of memory NWChem will use
* SCRATCH_DIR : set this to a directory in [SCRATCH filesystem - Salomon][2] (or run the calculation completely in a scratch directory). For certain calculations, it might be advisable to reduce I/O by forcing the `direct` mode, e.g. `scf direct`

[1]: ./files-nwchem/h2o.nw
[2]: ../../salomon/storage.md

[a]: https://www.nwchem-sw.org/index.php/Main_Page
[b]: https://github.com/nwchemgit/nwchem/wiki
