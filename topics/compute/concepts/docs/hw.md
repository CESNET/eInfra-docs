---
layout: article
title: Available Hardware
permalink: /docs/hw.html
key: matlab
aside:
  toc: true
sidebar:
  nav: docs
---
## Kubernetes Clusters

### Kuba-Cluster

This cluster comprises 2560 *hyperthreaded* CPU cores, 2530 available to users, 9.84TB RAM, 9.72TB available to users, and 20 NVIDIA A40 GPU accelerators. It consists of 20 nodes with the following configuration:

|  20x      |                                     |
| :---      | :---                                |
| CPU:      |  2x AMD EPYC 7543                   |
| Memory:   | 512GB                               |
| Disk:     | 2x 3.5TB SSD SATA                   |
| GPU:      | none or 1 or 2 NVIDIA A40 per node  |
| Network:  | 2x 10Gbps NIC                       |

## OpenStack Clusters

_TBD_

## Storage

Primary network storage consists of four head nodes each equipped with AMD EPYC 7302P, 256GB RAM, 2x 10Gbps NIC (failover only). It offers 500TB all-flash capacity of SSD drives only in RAID 6 equivalent configuration. Used filesystem is IBM Spectrum Scale that is exported via NFS version 3 to the kubernetes cluster.

### Data Backup

Storage is not backed up to another location, however, file system snapshots are made on daily basis, 14 snapshosts are kept. I.e., up to 14 days to the past, we are able to restore deleted/overwritten data.
