---
layout: article
title: GPU and other Resources
permalink: /docs/resources.html
key: resources
aside:
  toc: true
sidebar:
  nav: docs
---
## Requests and Limits

As described in [kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/), platform uses two kinds of resource "limits". One is called *Requests*, and provides guaranteed amount of resource, the other one is called *Limits* and specifies never exceed limit of resource. User could specify *Requests* only, which enables guarantees without limit (which forbidden in our platform), or *Limits* only and in this case, *Requests* and *Limits* are equal. All resources are allocated from a single computing node, it means that they cannot be larger than capacity of a single node, e.g., requesting 1000 CPUs will never be satisfied. Resources between *Requests* and *Limits* are not guaranteed. Kubernetes scheduler consider only *Requests* when planning Pods to nodes, so it can happen that node receives disk or memory pressure caused by overbooking these kinds of resources. In this case, a Pod can be evicted from the node. For CPU resources between *Requests* and *Limits*, slow down can happen if node does not have free CPUs anymore.

General YAML fragment looks like this:
```yaml
resources:
  requests:
  # resources
  limits:
  # resources
```

## CPU

CPU resource can be requested in whole CPU units such as `2` for two CPUs, or in milli units such as `100m` for 0.1 CPU. See complete example below.

## Memory

Memory resource can be requested in bytes or multiples of binary bytes. Notation is `1000Mi` or `1Gi` for 1GB of memory. Amount of this resource comprises shared memory (see below) and all memory `emptyDir` volumes. The example below consumes up to 1GB of memory resource and if application requires e.g., 2GB of memory, user needs to request 3GB of memory resource.

```yaml
volumes:
- name ramdisk
  emptyDir:
   medium: Memory
   sizeLImit: 1Gi
```

### Shared Memory

By default, each container runs with 64MB limit on [shared memory](https://man7.org/linux/man-pages/man7/shm_overview.7.html). For many cases, this limit is enough but for some GPU applications or GUI applications this amount is not enough. In such a case, SHM size needs to be increased. This cannot be done in `resource` section, the only possibility is to mount additional memory volume using the following YAML fragment that increases SHM size to 1GB:

```yaml
volumes:
- name: dshm
  emptyDir:
    medium: Memory
    sizeLimit: 1Gi

volumeMounts:
- name: dshm
  mountPath: /dev/shm
```

`Name` of the volume is not important and can be anything valid, the `mountPath` must be `/dev/shm`.

## GPU

GPU resource can be requested in two distinct ways. User can request GPU(s) exclusively using `nvidia.com/gpu: x` where `x` is a number denoting number of requested GPUs. User can request also only a fraction of GPU using `cerit.io/gpu-mem: x` where `x` is a number of GB of GPU memory. In this case, user is given a possibly shared GPU. Fractions of GPUs are easily available, on the other hand, Linux has no technical power to enforce requested GPU memory limits, so if a user exceeds requested amount of GPU memory, there is a chance that the computation will fail for all the users sharing the GPU.

## Storage

User should specify also required `ephemeral-storage` resource. Units are the same as for the `memory` resource. This resource denotes limit on a local storage that comprises size of running container and all local files created. Those files includes all temporary files within container such as files in `/tmp` or `/var/tmp` directories and also all `emptyDir` volumes that are not in memory.

## Full Resource Example

The following example requests 1 GPU, 2 CPUs and 4GB of memory guaranteed, and 3 CPUs and 6GB of memory hard limit.

```yaml
resources:
  requests:
    cpu: 2
    memory: 4Gi
    nvidia.com/gpu: 1
  limits:
    cpu: 3
    memory: 6Gi
    nvidia.com/gpu: 1
```

The following example requests 2 GB of GPU memory, 0.5 CPU and 4GB of memory guaranteed and also as hard limit.

```yaml
resources:
  requests:
    cpu: 500m
    memory: 4Gi
    cerit.io/gpu-mem: 2
  limits:
    cpu: 500m
    memory: 4Gi
    cerit.io/gpu-mem: 2
```

