# Accessing the DGX-2

## Before You Access

!!! warning
    GPUs are single-user devices. GPU memory is not purged between job runs and it can be read (but not written) by any user. Consider the confidentiality of your running jobs.

## How to Access

The DGX-2 machine can be accessed through the scheduler from Barbora login nodes `barbora.it4i.cz` as a compute node cn202.

## Storage

There are three shared file systems on the DGX-2 system: HOME, SCRATCH (LSCRATCH), and PROJECT.

### HOME

The HOME filesystem is realized as an NFS filesystem. This is a shared home from the [Barbora cluster][1].

### SCRATCH

The SCRATCH is realized on an NVME storage. The SCRATCH filesystem is mounted in the `/scratch` directory.
Users may freely create subdirectories and files on the filesystem (`/scratch/user/$USER`).
Accessible capacity is 22TB, shared among all users.

!!! warning
    Files on the SCRATCH filesystem that are not accessed for more than 60 days will be automatically deleted.

### PROJECT

The PROJECT data storage is IT4Innovations' central data storage accessible from all clusters.
For more information on accessing PROJECT, its quotas, etc., see the [PROJECT Data Storage][2] section.

[1]: ../../barbora/storage/#home-file-system
[2]: ../../storage/project-storage
