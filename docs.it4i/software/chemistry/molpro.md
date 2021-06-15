# Molpro

## Introduction

MOLPRO is a complete software package used for accurate ab-initio quantum chemistry calculations. For more information, see the [official webpage][a].

## License

MOLPRO software package is available only to users that have a valid license. Contact support to enable access to MOLPRO if you have a valid license appropriate for running on our cluster (e.g. academic research group licence, parallel execution).

To run MOLPRO, you need to have a valid license token present in `HOME/.molpro/token`. You can download the token from [MOLPRO website][b].

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av Molpro
```

Compilation parameters are default:

| Parameter                          | Value        |
| ---------------------------------- | ------------ |
| max number of atoms                | 200          |
| max number of valence orbitals     | 300          |
| max number of basis functions      | 4095         |
| max number of states per symmetry  | 20           |
| max number of state symmetries     | 16           |
| max number of records              | 200          |
| max number of primitives           | maxbfn x [2] |

## Running

MOLPRO is compiled for parallel execution using MPI and OpenMP. By default, MOLPRO reads the number of allocated nodes from PBS and launches a data server on one node. On the remaining allocated nodes, compute processes are launched, one process per node, each with 16 threads. You can modify this behavior by using the `-n`, `-t`, and `helper-server` options. For more details, see the [MOLPRO documentation][c].

!!! note
    The OpenMP parallelization in MOLPRO is limited and has been observed to produce limited scaling. We therefore recommend to use MPI parallelization only. This can be achieved by passing the `mpiprocs=16:ompthreads=1` option to PBS.

You are advised to use the `-d` option to point to a directory in [SCRATCH file system - Salomon][1]. MOLPRO can produce a large amount of temporary data during its run, so it is important that these are placed in the fast scratch file system.

### Example jobscript

```bash
#PBS -A IT4I-0-0
#PBS -q qprod
#PBS -l select=1:ncpus=16:mpiprocs=16:ompthreads=1

cd $PBS_O_WORKDIR

# load Molpro module
module add molpro

# create a directory in the SCRATCH filesystem
mkdir -p /scratch/$USER/$PBS_JOBID

# copy an example input
cp /apps/chem/molpro/2010.1/molprop_2010_1_Linux_x86_64_i8/examples/caffeine_opt_diis.com .

# run Molpro with default options
molpro -d /scratch/$USER/$PBS_JOBID caffeine_opt_diis.com

# delete scratch directory
rm -rf /scratch/$USER/$PBS_JOBID
```

[1]: ../../salomon/storage.md

[a]: http://www.molpro.net/
[b]: https://www.molpro.net/licensee/?portal=licensee
[c]: http://www.molpro.net/info/2010.1/doc/manual/node9.html
