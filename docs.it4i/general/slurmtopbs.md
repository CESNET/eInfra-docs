# Migrating From SLURM

SLURM-optimized parallel jobs will not under PBS out of the box.
Conversion to PBS standards is necessary. Here we provide hints on how to proceed.

It is important to notice that `mpirun`  is used here as an alternative to the `srun` in SLURM. The `-n` flag is used to regulate the number of tasks spawned by the MPI. The path to the script being run by MPI must be absolute. The script rights should be set to allow execution and reading.

The PBS provides some useful variables that may be used in the jobscripts
`PBS_O_WORKDIR` and `PBS_JOBID`. For example:

The `PBS_O_WORKDIR` returns the directory, where the `qsub` command was submitted.
The `PBS_JOBID` returns the numercal identifyer of the job.
The `qsub` always starts execution in the `$HOME` directory.

## Migrating PyTorch From SLURM

The Intel MPI provides some useful variables that may be used in the scripts executed via the MPI.
these include `PMI_RANK`,`PMI_SIZE` and `MPI_LOCALRANKID`.

- The `PMI_RANK` and `MPI_LOCALRANKID` returns the process rank within the MPI_COMM_WORLD communicator - the process number
- The `PMI_SIZE` returns the process rank within the MPI_COMM_WORLD communicator - the number of processes

For example:

```
$ mpirun -n 4 /bin/bash -c 'echo $PMI_SIZE'
4
4
4
4
```

In typical multi-gpu multi-node setting using PyTorch one needs to know:

- World-size - i.e. the total number of GPUs in the system
- Rank of a job in the world - i.e. the number of the current GPU in the system
- Local GPU ID for assignment purposes inside PyTorch/TF

The following example assumes that you use PyTorch and your `DistributedDataParallel` process is being initialized via `init_method` pointing to some file.

The required changes are:

- To get the world size, access the `PMI_SIZE` variable of the MPI
- To get the process rank in the world, access `PMI_RANK` variable of the MPI
- To get local GPU ID on the node (can be used to manually set `CUDA_VISIBLE_DEVICES`), access the `MPI_LOCALRANKID` variable.

!!! hint
    Some jobs may greatly benefit from [mixed precision training][1] since the new NVIDIA A100 GPUs have excellent support for it.

[1]: https://pytorch.org/docs/stable/amp.html
