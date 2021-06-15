#!/bin/bash
#PBS -A OPEN-6-23
#PBS -N Si-test1
#PBS -q qfree 
#PBS -l select=1:ncpus=24:mpiprocs=24:ompthreads=1
#PBS -l walltime=01:59:59
##PBS-l mem=6gb
#PBS -j oe
#PBS -S /bin/bash
module purge
module load phono3py/0.9.14-ictce-7.3.5-Python-2.7.9
export OMP_NUM_THREADS=1
export I_MPI_COMPATIBILITY=4
##export OMP_STACKSIZE=10gb
##0	1	2	3	4	10	11	12	13	20	21	22	30	31	40	91	92	93	94	101	102	103	111	112	121	182	183	184	192	193	202	273	274	283	364
cd $PBS_O_WORKDIR
phono3py --fc3 --fc2 --dim="2 2 2" --mesh="9 9 9" -c POSCAR  --sigma 0.1 --br --write_gamma --gp="0 1 3 4 10" 
#phono3py --fc3 --fc2 --dim="2 2 2" --mesh="9 9 9" -c POSCAR  --sigma 0.1 --br --write_gamma --gp="11 12 13 20 21" 
#phono3py --fc3 --fc2 --dim="2 2 2" --mesh="9 9 9" -c POSCAR  --sigma 0.1 --br --write_gamma --gp="21 22 30 31 40"
#phono3py --fc3 --fc2 --dim="2 2 2" --mesh="9 9 9" -c POSCAR  --sigma 0.1 --br --write_gamma --gp="91 92 93 94 101"
#phono3py --fc3 --fc2 --dim="2 2 2" --mesh="9 9 9" -c POSCAR  --sigma 0.1 --br --write_gamma --gp="102 103 111 112 121"
#phono3py --fc3 --fc2 --dim="2 2 2" --mesh="9 9 9" -c POSCAR  --sigma 0.1 --br --write_gamma --gp="182 183 184 192 193"
#phono3py --fc3 --fc2 --dim="2 2 2" --mesh="9 9 9" -c POSCAR  --sigma 0.1 --br --write_gamma --gp="202 273 274 283 364"
