# Storage

There are two main shared file systems on Anselm cluster, the [HOME][1] and [SCRATCH][2]. All login and compute nodes may access same data on shared file systems. Compute nodes are also equipped with local (non-shared) scratch, RAM disk, and tmp file systems.

## Archiving

Do not use shared filesystems as a backup for large amount of data or long-term archiving mean. The academic staff and students of research institutions in the Czech Republic can use [CESNET storage service][3], which is available via SSHFS.

## Shared Filesystems

Anselm computer provides two main shared filesystems, the [HOME filesystem][1] and the [SCRATCH filesystem][2]. Both HOME and SCRATCH filesystems are realized as a parallel Lustre filesystem. Both shared file systems are accessible via the Infiniband network. Extended ACLs are provided on both Lustre filesystems for sharing data with other users using fine-grained control.

### Understanding the Lustre Filesystems

A user file on the [Lustre filesystem][a] can be divided into multiple chunks (stripes) and stored across a subset of the object storage targets (OSTs) (disks). The stripes are distributed among the OSTs in a round-robin fashion to ensure load balancing.

When a client (a compute node from your job) needs to create or access a file, the client queries the metadata server (MDS) and the metadata target (MDT) for the layout and location of the [file's stripes][b]. Once the file is opened and the client obtains the striping information, the MDS is no longer involved in the file I/O process. The client interacts directly with the object storage servers (OSSes) and OSTs to perform I/O operations such as locking, disk allocation, storage, and retrieval.

If multiple clients try to read and write the same part of a file at the same time, the Lustre distributed lock manager enforces coherency so that all clients see consistent results.

There is a default stripe configuration for Anselm Lustre filesystems. However, users can set the following stripe parameters for their own directories or files to get optimum I/O performance:

1. stripe_size: the size of the chunk in bytes; specify with k, m, or g to use units of KB, MB, or GB, respectively; the size must be an even multiple of 65,536 bytes; default is 1MB for all Anselm Lustre filesystems
1. stripe_count the number of OSTs to stripe across; default is 1 for Anselm Lustre filesystems one can specify -1 to use all OSTs in the filesystem.
1. stripe_offset The index of the OST where the first stripe is to be placed; default is -1 which results in random selection; using a non-default value is NOT recommended.

!!! note
    Setting stripe size and stripe count correctly may significantly affect the I/O performance.

Use the lfs getstripe to get the stripe parameters. Use the lfs setstripe command to set the stripe parameters for optimal I/O performance. The correct stripe setting depends on your needs and file access patterns.

```console
$ lfs getstripe dir|filename
$ lfs setstripe -s stripe_size -c stripe_count -o stripe_offset dir|filename
```

Example:

```console
$ lfs getstripe /scratch/username/
/scratch/username/
stripe_count:   1 stripe_size:    1048576 stripe_offset:  -1

$ lfs setstripe -c -1 /scratch/username/
$ lfs getstripe /scratch/username/
/scratch/username/
stripe_count:  10 stripe_size:    1048576 stripe_offset:  -1
```

In this example, we view the current stripe setting of the /scratch/username/ directory. The stripe count is changed to all OSTs and verified. All files written to this directory will be striped over 10 OSTs.

Use lfs check OSTs to see the number and status of active OSTs for each filesystem on Anselm. Learn more by reading the man page:

```console
$ lfs check osts
$ man lfs
```

### Hints on Lustre Stripping

!!! note
    Increase the stripe_count for parallel I/O to the same file.

When multiple processes are writing blocks of data to the same file in parallel, the I/O performance for large files will improve when the stripe_count is set to a larger value. The stripe count sets the number of OSTs to which the file will be written. By default, the stripe count is set to 1. While this default setting provides for efficient access of metadata (for example to support the ls -l command), large files should use stripe counts of greater than 1. This will increase the aggregate I/O bandwidth by using multiple OSTs in parallel instead of just one. A rule of thumb is to use a stripe count approximately equal to the number of gigabytes in the file.

Another good practice is to make the stripe count be an integral factor of the number of processes performing the write in parallel, so that you achieve load balance among the OSTs. For example, set the stripe count to 16 instead of 15 when you have 64 processes performing the writes.

!!! note
    Using a large stripe size can improve performance when accessing very large files.

Large stripe size allows each client to have exclusive access to its own part of a file. However, it can be counterproductive in some cases if it does not match your I/O pattern. The choice of stripe size has no effect on a single-stripe file.

Read more [here][c].

### Lustre on Anselm

The architecture of Lustre on Anselm is composed of two metadata servers (MDS) and four data/object storage servers (OSS). Two object storage servers are used for file system HOME and another two object storage servers are used for file system SCRATCH.

 Configuration of the storages

* HOME Lustre object storage
  * One disk array NetApp E5400
  * 22 OSTs
  * 227 2TB NL-SAS 7.2krpm disks
  * 22 groups of 10 disks in RAID6 (8+2)
  * 7 hot-spare disks
* SCRATCH Lustre object storage
  * Two disk arrays NetApp E5400
  * 10 OSTs
  * 106 2TB NL-SAS 7.2krpm disks
  * 10 groups of 10 disks in RAID6 (8+2)
  * 6 hot-spare disks
* Lustre metadata storage
  * One disk array NetApp E2600
  * 12 300GB SAS 15krpm disks
  * 2 groups of 5 disks in RAID5
  * 2 hot-spare disks

### HOME File System

The HOME filesystem is mounted in directory /home. Users home directories /home/username reside on this filesystem. Accessible capacity is 320TB, shared among all users. Individual users are restricted by filesystem usage quotas, set to 250GB per user. If 250GB should prove as insufficient for particular user, contact [support][d], the quota may be lifted upon request.

!!! note
    The HOME filesystem is intended for preparation, evaluation, processing and storage of data generated by active Projects.

The HOME filesystem should not be used to archive data of past Projects or other unrelated data.

The files on HOME filesystem will not be deleted until the end of the [user's lifecycle][4].

The filesystem is backed up, such that it can be restored in case of catastrophic failure resulting in significant data loss. This backup however is not intended to restore old versions of user data or to restore (accidentally) deleted files.

The HOME filesystem is realized as Lustre parallel filesystem and is available on all login and computational nodes.
Default stripe size is 1MB, stripe count is 1. There are 22 OSTs dedicated for the HOME filesystem.

!!! note
    Setting stripe size and stripe count correctly for your needs may significantly affect the I/O performance.

| HOME filesystem      |        |
| -------------------- | ------ |
| Mountpoint           | /home  |
| Capacity             | 320 TB |
| Throughput           | 2 GB/s |
| User space quota     | 250 GB |
| User inodes quota    | 500 k  |
| Default stripe size  | 1 MB   |
| Default stripe count | 1      |
| Number of OSTs       | 22     |

### SCRATCH File System

The SCRATCH filesystem is mounted in directory /scratch. Users may freely create subdirectories and files on the filesystem. Accessible capacity is 146TB, shared among all users. Individual users are restricted by filesystem usage quotas, set to 100TB per user. The purpose of this quota is to prevent runaway programs from filling the entire filesystem and deny service to other users. If 100TB should prove as insufficient for particular user, contact [support][d], the quota may be lifted upon request.

!!! note
    The Scratch filesystem is intended for temporary scratch data generated during the calculation as well as for high performance access to input and output files. All I/O intensive jobs must use the SCRATCH filesystem as their working directory.

    Users are advised to save the necessary data from the SCRATCH filesystem to HOME filesystem after the calculations and clean up the scratch files.

!!! warning
    Files on the SCRATCH filesystem that are **not accessed for more than 90 days** will be automatically **deleted**.

The SCRATCH filesystem is realized as Lustre parallel filesystem and is available from all login and computational nodes. Default stripe size is 1MB, stripe count is 1. There are 10 OSTs dedicated for the SCRATCH filesystem.

!!! note
    Setting stripe size and stripe count correctly for your needs may significantly affect the I/O performance.

| SCRATCH filesystem   |          |
| -------------------- | -------- |
| Mountpoint           | /scratch |
| Capacity             | 146 TB   |
| Throughput           | 6 GB/s   |
| User space quota     | 100 TB   |
| User inodes quota    | 10 M     |
| Default stripe size  | 1 MB     |
| Default stripe count | 1        |
| Number of OSTs       | 10       |

### Disk Usage and Quota Commands

Disk usage and user quotas can be checked and reviewed using the following command:

```console
$ it4i-disk-usage
```

Example:

```console
$ it4i-disk-usage -h
# Using human-readable format
# Using power of 1024 for space
# Using power of 1000 for entries

Filesystem:    /home
Space used:    112GiB
Space limit:   238GiB
Entries:       15K
Entries limit: 500K

Filesystem:    /scratch
Space used:    0
Space limit:   93TiB
Entries:       0
Entries limit: 10M
```

In this example, we view current size limits and space occupied on the /home and /scratch filesystem, for a particular user executing the command.
Note that limits are imposed also on number of objects (files, directories, links, etc...) that are allowed to create.

To have a better understanding of where the space is exactly used, you can use following command to find out.

```console
$ du -hs dir
```

Example for your HOME directory:

```console
$ cd /home
$ du -hs * .[a-zA-z0-9]* | grep -E "[0-9]*G|[0-9]*M" | sort -hr
258M     cuda-samples
15M      .cache
13M      .mozilla
5,5M     .eclipse
2,7M     .idb_13.0_linux_intel64_app
```

This will list all directories that have MegaBytes or GigaBytes of consumed space in your actual (in this example HOME) directory. List is sorted in descending order from largest to smallest files/directories.

To have a better understanding of previous commands, you can read man pages:

```console
$ man lfs
```

```console
$ man du
```

### Extended ACLs

Extended ACLs provide another security mechanism beside the standard POSIX ACLs that are defined by three entries (for owner/group/others). Extended ACLs have more than the three basic entries. In addition, they also contain a mask entry and may contain any number of named user and named group entries.

ACLs on a Lustre file system work exactly like ACLs on any Linux file system. They are manipulated with the standard tools in the standard manner. Below, we create a directory and allow a specific user access.

```console
[vop999@login1.anselm ~]$ umask 027
[vop999@login1.anselm ~]$ mkdir test
[vop999@login1.anselm ~]$ ls -ld test
drwxr-x--- 2 vop999 vop999 4096 Nov 5 14:17 test
[vop999@login1.anselm ~]$ getfacl test
# file: test
# owner: vop999
# group: vop999
user::rwx
group::r-x
other::---

[vop999@login1.anselm ~]$ setfacl -m user:johnsm:rwx test
[vop999@login1.anselm ~]$ ls -ld test
drwxrwx---+ 2 vop999 vop999 4096 Nov 5 14:17 test
[vop999@login1.anselm ~]$ getfacl test
# file: test
# owner: vop999
# group: vop999
user::rwx
user:johnsm:rwx
group::r-x
mask::rwx
other::---
```

Default ACL mechanism can be used to replace setuid/setgid permissions on directories. Setting a default ACL on a directory (-d flag to setfacl) will cause the ACL permissions to be inherited by any newly created file or subdirectory within the directory. For more information, see [ACL in Linux][e].

## Local Filesystems

### Local Scratch

!!! note
    Every computational node is equipped with 330GB local scratch disk.

Use local scratch in case you need to access large amount of small files during your calculation.

The local scratch disk is mounted as /lscratch and is accessible to user at /lscratch/$PBS_JOBID directory.

The local scratch filesystem is intended for temporary scratch data generated during the calculation as well as for high performance access to input and output files. All I/O intensive jobs that access large number of small files within the calculation must use the local scratch filesystem as their working directory. This is required for performance reasons, as frequent access to number of small files may overload the metadata servers (MDS) of the Lustre filesystem.

!!! note
    The local scratch directory /lscratch/$PBS_JOBID will be deleted immediately after the calculation end. Users should take care to save the output data from within the jobscript.

| local SCRATCH filesystem |                      |
| ------------------------ | -------------------- |
| Mountpoint               | /lscratch            |
| Accesspoint              | /lscratch/$PBS_JOBID |
| Capacity                 | 330 GB               |
| Throughput               | 100 MB/s             |
| User quota               | none                 |

### RAM Disk

Every computational node is equipped with filesystem realized in memory, so called RAM disk.

!!! note
    Use RAM disk in case you need a fast access to your data of limited size during your calculation. Be very careful, use of RAM disk filesystem is at the expense of operational memory.

The local RAM disk is mounted as /ramdisk and is accessible to user at /ramdisk/$PBS_JOBID directory.

The local RAM disk filesystem is intended for temporary scratch data generated during the calculation as well as for high performance access to input and output files. Size of RAM disk filesystem is limited. Be very careful, use of RAM disk filesystem is at the expense of operational memory.  It is not recommended to allocate large amount of memory and use large amount of data in RAM disk filesystem at the same time.

!!! note
    The local RAM disk directory /ramdisk/$PBS_JOBID will be deleted immediately after the calculation end. Users should take care to save the output data from within the jobscript.

| RAM disk    |                                                                                                          |
| ----------- | -------------------------------------------------------------------------------------------------------- |
| Mountpoint  | /ramdisk                                                                                                 |
| Accesspoint | /ramdisk/$PBS_JOBID                                                                                      |
| Capacity    | 60 GB at compute nodes without accelerator, 90 GB at compute nodes with accelerator, 500 GB at fat nodes |
| Throughput  | over 1.5 GB/s write, over 5 GB/s read, single thread, over 10 GB/s write, over 50 GB/s read, 16 threads  |
| User quota  | none                                                                                                     |

### TMP

Each node is equipped with local /tmp directory of few GB capacity. The /tmp directory should be used to work with small temporary files. Old files in /tmp directory are automatically purged.

## Summary

| Mountpoint | Usage                     | Protocol | Net Capacity   | Throughput | Space/Inodes quota       | Access                  | Services                    |        |
| ---------- | ------------------------- | -------- | -------------- | ---------- | ------------------------ | ----------------------- | --------------------------- | ------ |
| /home      | home directory            | Lustre   | 320 TiB        | 2 GB/s     | 250&nbsp;GB / 500&nbsp;k | Compute and login nodes | backed up                   |        |
| /scratch   | cluster shared jobs' data | Lustre   | 146 TiB        | 6 GB/s     | 100&nbsp;TB / 10&nbsp;M  | Compute and login nodes | files older 90 days removed |        |
| /lscratch  | node local jobs' data     | local    | 330 GB         | 100 MB/s   | none / none              | Compute nodes           | purged after job ends       |        |
| /ramdisk   | node local jobs' data     | local    | 60, 90, 500 GB | 5-50 GB/s  | none / none              | Compute nodes           | purged after job ends       |        |
| /tmp       | local temporary files     | local    | 9.5 GB         | 100 MB/s   | none / none              | Compute and login nodes | auto                        | purged |

## CESNET Data Storage

Do not use shared filesystems at IT4Innovations as a backup for large amount of data or long-term archiving purposes.

!!! note
    The IT4Innovations does not provide storage capacity for data archiving. Academic staff and students of research institutions in the Czech Republic can use [CESNET Storage service][f].

The CESNET Storage service can be used for research purposes, mainly by academic staff and students of research institutions in the Czech Republic.

User of data storage CESNET (DU) association can become organizations or an individual person who is in the current employment relationship (employees) or the current study relationship (students) to a legal entity (organization) that meets the “Principles for access to CESNET Large infrastructure (Access Policy)”.

User may only use data storage CESNET for data transfer and storage associated with activities in science, research, development, spread of education, culture and prosperity. For details, see "Acceptable Use Policy CESNET Large Infrastructure (Acceptable Use Policy, AUP)".

The service is documented [here][g]. For special requirements contact directly CESNET Storage Department via e-mail [du-support(at)cesnet.cz][h].

The procedure to obtain the CESNET access is quick and trouble-free.

## CESNET Storage Access

### Understanding CESNET Storage

!!! note
    It is very important to understand the CESNET storage before uploading data. [Read][i] first.

Once registered for CESNET Storage, you may [access the storage][j] in number of ways. We recommend the SSHFS and RSYNC methods.

### SSHFS Access

!!! note
    SSHFS: The storage will be mounted like a local hard drive

The SSHFS provides a very convenient way to access the CESNET Storage. The storage will be mounted onto a local directory, exposing the vast CESNET Storage as if it was a local removable hard drive. Files can be than copied in and out in a usual fashion.

First, create the mount point

```console
$ mkdir cesnet
```

Mount the storage. Note that you can choose among the ssh.du1.cesnet.cz (Plzen), ssh.du2.cesnet.cz (Jihlava), ssh.du3.cesnet.cz (Brno) Mount tier1_home **(only 5120 MB!)**:

```console
$ sshfs username@ssh.du1.cesnet.cz:. cesnet/
```

For easy future access from Anselm, install your public key

```console
$ cp .ssh/id_rsa.pub cesnet/.ssh/authorized_keys
```

Mount tier1_cache_tape for the Storage VO:

```console
$ sshfs username@ssh.du1.cesnet.cz:/cache_tape/VO_storage/home/username cesnet/
```

View the archive, copy the files and directories in and out

```console
$ ls cesnet/
$ cp -a mydir cesnet/.
$ cp cesnet/myfile .
```

Once done, remember to unmount the storage

```console
$ fusermount -u cesnet
```

### RSYNC Access

!!! info
    RSYNC provides delta transfer for best performance and can resume interrupted transfers.

RSYNC is a fast and extraordinarily versatile file copying tool. It is famous for its delta-transfer algorithm, which reduces the amount of data sent over the network by sending only the differences between the source files and the existing files in the destination.  RSYNC is widely used for backups and mirroring and as an improved copy command for everyday use.

RSYNC finds files that need to be transferred using a "quick check" algorithm (by default) that looks for files that have changed in size or in last-modified time.  Any changes in the other preserved attributes (as requested by options) are made on the destination file directly when the quick check indicates that the file's data does not need to be updated.

[More about RSYNC][k].

Transfer large files to/from CESNET storage, assuming membership in the Storage VO:

```console
$ rsync --progress datafile username@ssh.du1.cesnet.cz:VO_storage-cache_tape/.
$ rsync --progress username@ssh.du1.cesnet.cz:VO_storage-cache_tape/datafile .
```

Transfer large directories to/from CESNET storage, assuming membership in the Storage VO:

```console
$ rsync --progress -av datafolder username@ssh.du1.cesnet.cz:VO_storage-cache_tape/.
$ rsync --progress -av username@ssh.du1.cesnet.cz:VO_storage-cache_tape/datafolder .
```

Transfer rates of about 28 MB/s can be expected.

[1]: #home
[2]: #scratch
[3]: #cesnet-data-storage
[4]: ../general/obtaining-login-credentials/obtaining-login-credentials.md

[a]: http://www.nas.nasa.gov
[b]: http://www.nas.nasa.gov/hecc/support/kb/Lustre_Basics_224.html#striping
[c]: http://doc.lustre.org/lustre_manual.xhtml#managingstripingfreespace
[d]: https://support.it4i.cz/rt
[e]: https://www.geeksforgeeks.org/access-control-listsacl-linux/
[f]: https://du.cesnet.cz/
[g]: https://du.cesnet.cz/en/start
[h]: mailto:du-support@cesnet.cz
[i]: https://du.cesnet.cz/en/navody/home-migrace-plzen/start
[j]: https://du.cesnet.cz/en/navody/faq/start
[k]: https://du.cesnet.cz/en/navody/rsync/start#pro_bezne_uzivatele
