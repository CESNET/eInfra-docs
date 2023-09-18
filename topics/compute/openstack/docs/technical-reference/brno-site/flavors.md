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
 * Standard flavors `standard.*` focused on high availability, support for (live) VM migration but lower performance.
 * HPC flavors `hpc.*` are focused on performance (NUMA, local ephemeral disks), access to premium HW (GPUs).

## Most frequently used flavors

| Flavor name                               | CPU  | RAM (GB) | HPC  | SSD  | Disc throughput (MB/s) | IOPS       | Average throughput (MB/s)  | GPU |
|-------------------------------------------|------|----------|------|------|------------------------|------------|----------------------------|-----|
| elixir.hda1                               | 30   | 724      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | No  |
| elixir.hda1-10core-240ram                 | 10   | 240      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | No  |
| hpc.16core-128ram                         | 16   | 128      | Yes  | No   | 524.288                | 2000       | 2000.0                     | No  |
| hpc.16core-32ram                          | 16   | 32       | Yes  | No   | 524.288                | 2000       | 2000.0                     | No  |
| hpc.16core-64ram-ssd-ephem                | 16   | 64       | Yes  | Yes  | Unlimited              | Unlimited  | 1250.0                     | No  |
| hpc.18core-48ram                          | 18   | 48       | Yes  | No   | 524.288                | 2000       | 2000.0                     | No  |
| hpc.19core-176ram-nvidia-2080-glados      | 19   | 176      | Yes  | Yes  | Unlimited              | Unlimited  | Unlimited                  | Yes |
| hpc.24core-256ram-ssd-ephem               | 24   | 256      | Yes  | Yes  | Unlimited              | Unlimited  | 1250.0                     | No  |
| hpc.24core-96ram-ssd-ephem                | 24   | 96       | Yes  | Yes  | Unlimited              | Unlimited  | 1250.0                     | No  |
| hpc.30core-128ram-ssd-ephem-500           | 30   | 128      | Yes  | Yes  | Unlimited              | Unlimited  | 1250.0                     | No  |
| hpc.30core-256ram                         | 30   | 256      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | No  |
| hpc.30core-64ram                          | 30   | 64       | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | No  |
| hpc.32core-256ram-nvidia-t4-single-gpu    | 32   | 240      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | Yes |
| hpc.38core-372ram-nvidia-2080-glados      | 38   | 352      | Yes  | Yes  | Unlimited              | Unlimited  | Unlimited                  | Yes |
| hpc.38core-372ram-ssd-ephem               | 38   | 372      | Yes  | Yes  | Unlimited              | Unlimited  | 1250.0                     | No  |
| hpc.40core-372ram-nvidia-2080-glados      | 40   | 352      | Yes  | Yes  | Unlimited              | Unlimited  | Unlimited                  | Yes |
| hpc.4core-16ram-ssd-ephem                 | 4    | 16       | Yes  | Yes  | Unlimited              | Unlimited  | 1250.0                     | No  |
| hpc.4core-16ram-ssd-ephem-500             | 4    | 16       | Yes  | Yes  | Unlimited              | Unlimited  | 1250.0                     | No  |
| hpc.64core-512ram-nvidia-t4               | 64   | 480      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | Yes |
| hpc.8core-16ram                           | 8    | 16       | Yes  | No   | 524.288                | 2000       | 2000.0                     | No  |
| hpc.8core-32ram-ssd-ephem                 | 8    | 32       | Yes  | Yes  | Unlimited              | Unlimited  | 1250.0                     | No  |
| hpc.8core-32ram-ssd-rcx-ephem             | 8    | 32       | Yes  | Yes  | Unlimited              | Unlimited  | Unlimited                  | No  |
| hpc.8core-64ram                           | 8    | 64       | Yes  | No   | 524.288                | 2000       | 2000.0                     | No  |
| hpc.hdh                                   | 32   | 480      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | No  |
| hpc.hdh-8cpu-120ram                       | 8    | 120      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | No  |
| hpc.hdh-ephem                             | 32   | 480      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | No  |
| hpc.ics-gladosag-full                     | 38   | 372      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | No  |
| hpc.large                                 | 16   | 64       | Yes  | No   | 524.288                | 2000       | 2000.0                     | No  |
| hpc.medium                                | 8    | 32       | Yes  | No   | 524.288                | 2000       | 2000.0                     | No  |
| hpc.nvidia-2080-hdg-16cpu-236ram-ephem    | 16   | 236      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | Yes |
| hpc.nvidia-2080-hdg-ephem                 | 32   | 448      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | Yes |
| hpc.nvidia-2080-hdg-half-ephem            | 16   | 238      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | Yes |
| hpc.small                                 | 4    | 16       | Yes  | No   | 524.288                | 2000       | 2000.0                     | No  |
| hpc.xlarge                                | 24   | 96       | Yes  | No   | 524.288                | 2000       | 2000.0                     | No  |
| hpc.xlarge-memory                         | 24   | 256      | Yes  | No   | Unlimited              | Unlimited  | Unlimited                  | No  |
| standard.12core-24ram                     | 12   | 24       | No   | No   | 262.144                | 2000       | 625.0                      | No  |
| standard.16core-32ram                     | 16   | 32       | No   | No   | 262.144                | 2000       | 625.0                      | No  |
| standard.20core-128ram                    | 20   | 128      | No   | No   | 262.144                | 2000       | 250.0                      | No  |
| standard.20core-160ram                    | 20   | 160      | No   | No   | 262.144                | 2000       | 1250.0                     | No  |
| standard.20core-256ram                    | 20   | 256      | No   | No   | 262.144                | 2000       | 1250.0                     | No  |
| standard.2core-16ram                      | 2    | 16       | No   | No   | 262.144                | 2000       | 250.0                      | No  |
| standard.large                            | 4    | 8        | No   | No   | 262.144                | 2000       | 250.0                      | No  |
| standard.medium                           | 2    | 4        | No   | No   | 262.144                | 2000       | 250.0                      | No  |
| standard.memory                           | 2    | 32       | No   | No   | 262.144                | 2000       | 250.0                      | No  |
| standard.one-to-many                      | 20   | 64       | No   | No   | 262.144                | 2000       | 250.0                      | No  |
| standard.small                            | 1    | 2        | No   | No   | 262.144                | 2000       | 250.0                      | No  |
| standard.tiny                             | 1    | 1        | No   | No   | 262.144                | 2000       | 250.0                      | No  |
| standard.xlarge                           | 4    | 16       | No   | No   | 262.144                | 2000       | 250.0                      | No  |
| standard.xlarge-cpu                       | 8    | 16       | No   | No   | 262.144                | 2000       | 250.0                      | No  |
| standard.xxlarge                          | 8    | 32       | No   | No   | 262.144                | 2000       | 250.0                      | No  |
| standard.xxxlarge                         | 8    | 64       | No   | No   | 262.144                | 2000       | 250.0                      | No  |
| hpc.8core-8ram                            | 8    | 8        | Yes  | No   | 524.288                | 2000       | 2000.0                     | No  |
| hpc.16core-32ram-100disk                  | 16   | 32       | Yes  | No   | 524.288                | 2000       | 2000.0                     | No  |
| meta-hdm.38core-300ram-nvidia-a40-quad    | 38   | 300      | Yes  | Yes  | Unlimited              | Unlimited  | Unlimited                  | Yes |
| hpc.4core-4ram                            | 4    | 4        | Yes  | No   | 524.288                | 2000       | 2000.0                     | No  |
| a3.32core-120ram-1t4                      | 32   | 120      | Yes  | Yes  | Unlimited              | Unlimited  | Unlimited                  | Yes |
| a3.32core-240ram-1t4                      | 32   | 240      | Yes  | Yes  | Unlimited              | Unlimited  | Unlimited                  | Yes |
| a3.64core-240ram-2t4                      | 64   | 240      | Yes  | Yes  | Unlimited              | Unlimited  | Unlimited                  | Yes |
| a3.64core-480ram-2t4                      | 64   | 480      | Yes  | Yes  | Unlimited              | Unlimited  | Unlimited                  | Yes |
