# CESNET Data Storage

IT4Innovations' shared file systems are not intended as a backup for large amount of data or for long-term archiving purposes.
Academic staff and students of research institutions in the Czech Republic should use [CESNET Storage service][a].

CESNET data storage can be used by any organization or an individual person who is in the current employment relationship (employees) or the current study relationship (students) to a legal entity (organization) that meets the “Principles for access to CESNET Large infrastructure (Access Policy)”.

The user may only use the CESNET data storage for data transfer and storage associated with activities in science, research, development, spread of education, culture, and prosperity. For details, see “Acceptable Use Policy CESNET Large Infrastructure (Acceptable Use Policy, AUP)”.

The service is documented [here][b]. For special requirements contact directly CESNET Storage Department via e-mail [du-support(at)cesnet.cz][c].

The procedure to obtain the CESNET access is quick and simple.

## CESNET Storage Access

### Understanding CESNET Storage

!!! note
    It is very important to understand the CESNET storage before uploading data. [Read][d] first.

Once registered for CESNET Storage, you may [access the storage][e] in number of ways. We recommend the SSHFS and RSYNC methods.

### SSHFS Access

!!! note
    SSHFS: The storage will be mounted like a local hard drive

The SSHFS provides a very convenient way to access the CESNET Storage. The storage will be mounted onto a local directory, exposing the vast CESNET Storage as if it was a local removable hard drive. Files can be than copied in and out in a usual fashion.

First, create the mount point:

```console
$ mkdir cesnet
```

Mount the storage. Note that you can choose among ssh.du4.cesnet.cz (Ostrava) and ssh.du5.cesnet.cz (Jihlava).
Mount tier1_home **(only 5120M !)**:

```console
$ sshfs username@ssh.du4.cesnet.cz:. cesnet/
```

For easy future access, install your public key:

```console
$ cp .ssh/id_rsa.pub cesnet/.ssh/authorized_keys
```

Mount tier1_cache_tape for the Storage VO:

```console
$ sshfs username@ssh.du4.cesnet.cz:/cache_tape/VO_storage/home/username cesnet/
```

View the archive, copy the files and directories in and out:

```console
$ ls cesnet/
$ cp -a mydir cesnet/.
$ cp cesnet/myfile .
```

Once done, remember to unmount the storage:

```console
$ fusermount -u cesnet
```

### Rsync Access

!!! note
    Rsync provides delta transfer for best performance and can resume interrupted transfers.

Rsync is a fast and extraordinarily versatile file copying tool. It is famous for its delta-transfer algorithm, which reduces the amount of data sent over the network by sending only the differences between the source files and the existing files in the destination. Rsync is widely used for backups and mirroring and as an improved copy command for everyday use.

Rsync finds files that need to be transferred using a "quick check" algorithm (by default) that looks for files that have changed in size or in last-modified time. Any changes in the other preserved attributes (as requested by options) are made on the destination file directly when the quick check indicates that the file's data does not need to be updated.

More about Rsync [here][f].

Transfer large files to/from CESNET storage, assuming membership in the Storage VO:

```console
$ rsync --progress datafile username@ssh.du4.cesnet.cz:VO_storage-cache_tape/.
$ rsync --progress username@ssh.du4.cesnet.cz:VO_storage-cache_tape/datafile .
```

Transfer large directories to/from CESNET storage, assuming membership in the Storage VO:

```console
$ rsync --progress -av datafolder username@ssh.du4.cesnet.cz:VO_storage-cache_tape/.
$ rsync --progress -av username@ssh.du4.cesnet.cz:VO_storage-cache_tape/datafolder .
```

Transfer rates of about 28MB/s can be expected.

[a]: https://du.cesnet.cz/
[b]: https://du.cesnet.cz/en/start
[c]: mailto:du-support@cesnet.cz
[d]: https://du.cesnet.cz/en/navody/home-migrace-plzen/start
[e]: https://du.cesnet.cz/en/navody/faq/start)
[f]: https://du.cesnet.cz/en/navody/rsync/start#pro_bezne_uzivatele
