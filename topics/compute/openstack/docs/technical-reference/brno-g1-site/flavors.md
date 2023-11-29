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

## Flavor types

We differentiate following flavor types:

- Standard flavors `standard.*` focused on high availability, support for (live) VM migration but lower performance.
- HPC flavors `hpc.*` are focused on performance (NUMA, local ephemeral disks), access to premium HW (GPUs).

## Most frequently used flavors

| Flavor name                               | vCPU | RAM [GB] | HPC  | SSD  | GPU | Disc throughput [MB/s] | IOPS [op/s] | Average throughput [MB/s]  |
|-------------------------------------------|------|----------|------|------|-----|------------------------|------------|----------------------------|
| standard.tiny                             | 1    | 1        | No   | No   | No  | 262                    | 2000       | 250                        |
| standard.small                            | 1    | 2        | No   | No   | No  | 262                    | 2000       | 250                        |
| standard.medium                           | 2    | 4        | No   | No   | No  | 262                    | 2000       | 250                        |
| standard.large                            | 4    | 8        | No   | No   | No  | 262                    | 2000       | 250                        |
| standard.xlarge                           | 4    | 16       | No   | No   | No  | 262                    | 2000       | 250                        |
| standard.xlarge-cpu                       | 8    | 16       | No   | No   | No  | 262                    | 2000       | 250                        |
| standard.xxlarge                          | 8    | 32       | No   | No   | No  | 262                    | 2000       | 250                        |
| standard.xxxlarge                         | 8    | 64       | No   | No   | No  | 262                    | 2000       | 250                        |
| standard.2core-16ram                      | 2    | 16       | No   | No   | No  | 262                    | 2000       | 250                        |
| standard.memory                           | 2    | 32       | No   | No   | No  | 262                    | 2000       | 250                        |
| standard.12core-24ram                     | 12   | 24       | No   | No   | No  | 262                    | 2000       | 625                        |
| standard.16core-32ram                     | 16   | 32       | No   | No   | No  | 262                    | 2000       | 625                        |
| standard.one-to-many                      | 20   | 64       | No   | No   | No  | 262                    | 2000       | 250                        |
| standard.20core-128ram                    | 20   | 128      | No   | No   | No  | 262                    | 2000       | 250                        |
| standard.20core-160ram                    | 20   | 160      | No   | No   | No  | 262                    | 2000       | 1250                       |
| standard.20core-256ram                    | 20   | 256      | No   | No   | No  | 262                    | 2000       | 1250                       |
| hpc.small                                 | 4    | 16       | Yes  | No   | No  | 524                    | 2000       | 2000                       |
| hpc.medium                                | 8    | 32       | Yes  | No   | No  | 524                    | 2000       | 2000                       |
| hpc.large                                 | 16   | 64       | Yes  | No   | No  | 524                    | 2000       | 2000                       |
| hpc.xlarge                                | 24   | 96       | Yes  | No   | No  | 524                    | 2000       | 2000                       |
| hpc.xlarge-memory                         | 24   | 256      | Yes  | No   | No  | Unlimited              | Unlimited  | Unlimited                  |
| hpc.4core-4ram                            | 4    | 4        | Yes  | No   | No  | 524                    | 2000       | 2000                       |
| hpc.4core-16ram-ssd-ephem                 | 4    | 16       | Yes  | Yes  | No  | Unlimited              | Unlimited  | 1250                       |
| hpc.4core-16ram-ssd-ephem-500             | 4    | 16       | Yes  | Yes  | No  | Unlimited              | Unlimited  | 1250                       |
| hpc.8core-8ram                            | 8    | 8        | Yes  | No   | No  | 524                    | 2000       | 2000                       |
| hpc.8core-16ram                           | 8    | 16       | Yes  | No   | No  | 524                    | 2000       | 2000                       |
| hpc.8core-32ram-ssd-ephem                 | 8    | 32       | Yes  | Yes  | No  | Unlimited              | Unlimited  | 1250                       |
| hpc.8core-32ram-ssd-rcx-ephem             | 8    | 32       | Yes  | Yes  | No  | Unlimited              | Unlimited  | Unlimited                  |
| hpc.8core-64ram                           | 8    | 64       | Yes  | No   | No  | 524                    | 2000       | 2000                       |
| hpc.16core-32ram                          | 16   | 32       | Yes  | No   | No  | 524                    | 2000       | 2000                       |
| hpc.16core-32ram-100disk                  | 16   | 32       | Yes  | No   | No  | 524                    | 2000       | 2000                       |
| hpc.16core-64ram-ssd-ephem                | 16   | 64       | Yes  | Yes  | No  | Unlimited              | Unlimited  | 1250                       |
| hpc.16core-128ram                         | 16   | 128      | Yes  | No   | No  | 524                    | 2000       | 2000                       |
| hpc.18core-48ram                          | 18   | 48       | Yes  | No   | No  | 524                    | 2000       | 2000                       |
| hpc.19core-176ram-nvidia-2080-glados      | 19   | 176      | Yes  | Yes  | Yes | Unlimited              | Unlimited  | Unlimited                  |
| hpc.24core-96ram-ssd-ephem                | 24   | 96       | Yes  | Yes  | No  | Unlimited              | Unlimited  | 1250                       |
| hpc.24core-256ram-ssd-ephem               | 24   | 256      | Yes  | Yes  | No  | Unlimited              | Unlimited  | 1250                       |
| hpc.30core-64ram                          | 30   | 64       | Yes  | No   | No  | Unlimited              | Unlimited  | Unlimited                  |
| hpc.30core-128ram-ssd-ephem-500           | 30   | 128      | Yes  | Yes  | No  | Unlimited              | Unlimited  | 1250                       |
| hpc.30core-256ram                         | 30   | 256      | Yes  | No   | No  | Unlimited              | Unlimited  | Unlimited                  |
| hpc.32core-256ram-nvidia-t4-single-gpu    | 32   | 240      | Yes  | No   | Yes | Unlimited              | Unlimited  | Unlimited                  |
| hpc.38core-372ram-ssd-ephem               | 38   | 372      | Yes  | Yes  | No  | Unlimited              | Unlimited  | 1250                       |
| hpc.38core-372ram-nvidia-2080-glados      | 38   | 352      | Yes  | Yes  | Yes | Unlimited              | Unlimited  | Unlimited                  |
| hpc.40core-372ram-nvidia-2080-glados      | 40   | 352      | Yes  | Yes  | Yes | Unlimited              | Unlimited  | Unlimited                  |
| hpc.64core-512ram-nvidia-t4               | 64   | 480      | Yes  | No   | Yes | Unlimited              | Unlimited  | Unlimited                  |
| hpc.hdh-8cpu-120ram                       | 8    | 120      | Yes  | No   | No  | Unlimited              | Unlimited  | Unlimited                  |
| hpc.hdh                                   | 32   | 480      | Yes  | No   | No  | Unlimited              | Unlimited  | Unlimited                  |
| hpc.hdh-ephem                             | 32   | 480      | Yes  | No   | No  | Unlimited              | Unlimited  | Unlimited                  |
| hpc.ics-gladosag-full                     | 38   | 372      | Yes  | No   | No  | Unlimited              | Unlimited  | Unlimited                  |
| hpc.nvidia-2080-hdg-16cpu-236ram-ephem    | 16   | 236      | Yes  | No   | Yes | Unlimited              | Unlimited  | Unlimited                  |
| hpc.nvidia-2080-hdg-ephem                 | 32   | 448      | Yes  | No   | Yes | Unlimited              | Unlimited  | Unlimited                  |
| hpc.nvidia-2080-hdg-half-ephem            | 16   | 238      | Yes  | No   | Yes | Unlimited              | Unlimited  | Unlimited                  |
| a3.32core-120ram-1t4                      | 32   | 120      | Yes  | Yes  | Yes | Unlimited              | Unlimited  | Unlimited                  |
| a3.32core-240ram-1t4                      | 32   | 240      | Yes  | Yes  | Yes | Unlimited              | Unlimited  | Unlimited                  |
| a3.64core-240ram-2t4                      | 64   | 240      | Yes  | Yes  | Yes | Unlimited              | Unlimited  | Unlimited                  |
| a3.64core-480ram-2t4                      | 64   | 480      | Yes  | Yes  | Yes | Unlimited              | Unlimited  | Unlimited                  |
| meta-hdm.38core-300ram-nvidia-a40-quad    | 38   | 300      | Yes  | Yes  | Yes | Unlimited              | Unlimited  | Unlimited                  |
| elixir.hda1                               | 30   | 724      | Yes  | No   | No  | Unlimited              | Unlimited  | Unlimited                  |
| elixir.hda1-10core-240ram                 | 10   | 240      | Yes  | No   | No  | Unlimited              | Unlimited  | Unlimited                  |
