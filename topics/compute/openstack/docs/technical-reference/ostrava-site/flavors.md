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

| Flavor type | Flavor characteristic | HA support | (live) migration support | GPU support | local ephemeral disk resources | vCPU efficiency | old flavor naming |
|-------------|-----------------------|------------|--------------------------|-------------|--------------------------------|-----------------|-------------------|
| `e1.*` | economic computing, small jobs, limited performance | Yes | Yes | No | No | approx. PASSMARK 250 | `standard.*` |
| `g2.*` | general purpose, regular jobs / tasks, medium performance | Yes | Yes | No | No | approx. PASSMARK 750 | - |
| `c2.*` | compute HPC, medium performance | No | Yes | No | No | approx. PASSMARK 750 | - |
| `c3.*` | compute HPC, high performance on shared storage | No | Yes | No | No | approx. PASSMARK 2000 | `hpc.*` |
| `p3.*` | compute HPC, top performance on ephemeral storage | No | Yes | No | Yes | approx. PASSMARK 2000 | `hpc.*ephem` |
| `a3.*` | compute HPC, top performance on ephemeral storage | No | No | Yes | Yes | approx. PASSMARK 2000 | `hpc.*gpu` |


## Most frequently used flavors
| Flavor name                               | Is public | vCPU | RAM [GB] | HPC  | SSD  | Disc throughput [MB/s] | IOPS [op/s]| Average throughput [MB/s]  | GPU |
|-------------------------------------------|-----------|------|----------|------|------|------------------------|------------|----------------------------|-----|
| e1.tiny | Yes | 2 | 2048 | No | No | 105 | 400 | 128 | No |
| e1.small | Yes | 2 | 4096 | No | No | 105 | 400 | 128 | No |
| e1.medium | Yes | 4 | 4096 | No | No | 105 | 400 | 128 | No |
| e1.large | Yes | 4 | 8192 | No | No | 105 | 400 | 128 | No |
| e1.1xlarge | Yes | 8 | 8192 | No | No | 105 | 400 | 128 | No |
| e1.2xlarge | Yes | 8 | 16384 | No | No | 105 | 400 | 128 | No |
| g2.tiny | Yes | 2 | 8192 | No | No | 1049 | 1000 | 256 | No |
| g2.medium | Yes | 4 | 16384 | No | No | 1049 | 1000 | 256 | No |
| g2.small | Yes | 4 | 8192 | No | No | 1049 | 1000 | 256 | No |
| g2.large | No | 8 | 16384 | No | No | 1049 | 1000 | 256 | No |
| g2.1xlarge | No | 8 | 24576 | No | No | 1049 | 1000 | 256 | No |
| g2.3xlarge | No | 16 | 65536 | No | No | 1049 | 1000 | 256 | No |
| g2.2xlarge | No | 16 | 32768 | No | No | 1049 | 1000 | 256 | No |
| c2.2core-16ram | No | 2 | 16384 | Yes | No | 2097 | 1000 | 2560 | No |
| c2.2core-8ram | No | 2 | 8192 | Yes | No | 2097 | 1000 | 2560 | No |
| c2.4core-8ram | No | 4 | 8192 | Yes | No | 2097 | 1000 | 2560 | No |
| c2.4core-16ram | No | 4 | 16384 | Yes | No | 2097 | 1000 | 2560 | No |
| c2.4core-30ram | No | 4 | 30720 | Yes | No | 2097 | 1000 | 2560 | No |
| c2.8core-16ram | No | 8 | 16384 | Yes | No | 2097 | 1000 | 2560 | No |
| c2.8core-30ram | No | 8 | 30720 | Yes | No | 2097 | 1000 | 2560 | No |
| c2.16core-30ram | No | 16 | 30720 | Yes | No | 2097 | 1000 | 2560 | No |
| c2.16core-60ram | No | 16 | 61440 | Yes | No | 2097 | 1000 | 2560 | No |
| c2.24core-60ram | No | 24 | 61440 | Yes | No | 2097 | 1000 | 2560 | No |
| c2.32core-30ram | No | 32 | 30720 | Yes | No | 2097 | 1000 | 2560 | No |
| c2.32core-60ram | No | 32 | 61440 | Yes | No | 2097 | 1000 | 2560 | No |
| c3.2core-8ram | No | 2 | 8192 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.2core-16ram | No | 2 | 16384 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.4core-16ram | No | 4 | 16384 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.4core-8ram | No | 4 | 8192 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.4core-30ram | No | 4 | 30720 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.8core-16ram | No | 8 | 16384 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.8core-30ram | No | 8 | 30720 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.8core-60ram | No | 8 | 61440 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.16core-30ram | No | 16 | 30720 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.16core-60ram | No | 16 | 61440 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.24core-60ram | No | 24 | 61440 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.32core-120ram | No | 32 | 122880 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.32core-60ram | No | 32 | 61440 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.64core-120ram | No | 64 | 122880 | Yes | No | 2097 | 2000 | 10240 | No |
| c3.128core-240ram | No | 128 | 245760 | Yes | No | 2097 | 2000 | 10240 | No |

