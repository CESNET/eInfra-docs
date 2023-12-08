---

title: Why we introduce new generation (G2) of the e-INFRA CZ OpenStack IaaS cloud
search:
  exclude: false
---

# New generation (G2) of the e-INFRA CZ OpenStack IaaS cloud

## Reasons behind G2 introduction

1. Difficult and time-consuming cloud upgrades.
2. Hypervisor operating system deprecation and related lack of new hardware features support.
3. High cloud maintenance cost closely related with fact that G1 OpenStack deployment is not close to any standard upstream OpenStack deployment codebase anymore.
4. Inconsistent OpenStack external network and flavor naming schemas.

## G2 cloud highlights

1. Cloud security increase (from the cloud front-end down-to hypervisor operating system).
2. Improved cloud robustness, resiliency and stability thanks to new cloud architecture based on Kubernetes underneath.
3. New version of OpenStack.
4. Improved cloud scalability and API response time.
5. Improved networking (MTU 9K, planned step-by-step hypervisor networking upgrade 10Gb/s -> 25 Gb/s).
6. Slightly improved HDD ceph performance.
7. More user friently FIP allocation (single general network with multiple subnets).
8. [New cloud flavor naming schema](./brno-g2-site/flavors.md#flavor-types-and-naming-schema).
9. Improved and simplified cloud maintenance (easy upgrades, shorter outages).
10. New cloud Terms of Service (more strict deallocation of cloud resources in personal projects). 
11. Optimized use of new hypervsior hardware features.
12. Planned support for geo distribution of IaaS workloads (G2 Brno, G2 Ostrava)
