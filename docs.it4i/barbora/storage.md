# Storage

There are three main shared file systems on the Barbora cluster: [HOME][1], [SCRATCH][2], and [PROJECT][5]. All login and compute nodes may access same data on shared file systems. Compute nodes are also equipped with local (non-shared) scratch, RAM disk, and tmp file systems.

## Archiving

Do not use shared filesystems as a backup for large amount of data or long-term archiving mean. The academic staff and students of research institutions in the Czech Republic can use [CESNET storage service][3], which is available via SSHFS.

## Shared Filesystems

Barbora computer provides three main shared filesystems, the [HOME filesystem][1], [SCRATCH filesystem][2], and the [PROJECT filesystems][5].

All filesystems are accessible via the Infiniband network.

The HOME and PROJECT filesystems are realized as NFS filesystem.

The SCRATCH filesystem is realized as a parallel Lustre filesystem.

Extended ACLs are provided on both Lustre filesystems for sharing data with other users using fine-grained control

### Understanding the Lustre Filesystems

A user file on the [Lustre filesystem][a] can be divided into multiple chunks (stripes) and stored across a subset of the object storage targets (OSTs) (disks). The stripes are distributed among the OSTs in a round-robin fashion to ensure load balancing.

When a client (a compute node from your job) needs to create or access a file, the client queries the metadata server (MDS) and the metadata target (MDT) for the layout and location of the [file's stripes][b]. Once the file is opened and the client obtains the striping information, the MDS is no longer involved in the file I/O process. The client interacts directly with the object storage servers (OSSes) and OSTs to perform I/O operations such as locking, disk allocation, storage, and retrieval.

If multiple clients try to read and write the same part of a file at the same time, the Lustre distributed lock manager enforces coherency, so that all clients see consistent results.

There is default stripe configuration for Barbora Lustre filesystems. However, users can set the following stripe parameters for their own directories or files to get optimum I/O performance:

1. `stripe_size` the size of the chunk in bytes; specify with k, m, or g to use units of KB, MB, or GB, respectively; the size must be an even multiple of 65,536 bytes; default is 1MB for all Barbora Lustre filesystems
1. `stripe_count` the number of OSTs to stripe across; default is 1 for Barbora Lustre filesystems one can specify -1 to use all OSTs in the filesystem.
1. `stripe_offset` the index of the OST where the first stripe is to be placed; default is -1 which results in random selection; using a non-default value is NOT recommended.

!!! note
    Setting stripe size and stripe count correctly for your needs may significantly affect the I/O performance.

Use the `lfs getstripe` command for getting the stripe parameters. Use `lfs setstripe` for setting the stripe parameters to get optimal I/O performance. The correct stripe setting depends on your needs and file access patterns.

```console
$ lfs getstripe dir|filename
$ lfs setstripe -s stripe_size -c stripe_count -o stripe_offset dir|filename
```

Example:

```console
$ lfs getstripe /scratch/projname
$ lfs setstripe -c -1 /scratch/projname
$ lfs getstripe /scratch/projname
```

In this example, we view the current stripe setting of the /scratch/projname/ directory. The stripe count is changed to all OSTs and verified. All files written to this directory will be striped over 5 OSTs

Use `lfs check osts` to see the number and status of active OSTs for each filesystem on Barbora. Learn more by reading the man page:

```console
$ lfs check osts
$ man lfs
```

### Hints on Lustre Stripping

!!! note
    Increase the `stripe_count` for parallel I/O to the same file.

When multiple processes are writing blocks of data to the same file in parallel, the I/O performance for large files will improve when the `stripe_count` is set to a larger value. The stripe count sets the number of OSTs to which the file will be written. By default, the stripe count is set to 1. While this default setting provides for efficient access of metadata (for example to support the `ls -l` command), large files should use stripe counts of greater than 1. This will increase the aggregate I/O bandwidth by using multiple OSTs in parallel instead of just one. A rule of thumb is to use a stripe count approximately equal to the number of gigabytes in the file.

Another good practice is to make the stripe count be an integral factor of the number of processes performing the write in parallel, so that you achieve load balance among the OSTs. For example, set the stripe count to 16 instead of 15 when you have 64 processes performing the writes.

!!! note
    Using a large stripe size can improve performance when accessing very large files

Large stripe size allows each client to have exclusive access to its own part of a file. However, it can be counterproductive in some cases if it does not match your I/O pattern. The choice of stripe size has no effect on a single-stripe file.

Read more [here][c].

### Lustre on Barbora

The architecture of Lustre on Barbora is composed of two metadata servers (MDS) and two data/object storage servers (OSS).

 Configuration of the SCRATCH storage

* 2x Metadata server
* 2x Object storage server
* Lustre object storage
  * One disk array NetApp E2800
  * 54x 8TB 10kRPM 2,5” SAS HDD
  * 5 x RAID6(8+2) OST Object storage target
  * 4 hotspare
* Lustre metadata storage
  * One disk array NetApp E2600
  * 12 300GB SAS 15krpm disks
  * 2 groups of 5 disks in RAID5 Metadata target
  * 2 hot-spare disks

### HOME File System

The HOME filesystem is mounted in directory /home. Users home directories /home/username reside on this filesystem. Accessible capacity is 28TB, shared among all users. Individual users are restricted by filesystem usage quotas, set to 25GB per user. Should 25GB prove insufficient, contact [support][d], the quota may be lifted upon request.

!!! note
    The HOME filesystem is intended for preparation, evaluation, processing and storage of data generated by active Projects.

The HOME filesystem should not be used to archive data of past Projects or other unrelated data.

The files on HOME filesystem will not be deleted until the end of the [user's lifecycle][4].

The filesystem is backed up, so that it can be restored in case of a catastrophic failure resulting in significant data loss. However, this backup is not intended to restore old versions of user data or to restore (accidentally) deleted files.

| HOME filesystem      |                 |
| -------------------- | --------------- |
| Accesspoint          | /home/username  |
| Capacity             | 28TB           |
| Throughput           | 1GB/s          |
| User space quota     | 25GB           |
| User inodes quota    | 500K           |
| Protocol             | NFS             |

### SCRATCH File System

The SCRATCH is realized as Lustre parallel file system and is available from all login and computational nodes. There are 5 OSTs dedicated for the SCRATCH file system.

The SCRATCH filesystem is mounted in directory /scratch. Users may freely create subdirectories and files on the filesystem. Accessible capacity is 310TB, shared among all users. Individual users are restricted by filesystem usage quotas, set to 10TB per user. The purpose of this quota is to prevent runaway programs from filling the entire filesystem and deny service to other users. Should 10TB prove insufficient, contact [support][d], the quota may be lifted upon request.

!!! note
    The Scratch filesystem is intended for temporary scratch data generated during the calculation as well as for high-performance access to input and output files. All I/O intensive jobs must use the SCRATCH filesystem as their working directory.

    Users are advised to save the necessary data from the SCRATCH filesystem to HOME filesystem after the calculations and clean up the scratch files.

!!! warning
    Files on the SCRATCH filesystem that are **not accessed for more than 90 days** will be automatically **deleted**.

The SCRATCH filesystem is realized as Lustre parallel filesystem and is available from all login and computational nodes. Default stripe size is 1MB, stripe count is 1. There are 5 OSTs dedicated for the SCRATCH filesystem.

!!! note
    Setting stripe size and stripe count correctly for your needs may significantly affect the I/O performance.

| SCRATCH filesystem   |           |
| -------------------- | --------- |
| Mountpoint           | /scratch  |
| Capacity             | 310TB     |
| Throughput           | 5GB/s     |
| Throughput [Burst]   | 38GB/s    |
| User space quota     | 10TB      |
| User inodes quota    | 10M       |
| Default stripe size  | 1MB       |
| Default stripe count | 1         |
| Number of OSTs       | 5         |

### PROJECT File System

The PROJECT data storage is a central storage for projects'/users' data on IT4Innovations that is accessible from all clusters.
For more information, see the [PROJECT storage][6] section.

### Disk Usage and Quota Commands

Disk usage and user quotas can be checked and reviewed using the following command:

```console
$ it4i-disk-usage
```

Example:

```console
$ it4i-disk-usage -H
# Using human-readable format
# Using power of 1000 for space
# Using power of 1000 for entries

Filesystem:    /home
Space used:    11GB
Space limit:   25GB
Entries:       15K
Entries limit: 500K
# based on filesystem quota

Filesystem:    /scratch
Space used:    5TB
Space limit:   10TB
Entries:       22K
Entries limit: 10M
# based on Lustre quota
```

In this example, we view current size limits and space occupied on the /home and /scratch filesystem, for a particular user executing the command.
Note that limits are imposed also on number of objects (files, directories, links, etc.) that are allowed to create.

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

This will list all directories with MegaBytes or GigaBytes of consumed space in your actual (in this example HOME) directory. List is sorted in descending order from largest to smallest files/directories.

To have a better understanding of previous commands, you can read man pages:

### Extended ACLs

Extended ACLs provide another security mechanism beside the standard POSIX ACLs, which are defined by three entries (for owner/group/others). Extended ACLs have more than the three basic entries. In addition, they also contain a mask entry and may contain any number of named user and named group entries.

ACLs on a Lustre file system work exactly like ACLs on any Linux file system. They are manipulated with the standard tools in the standard manner.

For more information, see the [Access Control List][7] section of the documentation.

## Local Filesystems

### TMP

Each node is equipped with local /tmp RAMDISK directory. The /tmp directory should be used to work with  temporary files. Old files in /tmp directory are automatically purged.

### SCRATCH and RAMDISK

Each node is equipped with RAMDISK storage accessible at /tmp, /lscratch and /ramdisk . The RAMDISK capacity is 180GB. Data placed on RAMDISK occupy the node RAM memory of 192GB total. The RAMDISK directory should only be used to work with  temporary files, where very high throughput or I/O performance is required. Old files on RAMDISK directory are automatically purged with jobs end.

## Summary

| Mountpoint | Usage                     | Protocol | Net Capacity     | Throughput                     | Limitations | Access                   | Services                        |
| ---------- | ------------------------- | -------- | --------------   | ------------------------------ | ----------- | -----------------------  | ------------------------------- |
| /home      | home directory            | NFS      | 28TB             | 1GB/s                          | Quota 25GB  | Compute and login nodes  | backed up                       |
| /scratch   | scratch temoporary        | Lustre   | 310TB            | 5GB/s, 30GB/s burst buffer     | Quota 10TB  | Compute and login nodes  |files older 90 days autoremoved |
| /lscratch  | local scratch ramdisk     | tmpfs    | 180GB           | 130GB/s                         | none        | Node local               | auto purged after job end       |

[1]: #home-file-system
[2]: #scratch-file-system
[3]: ../storage/cesnet-storage.md
[4]: ../general/obtaining-login-credentials/obtaining-login-credentials.md
[5]: #project-file-system
[6]: ../storage/project-storage.md
[7]: ../storage/standard-file-acl.md

[a]: http://www.nas.nasa.gov
[b]: http://www.nas.nasa.gov/hecc/support/kb/Lustre_Basics_224.html#striping
[c]: http://doc.lustre.org/lustre_manual.xhtml#managingstripingfreespace
[d]: https://support.it4i.cz/rt
[e]: http://man7.org/linux/man-pages/man1/nfs4_setfacl.1.html
