---

title: Flavors
search:
  exclude: false
---

<style>
  .md-sidebar--secondary:not([hidden]) {
    visibility: hidden;
    display: none;
  }
  .md-content {
    min-width: inherit;
  }
  .md-typeset table:not([class]) th {
    min-width: inherit;
  }
</style>

# Flavors

OpenStack flavor entity defines compute virtual server parameters such as:

* virtual server specifications
    * vCPU count
    * memory amount
    * storage size (both distributed, ephemeral)
    * defines QoS (IOPs, network bandwith, ...)
* grants access to additional resources (hardware cards for instance GPU)
* defines set of compute hypervisors where can be virtual server scheduled

## Flavor types and naming schema

| Flavor type | Flavor characteristic | HA support | (live) migration support | GPU support | local ephemeral disk resources | vCPU efficiency, CPU overcommit | old G1 flavor naming |
|-------------|-----------------------|------------|--------------------------|-------------|--------------------------------|---------------------------------|-------------------|
| `e1.*` | economic computing, small jobs, limited performance       | Yes | Yes | No       | No                             | ~ PASSMARK 250, 1:8  | `standard.*` |
| `g2.*` | general purpose, regular jobs / tasks, medium performance | Yes | Yes | No       | No                             | ~ PASSMARK 750, 1:2  | - |
| `c2.*` | compute HPC, medium performance                           | No  | Yes | No       | No                             | ~ PASSMARK 750, 1:2  | - |
| `c3.*` | compute HPC, high performance on shared storage           | No  | Yes | No       | No                             | ~ PASSMARK 2000, 1:1 | `hpc.*` |
| `p3.*` | compute HPC, top performance on ephemeral storage         | No  | Yes, not guaranteed `(1)` | No | Yes            | ~ PASSMARK 2000, 1:1 | `hpc.*ephem` |
| `r3.*` | compute HPC, ephemeral storage only                       | No  | Yes, not guaranteed `(1)` | No | Yes            | ~ PASSMARK 2000, 1:1 | `hpc.*ephem` |
| `a3.*` | compute HPC, top performance on ephemeral storage         | No  | No  | Yes      | Yes                            | ~ PASSMARK 2000, 1:1 | `hpc.*gpu` |

Notes:

- `(1)` Both cold and live virtual server migrations are generally supported even for VMs with ephemeral storage, but they are not guaranteed as there may not be available ephemeral resources where to migrate.


## Most frequently used flavors
| Flavor name   | Is public | vCPU [-] | RAM [GB] | HPC | SSD | GPU | Disc throughput [MB/s] | IOPS [op/s]| Average throughput [MB/s]  |
|---------------|-----------|----------|----------|-----|-----|-----|------------------------|------------|----------------------------|
| e1.1core-2ram | Yes | 1 | 2048 | No | No | No | 262 | 2000 | 256 |
| e1.tiny | Yes | 2 | 2048 | No | No | No | 262 | 2000 | 256 |
| e1.small | Yes | 2 | 4096 | No | No | No | 262 | 2000 | 256 |
| e1.medium | Yes | 4 | 4096 | No | No | No | 262 | 2000 | 256 |
| e1.large | Yes | 4 | 8192 | No | No | No | 262 | 2000 | 256 |
| e1.1xlarge | Yes | 8 | 8192 | No | No | No | 262 | 2000 | 256 |
| e1.2xlarge | Yes | 8 | 16384 | No | No | No | 262 | 2000 | 256 |
| g2.tiny | Yes | 2 | 8192 | No | No | No | 1049 | 2000 | 524 |
| g2.small | Yes | 4 | 8192 | No | No | No | 1049 | 2000 | 524 |
| g2.medium | Yes | 4 | 16384 | No | No | No | 1049 | 2000 | 524 |
| g2.large | No | 8 | 16384 | No | No | No | 1049 | 2000 | 524 |
| g2.1xlarge | No | 8 | 24576 | No | No | No | 1049 | 2000 | 524 |
| g2.2xlarge | No | 16 | 30720 | No | No | No | 1049 | 2000 | 524 |
| g2.3xlarge | No | 16 | 61440 | No | No | No | 1049 | 2000 | 524 |
| c2.2core-8ram | No | 2 | 8192 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.2core-16ram | No | 2 | 16384 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.2core-30ram | No | 2 | 30720 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.4core-8ram | No | 4 | 8192 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.4core-16ram | No | 4 | 16384 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.4core-30ram | No | 4 | 30720 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.8core-16ram | No | 8 | 16384 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.8core-30ram | No | 8 | 30720 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.16core-30ram | No | 16 | 30720 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.16core-60ram | No | 16 | 61440 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.18core-45ram | No | 18 | 46080 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.20core-240ram | No | 20 | 245760 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.24core-30ram | No | 24 | 30720 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.24core-60ram | No | 24 | 61440 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.30core-30ram | No | 30 | 30720 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.30core-60ram | No | 30 | 61440 | Yes | No | No | 2097 | 3000 | 2560 |
| c2.30core-120ram | No | 30 | 122880 | Yes | No | No | 2097 | 3000 | 2560 |
| c3.2core-8ram | No | 2 | 8192 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.2core-16ram | No | 2 | 16384 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.2core-30ram | No | 2 | 30720 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.4core-8ram | No | 4 | 8192 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.4core-16ram | No | 4 | 16384 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.4core-30ram | No | 4 | 30720 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.8core-16ram | No | 8 | 16384 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.8core-30ram | No | 8 | 30720 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.8core-60ram | No | 8 | 61440 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.8core-120ram | No | 8 | 122880 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.16core-30ram | No | 16 | 30720 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.16core-60ram | No | 16 | 61440 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.16core-120ram | No | 16 | 122880 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.16core-240ram | No | 16 | 245760 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.18core-45ram | No | 18 | 46080 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.24core-30ram | No | 24 | 30720 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.24core-60ram | No | 24 | 61440 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.24core-90ram | No | 24 | 92160 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.24core-240ram | No | 24 | 245760 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.30core-30ram | No | 30 | 30720 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.30core-60ram | No | 30 | 61440 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.30core-120ram | No | 30 | 122880 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.30core-240ram | No | 30 | 245760 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.60core-60ram | No | 60 | 61440 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.60core-120ram | No | 60 | 122880 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.60core-240ram | No | 60 | 245760 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.120core-120ram | No | 120 | 122880 | Yes | No | No | 2097 | 3000 | 10240 |
| c3.120core-240ram | No | 120 | 245760 | Yes | No | No | 2097 | 3000 | 10240 |
| p3.2core-4ram | No | 2 | 4096 | Yes | Yes | No | -- | -- | 20480 |
| p3.2core-8ram | No | 2 | 8192 | Yes | Yes | No | -- | -- | 20480 |
| p3.2core-16ram | No | 2 | 16384 | Yes | Yes | No | -- | -- | 20480 |
| p3.2core-30ram | No | 2 | 30720 | Yes | Yes | No | -- | -- | 20480 |
| p3.2core-30ram | No | 2 | 30720 | Yes | Yes | No | -- | -- | 20480 |
| p3.4core-8ram | No | 4 | 8192 | Yes | Yes | No | -- | -- | 20480 |
| p3.4core-16ram | No | 4 | 16384 | Yes | Yes | No | -- | -- | 20480 |
| p3.4core-30ram | No | 4 | 30720 | Yes | Yes | No | -- | -- | 20480 |
| p3.8core-16ram | No | 8 | 16384 | Yes | Yes | No | -- | -- | 20480 |
| p3.8core-16ram | No | 8 | 16384 | Yes | Yes | No | -- | -- | 20480 |
| p3.8core-30ram | No | 8 | 30720 | Yes | Yes | No | -- | -- | 20480 |
| p3.8core-60ram | No | 8 | 61440 | Yes | Yes | No | -- | -- | 20480 |
| p3.16core-30ram | No | 16 | 30720 | Yes | Yes | No | -- | -- | 20480 |
| p3.16core-60ram | No | 16 | 61440 | Yes | Yes | No | -- | -- | 20480 |
| p3.24core-30ram | No | 24 | 30720 | Yes | Yes | No | -- | -- | 20480 |
| p3.24core-60ram | No | 24 | 61440 | Yes | Yes | No | -- | -- | 20480 |
| p3.30core-120ram | No | 30 | 122880 | Yes | Yes | No | -- | -- | 20480 |
| r3.4core-8ram | No | 4 | 8192 | Yes | Yes | No | -- | -- | 20480 |
| r3.8core-16ram | No | 8 | 16384 | Yes | Yes | No | -- | -- | 20480 |
| a3.4core-8ram-nvidia-2080 `(1)` | No | 4 | 8192 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.4core-16ram-nvidia-2080 `(1)`| No | 4 | 16384 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.4core-30ram-nvidia-2080 `(1)`| No | 4 | 30720 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.8core-16ram-nvidia-2080 `(1)`| No | 8 | 16384 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.8core-30ram-nvidia-2080 `(1)`| No | 8 | 30720 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.8core-60ram-nvidia-2080 `(1)`| No | 8 | 61440 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.16core-30ram-nvidia-2080 `(1)`| No | 16 | 30720 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.16core-60ram-nvidia-2080 `(1)`| No | 16 | 61440 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.24core-30ram-nvidia-2080 `(1)`| No | 24 | 30720 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.24core-60ram-nvidia-2080 `(1)`| No | 24 | 61440 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.4core-8ram-nvidia-t4 `(1)` | No | 4 | 8192 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.4core-16ram-nvidia-t4 `(1)`| No | 4 | 16384 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.4core-30ram-nvidia-t4 `(1)`| No | 4 | 30720 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.8core-16ram-nvidia-t4 `(1)`| No | 8 | 16384 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.8core-30ram-nvidia-t4 `(1)`| No | 8 | 30720 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.8core-60ram-nvidia-t4 `(1)`| No | 8 | 61440 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.16core-30ram-nvidia-t4 `(1)`| No | 16 | 30720 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.16core-60ram-nvidia-t4 `(1)`| No | 16 | 61440 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.24core-30ram-nvidia-t4 `(1)`| No | 24 | 30720 | Yes | Yes | Yes | -- | -- | 20480 |
| a3.24core-60ram-nvidia-t4 `(1)`| No | 24 | 61440 | Yes | Yes | Yes | -- | -- | 20480 |

Notes:

- `(1)` Same flavor with 2 GPU's available aswell.
