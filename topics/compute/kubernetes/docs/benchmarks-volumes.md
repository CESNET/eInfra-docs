---
layout: article
title: Kubernetes storage benchmarks
permalink: /docs/benchmarks-volumes.html
key: benchmarks-volumes
aside:
  toc: true
sidebar:
  nav: docs
---

# Storage Benchmark in Kubernetes

The following results have been achieved using a deployment in the `hdhu` cluster on `rancher.cerit-sc.cz`. Deployment was limited to \(512\) MB of RAM (to limit possibility of having data stored in cache and actually force them to be written to the storage).

### NFS

```
Read: 255 MB/s
Write: 295 MB/s
```

### CIFS (Samba)

```
Read: 140 MB/s
Write: 180 MB/s
```

### S3 (MinIO)

```
Write: 250 MB/s
```
There is a slight problem with S3 storage, the filesystem doesn't allow certain operations (e.g. write in the middle of a file), therefore we couldn't use our benchmarking software and had to resort to using `dd` to write a large file. This is why there is only write speed and you should probably take it with a grain of salt.

Please be aware of S3 limitations before you choose it for your use case, ensure the filesystem supports all operations you intend to use while computing.
