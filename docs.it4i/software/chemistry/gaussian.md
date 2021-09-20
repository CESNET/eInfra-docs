# Gaussian

## Introduction

Gaussian provides state-of-the-art capabilities for electronic structure modeling.
Gaussian provides a wide-ranging suite of the most advanced modeling capabilities available.
Starting from the fundamental laws of quantum mechanics, Gaussian predicts the energies, molecular structures, vibrational frequencies, and molecular properties of compounds and reactions in a wide variety of chemical environments.
Gaussians models can be applied to both stable species and compounds that are difficult or impossible to observe experimentally.

For more information, see the [official webpage][a].

## License

Gaussian software package is available to all users that are
not in direct or indirect competition with the Gaussian Inc. company and have a valid AUP with the IT4Innovations National Supercomputing Center.
The license includes GPU support and Linda parallel environment for Gaussian multi-node parallel execution.

!!! note
    You need to be a member of the **gaussian group**. Contact [support\[at\]it4i.cz][b] in order to get included in the gaussian group.

Check your group membership:

```bash
$ id
uid=1000(user) gid=1000(user) groups=1000(user),1234(open-0-0),7310(gaussian)
```

## Installed Version

Gaussian is available on Salomon, Barbora, and DGX-2 systems in the latest version Gaussian 16 rev. c0.

| Module                                | CPU support | GPU support  | Parallelization | Note               | Barbora | Salomon | DGX-2 |
|--------------------------------------|-------------|--------------|-----------------|---------------------|---------|---------|-------|
| Gaussian/16_rev_c0-binary            | AVX2        | Yes          | SMP             | Binary distribution | Yes     | No      | Yes   |
| Gaussian/16_rev_c0-binary-Linda      | AVX2        | Yes          | SMP + Linda     | Binary distribution | Yes     | Yes     | No    |
| Gaussian/16_rev_c0-CascadeLake       | AVX-512     | No           | SMP             | IT4I compiled       | Yes     | No      | No    |
| Gaussian/16_rev_c0-CascadeLake-Linda | AVX-512     | No           | SMP + Linda     | IT4I compiled       | Yes     | No      | No    |
| Gaussian/16_rev_c0-GPU-Linda         | AVX-512     | Yes          | SMP + Linda     | IT4I compiled       | Yes     | No      | No    |
| Gaussian/16_rev_c0-GPU               | AVX-512     | Yes          | SMP             | IT4I compiled       | No      | No      | Yes   |
| Gaussian/16_rev_c0-Linda             | AVX         | No           | SMP + Linda     | IT4I compiled       | No      | No      | No    |

Speedup may be observed on Barbora and DGX-2 systems when using the `CascadeLake` and `GPU` modules compared to the `binary` module.

## Running

Gaussian is compiled for single node parallel execution as well as multi-node parallel execution using Linda.
GPU support for V100 cards is available on Barbora and DGX-2.

!!! note
    By default, the execution is single-core, single-node, and without GPU acceleration.

### Shared-Memory Multiprocessor Parallel Execution (Single Node)

Load module

```bash
$ ml Gaussian/16_rev_c0-binary
```

In the input file Link0 header section, set the CPU cores (24 for Salomon, 36 for Barbora, 48 for DGX-2) and memory amount.

```bash
%CPU=0-35
%Mem=8GB
```

### Cluster/Network Parallel Execution (Multi Node)

Load Linda-enabled module

```bash
$ ml Gaussian/16_rev_c0-binary-Linda
```

The network parallelization environment is **Linda**.
In the input file Link0 header section, set the CPU cores (24 for Salomon, 36 for Barbora, 48 for DGX-2) and memory amount.
Include the `%UseSSH` keyword, as well. This enables Linda to spawn parallel workers.

```bash
%CPU=0-35
%Mem=8GB
%UseSSH
```

The number and placement of Linda workers may be controlled by %LindaWorkers keyword or by
GAUSS_WDEF environment variable. When running multi-node job via the PBS batch queue, loading
the Linda-enabled module **automatically sets the `GAUSS_WDEF` variable** to the correct node-list, using one worker per node.
In combination with the %CPU keyword, this enables a full-scale multi-node execution.

```bash
$ echo $GAUSS_WDEF
```

If a different amount of Linda workers is required, unset or modify
the GAUSS_WDEF environment variable accordingly.

### GPU-Accelerated Execution (Single Node/Multi Node)

#### Karolina

At this time, GPU-accelereated execution on Karolina is not available, since Gaussian 16 does not support NVIDIA A100 GPUs.

#### Barbora

On Barbora, the GPU acceleration may be combined with the Linda parallelization.
Load Linda-enabled binary module:

```bash
$ ml Gaussian/16_rev_c0-binary-Linda
```

or GPU-enabled module:

```bash
$ ml Gaussian/16_rev_c0-GPU-Linda
```

In the input file Link0 header section, set the CPU cores (24 for Barbora GPU nodes) and memory.
To enable GPU acceleration, set the `%GPUCPU` keyword. This keyword activates GPU accelerators and dedicates CPU cores to drive the GPU accelerators.
On Barbora GPU nodes, we activate GPUs 0-3 and assign cores 0, 2, 12, 14 (two from each CPU socket) to drive the accelerators.
If multi-node computation is intended, include the `%UseSSH` keyword, as well. This enables Linda to spawn parallel workers.

```bash
%CPU=0-23
%GPUCPU=0-3=0,2,12,14
%Mem=8GB
%UseSSH
```

#### DGX-2

GPU-accelerated calculations on the **DGX-2** are supported with Gaussian binary module:

```bash
$ ml Gaussian/16_rev_c0-binary
```

Or IT4I-compiled module

```bash
$ ml Gaussian/16_rev_c0-GPU
```

In the input file Link0 header section, modify the `%CPU` keyword to 48 cores and the `%GPUCPU` keyword to 16 GPU accelerators. Omit the Linda.

```bash
%CPU=0-47
%GPUCPU=0-15=0,2,4,6,8,10,12,14,24,26,28,30,32,34,36,38
%Mem=512GB
```

### Example Input File

This example input file sets water molecule geometry optimization and vibrational frequencies computation
using 36 cores (on Barbora supercomputer) and Linda parallelization.

```bash
%CPU=0-35
%Mem=8GB
%UseSSH
#p rb3lyp/6-31G* test opt freq

Gaussian Test Job:
WATER H20 optimization

 0 1
 O
 H 1 R
 H 1 R 2 A

R 0.96
A 109.471221

```

### Run Gaussian (All Modes)

Set a scratch directory:

```bash
$ GAUSS_SCRDIR=/scratch/work/project/open-0-0/GaussianJob # on Salomon
$ GAUSS_SCRDIR=/scratch/project/open-0-0/GaussianJob # on Barbora
```

Copy files from a local home to the scratch directory:

```bash
cp * $GAUSS_SCRDIR/
```

Run Gaussian:

```bash
cd $GAUSS_SCRDIR
g16 < input.inp > output.out
```

After the calculation, you can move the data back to your home directory and delete the scratch folder.
For more details, see the [Gaussian documentation][c].

### Example Jobscript

This jobscript will run parallel Gaussian job on Salomon supercomputer, using 4 nodes (4*24 = 96 cores) via Linda. The Linda workers are set
up automatically by the module load.

```bash
#!/bin/bash
#PBS -A OPEN-0-0
#PBS -q qprod -N MyJobName
#PBS -l select=4

# change to workdir
cd $PBS_O_WORKDIR

# load Gaussian Linda enabled module and set up Linda
ml Gaussian/16_rev_c0-binary-Linda

# create scratch folder and copy input files
GAUSS_SCRDIR=/scratch/work/project/open-0-0/GaussianJob
mkdir -p $GAUSS_SCRDIR
cd $GAUSS_SCRDIR || exit
cp $PBS_O_WORKDIR/* .

# run Gaussian calculation
# g16 < input.inp > output.out

# run Gaussian from stdin
g16 << EOF > output.out
%CPU=0-23
%Mem=8GB
%UseSSH
#p rb3lyp/6-31G* test opt freq

Gaussian Test Job:
WATER H20 optimization

 0 1
 O
 H 1 R
 H 1 R 2 A

R 0.96
A 109.471221


EOF

# copy output files to home
	cp * $PBS_O_WORKDIR/. && cd ../

# delete scratch directory
rm -rf $GAUSS_SCRDIR

#end
exit
```

[1]: ../../salomon/storage.md

[a]: https://gaussian.com/gaussian16/
[b]: mailto:support@it4i.cz
[c]: https://gaussian.com/man/
