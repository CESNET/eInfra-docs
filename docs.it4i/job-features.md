# Job Features

Special features installed/configured on the fly on allocated nodes, features are requested in PBS job.

```console
$ qsub... -l feature=req
```

## Xorg

[Xorg][2] is a free and open source implementation of the X Window System imaging server maintained by the X.Org Foundation. Xorg is vailable only for Karolina accelerated nodes Acn[01-72].

```console
$ qsub ... -l xorg=True
```

## VTune Support

Load the VTune kernel modules.

```console
$ qsub ... -l vtune=version_string
```

`version_string` is VTune version e.g. 2019_update4

## Global RAM Disk

The Global RAM disk deploys BeeGFS On Demand parallel filesystem,
using local (i.e. allocated nodes') RAM disks as a storage backend.

The Global RAM disk is mounted at `/mnt/global_ramdisk`.

```console
$ qsub ... -l global_ramdisk=true
```

![Global RAM disk](../img/global_ramdisk.png)

### Example

```console
$ qsub -q qprod -l select=4,global_ramdisk=true ./jobscript
```

This command submits a 4-node job in the `qprod` queue;
once running, a 440GB RAM disk shared across the 4 nodes will be created.
The RAM disk will be accessible at `/mnt/global_ramdisk`
and files written to this RAM disk will be visible on all 4 nodes.

The file system is private to a job and shared among the nodes,
created when the job starts and deleted at the job's end.

!!! note
    The Global RAM disk will be deleted immediately after the calculation end.
    Users should take care to save the output data from within the jobscript.

The files on the Global RAM disk will be equally striped across all the nodes, using 512k stripe size.
Check the Global RAM disk status:

```console
$ beegfs-df -p /mnt/global_ramdisk
$ beegfs-ctl --mount=/mnt/global_ramdisk --getentryinfo /mnt/global_ramdisk
```

Use Global RAM disk in case you need very large RAM disk space.
The Global RAM disk allows for high performance sharing of data among compute nodes within a job.

!!! warning
     Use of Global RAM disk file system is at the expense of operational memory.

| Global RAM disk    |                                                                           |
| ------------------ | --------------------------------------------------------------------------|
| Mountpoint         | /mnt/global_ramdisk                                                       |
| Accesspoint        | /mnt/global_ramdisk                                                       |
| Capacity           | Salomon (Nx110)GB<br>Barbora (Nx180)GB                                    |
| User quota         | none                                                                      |

N = number of compute nodes in the job.

!!! Warning
    Available on Salomon and Barbora nodes only.

## Virtualization Network

Configure network for virtualization, create interconnect for fast communication between node (host) and virtual machine (guest).

```console
$ qsub ... -l virt_network=true
```

!!! Warning
    Available on Salomon nodes only.

[See Tap Interconnect][1]

## MSR-SAFE Support

Load a kernel module that allows saving/restoring values of MSR registers. Uses LLNL MSR-SAFE.

```console
$ qsub ... -l msr=version_string
```

`version_string` is MSR-SAFE version e.g. 1.4.0

!!! Danger
    Hazardous, it causes CPU frequency disruption.

!!! Warning
    Available on Salomon and Barbora nodes only.

## x86 Adapt Support

Load a kernel module that allows changing/toggling system parameters stored in MSR and PCI registers of x86 processors.

```console
$ qsub ... -l x86_adapt=true
```

!!! Danger
    Hazardous, it causes CPU frequency disruption.

!!! Warning
    Available on Salomon nodes only.

## Disabling Intel Turbo Boost on CPU

Intel Turbo Boost on CPU is enabled on all compute nodes.

To disable Intel Turbo Boost on CPU:

```console
$ qsub ... -l cpu_turbo_boost=false
```

!!! Warning
    Available on Salomon nodes only.

## Offlining CPU Cores

!!! Info
    Not available now.

To offline N CPU cores:

```console
$ qsub ... -l cpu_offline_cores=N
```

To offline CPU cores according to pattern:

```console
$ qsub ... -l cpu_offline_cores=PATTERN
```

where `PATTERN` is a list of core's numbers to offline, separated by the character 'c' (e.g. "5c11c16c23c").

!!! Danger
    Hazardous, it causes Lustre threads disruption.

## HDEEM Support

Load the HDEEM software stack. The High Definition Energy Efficiency Monitoring (HDEEM) library is a software interface used to measure power consumption of HPC clusters with bullx blades.

```console
$ qsub ... -l hdeem=version_string
```

`version_string` is HDEEM version e.g. 2.2.8-1

!!! Warning
    Available on Barbora nodes only.

## NVMe Over Fabrics File System

Attach a volume from an NVMe storage and mount it as a file-system. File-system is mounted on /mnt/nvmeof (on the first node of the job).
Barbora cluster provides two NVMeoF storage nodes equipped with NVMe disks. Each storage node contains seven 1.6TB NVMe disks and provides net aggregated capacity of 10.18TiB. Storage space is provided using the NVMe over Fabrics protocol; RDMA network i.e. InfiniBand is used for data transfers.

```console
$ qsub ... -l nvmeof=size
```

`size` is a size of the requested volume, PBS size conventions are used, e.g. 10t

Create a shared file-system on the attached NVMe file-system and make it available on all nodes of the job. Append `:shared` to the size specification, shared file-system is mounted on /mnt/nvmeof-shared.

```console
$ qsub ... -l nvmeof=size:shared
```

For example:

```console
$ qsub ... -l nvmeof=10t:shared
```

!!! Warning
    Available on Barbora nodes only.

## Smart Burst Buffer

Accelerate SCRATCH storage using the Smart Burst Buffer (SBB) technology. A specific Burst Buffer process is launched and Burst Buffer resources (CPUs, memory, flash storage) are allocated on an SBB storage node for acceleration (I/O caching) of SCRATCH data operations. The SBB profile file `/lscratch/$PBS_JOBID/sbb.sh` is created on the first allocated node of job. For SCRATCH acceleration, the SBB profile file has to be sourced into the shell environment - provided environment variables have to be defined in the process environment. Modified data is written asynchronously to a backend (Lustre) filesystem, writes might be proceeded after job termination.

Barbora cluster provides two SBB storage nodes equipped with NVMe disks. Each storage node contains ten 3.2TB NVMe disks and provides net aggregated capacity of 29.1TiB. Acceleration uses RDMA network i.e. InfiniBand is used for data transfers.

```console
$ qsub ... -l sbb=spec
```

`spec` specifies amount of resources requested for Burst Buffer (CPUs, memory, flash storage), available values are small, medium, and large

Loading SBB profile:

```console
$ source /lscratch/$PBS_JOBID/sbb.sh
```

!!! Warning
    Available on Barbora nodes only.

[1]: software/tools/virtualization.md#tap-interconnect
[2]: general/accessing-the-clusters/graphical-user-interface/xorg.md
