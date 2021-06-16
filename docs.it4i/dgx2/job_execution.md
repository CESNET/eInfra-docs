# Resource Allocation and Job Execution

To run a job, computational resources of DGX-2 must be allocated.

## Resources Allocation Policy

The resources are allocated to the job in a fair-share fashion, subject to constraints set by the queue. The queue provides prioritized and exclusive access to computational resources.

The queue for the DGX-2 machine is called **qdgx**.

!!! note
    The qdgx queue is configured to run one job and accept one job in a queue per user with the maximum walltime of a job being **48** hours.

## Job Submission and Execution

The `qsub` submits the job into the queue. The command creates a request to the PBS Job manager for allocation of specified resources. The resources will be allocated when available, subject to allocation policies and constraints. After the resources are allocated, the jobscript or interactive shell is executed on the allocated node.

### Job Submission

When allocating computational resources for the job, specify:

1. a queue for your job (the default is **qdgx**);
1. the maximum wall time allocated to your calculation (default is **4 hour**, maximum is **48 hour**);
1. a jobscript or interactive switch.

!!! info
    You can access the DGX PBS scheduler by loading the "DGX-2" module.

Submit the job using the `qsub` command:

**Example**

```console
[kru0052@login2.barbora ~]$ qsub -q qdgx -l walltime=02:00:00 -I
qsub: waiting for job 258.dgx to start
qsub: job 258.dgx ready

kru0052@cn202:~$ nvidia-smi
Wed Jun 16 07:46:32 2021
+-----------------------------------------------------------------------------+
|  NVIDIA-SMI 465.19.01    Driver Version: 465.19.01    CUDA Version: 11.3    |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Tesla V100-SXM3...  On   | 00000000:34:00.0 Off |                    0 |
| N/A   32C    P0    51W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   1  Tesla V100-SXM3...  On   | 00000000:36:00.0 Off |                    0 |
| N/A   31C    P0    48W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   2  Tesla V100-SXM3...  On   | 00000000:39:00.0 Off |                    0 |
| N/A   35C    P0    53W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   3  Tesla V100-SXM3...  On   | 00000000:3B:00.0 Off |                    0 |
| N/A   36C    P0    53W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   4  Tesla V100-SXM3...  On   | 00000000:57:00.0 Off |                    0 |
| N/A   29C    P0    50W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   5  Tesla V100-SXM3...  On   | 00000000:59:00.0 Off |                    0 |
| N/A   35C    P0    51W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   6  Tesla V100-SXM3...  On   | 00000000:5C:00.0 Off |                    0 |
| N/A   30C    P0    50W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   7  Tesla V100-SXM3...  On   | 00000000:5E:00.0 Off |                    0 |
| N/A   35C    P0    53W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   8  Tesla V100-SXM3...  On   | 00000000:B7:00.0 Off |                    0 |
| N/A   30C    P0    50W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|   9  Tesla V100-SXM3...  On   | 00000000:B9:00.0 Off |                    0 |
| N/A   30C    P0    51W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|  10  Tesla V100-SXM3...  On   | 00000000:BC:00.0 Off |                    0 |
| N/A   35C    P0    51W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|  11  Tesla V100-SXM3...  On   | 00000000:BE:00.0 Off |                    0 |
| N/A   35C    P0    50W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|  12  Tesla V100-SXM3...  On   | 00000000:E0:00.0 Off |                    0 |
| N/A   31C    P0    50W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|  13  Tesla V100-SXM3...  On   | 00000000:E2:00.0 Off |                    0 |
| N/A   29C    P0    51W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|  14  Tesla V100-SXM3...  On   | 00000000:E5:00.0 Off |                    0 |
| N/A   34C    P0    51W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
|  15  Tesla V100-SXM3...  On   | 00000000:E7:00.0 Off |                    0 |
| N/A   34C    P0    50W / 350W |      0MiB / 32480MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
kru0052@cn202:~$ exit
```

!!! tip
    Submit the interactive job using the `qsub -I ...` command.

### Job Execution

The DGX-2 machine runs only a bare-bone, minimal operating system. Users are expected to run
**[singularity][1]** containers in order to enrich the environment according to the needs.

Containers (Docker images) optimized for DGX-2 may be downloaded from
[NVIDIA Gpu Cloud][2]. Select the code of interest and
copy the docker nvcr.io link from the Pull Command section. This link may be directly used
to download the container via singularity, see the example below:

#### Example - Singularity Run Tensorflow

```console
[kru0052@login2.barbora ~]$ qsub -q qdgx -l walltime=01:00:00 -I
qsub: waiting for job 96.dgx to start
qsub: job 96.dgx ready

kru0052@cn202:~$ singularity shell docker://nvcr.io/nvidia/tensorflow:19.02-py3
Singularity tensorflow_19.02-py3.sif:~>
Singularity tensorflow_19.02-py3.sif:~> mpiexec --bind-to socket -np 16 python /opt/tensorflow/nvidia-examples/cnn/resnet.py --layers=18 --precision=fp16 --batch_size=512
PY 3.5.2 (default, Nov 12 2018, 13:43:14)
[GCC 5.4.0 20160609]
TF 1.13.0-rc0
PY 3.5.2 (default, Nov 12 2018, 13:43:14)
[GCC 5.4.0 20160609]
TF 1.13.0-rc0
PY 3.5.2 (default, Nov 12 2018, 13:43:14)
[GCC 5.4.0 20160609]
TF 1.13.0-rc0
PY 3.5.2 (default, Nov 12 2018, 13:43:14)
[GCC 5.4.0 20160609]
TF 1.13.0-rc0
PY 3.5.2 (default, Nov 12 2018, 13:43:14)
[GCC 5.4.0 20160609]
TF 1.13.0-rc0
PY 3.5.2 (default, Nov 12 2018, 13:43:14)
[GCC 5.4.0 20160609]
...
...
...
2019-03-11 08:30:12.263822: I tensorflow/stream_executor/dso_loader.cc:152] successfully opened CUDA library libcublas.so.10.0 locally
     1   1.0   338.2  6.999  7.291 2.00000
    10  10.0  3658.6  5.658  5.950 1.62000
    20  20.0 25628.6  2.957  3.258 1.24469
    30  30.0 30815.1  0.177  0.494 0.91877
    40  40.0 30826.3  0.004  0.330 0.64222
    50  50.0 30884.3  0.002  0.327 0.41506
    60  60.0 30888.7  0.001  0.325 0.23728
    70  70.0 30763.2  0.001  0.324 0.10889
    80  80.0 30845.5  0.001  0.324 0.02988
    90  90.0 26350.9  0.001  0.324 0.00025
kru0052@cn202:~$ exit
```

**GPU stat**

The GPU load can be determined by the `gpustat` utility.

```console
Every 2,0s: gpustat --color

dgx  Mon Mar 11 09:31:00 2019
[0] Tesla V100-SXM3-32GB | 47'C,  96 % | 23660 / 32480 MB | kru0052(23645M)
[1] Tesla V100-SXM3-32GB | 48'C,  96 % | 23660 / 32480 MB | kru0052(23645M)
[2] Tesla V100-SXM3-32GB | 56'C,  97 % | 23660 / 32480 MB | kru0052(23645M)
[3] Tesla V100-SXM3-32GB | 57'C,  97 % | 23660 / 32480 MB | kru0052(23645M)
[4] Tesla V100-SXM3-32GB | 46'C,  97 % | 23660 / 32480 MB | kru0052(23645M)
[5] Tesla V100-SXM3-32GB | 55'C,  96 % | 23660 / 32480 MB | kru0052(23645M)
[6] Tesla V100-SXM3-32GB | 45'C,  96 % | 23660 / 32480 MB | kru0052(23645M)
[7] Tesla V100-SXM3-32GB | 54'C,  97 % | 23660 / 32480 MB | kru0052(23645M)
[8] Tesla V100-SXM3-32GB | 45'C,  96 % | 23660 / 32480 MB | kru0052(23645M)
[9] Tesla V100-SXM3-32GB | 46'C,  95 % | 23660 / 32480 MB | kru0052(23645M)
[10] Tesla V100-SXM3-32GB | 55'C,  96 % | 23660 / 32480 MB | kru0052(23645M)
[11] Tesla V100-SXM3-32GB | 56'C,  96 % | 23660 / 32480 MB | kru0052(23645M)
[12] Tesla V100-SXM3-32GB | 47'C,  95 % | 23660 / 32480 MB | kru0052(23645M)
[13] Tesla V100-SXM3-32GB | 45'C,  96 % | 23660 / 32480 MB | kru0052(23645M)
[14] Tesla V100-SXM3-32GB | 55'C,  96 % | 23660 / 32480 MB | kru0052(23645M)
[15] Tesla V100-SXM3-32GB | 58'C,  95 % | 23660 / 32480 MB | kru0052(23645M)
```

[1]: https://docs.it4i.cz/software/tools/singularity/
[2]: https://ngc.nvidia.com/
