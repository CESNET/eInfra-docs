#!/bin/bash
#PBS -A IT4I-9-11
#PBS -N Si-test
#PBS -q qprod 
#PBS -l select=8:ncpus=16:mpiprocs=16:ompthreads=1
#PBS -l walltime=23:59:59
##PBS-l mem=6gb
#PBS -j oe
#PBS -S /bin/bash
module load impi/4.1.1.036 intel/13.5.192 fftw3-mpi/3.3.3-icc
export OMP_NUM_THREADS=1
export I_MPI_COMPATIBILITY=4
##export OMP_STACKSIZE=10gb
b=`basename $PBS_O_WORKDIR`
echo $b >log.vasp
SCRDIR=/scratch/$USER/$b
mkdir -p $SCRDIR
cd $SCRDIR || exit

# copy input file to scratch 
cp $PBS_O_WORKDIR/* .

mpirun ~/bin/vasp5.4.1 > log.exc

# copy output file to home
cp * $PBS_O_WORKDIR/. && cd ..

rm -rf "$SCRDIR"

#exit
exit
