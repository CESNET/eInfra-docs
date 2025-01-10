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

## What is the right flavor for mine project?
Purpose of following image is to help you choosing best flavor for your project
![](/compute/openstack/images/g2_flavor_map.png)

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


## All available flavors
All available flavors can be found on [this page](https://cloud.gitlab-pages.ics.muni.cz/g2/flavors-page/), where a periodically updated table of all possible flavors is provided.