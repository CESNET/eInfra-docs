---

title: Data Storage
search:
  exclude: false
---

# Data Storage

Every project generates an amount of data that needs to be stored. There are options (sorted by preference):

- as objects or files in a S3 compatible storage
    - S3 compatible storage may be requested as separate cloud storage resource (OpenStack Swift storage + S3 API)
    - S3 storage may be also easily launched on one of the project VMs (minio server)
- as files on
    - separate (ceph) volume
    - virtual machine disk volume (i.e. no explicit volume for the project data)
- as objects or files in the OpenShift Swift storage

MetaCentrum Cloud stores raw data:

- in ceph cloud storage on rotation disks (SSDs will be available soon)
- in hypervisor (bare metal) disks (rotational, SSD, SSD NVMe)

We encourage all users to backup important data themselves.
