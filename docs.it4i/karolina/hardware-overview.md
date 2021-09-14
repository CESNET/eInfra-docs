# Hardware Overview

Karolina consists of 829 computational nodes of which 720 are universal compute nodes (**Cn[001-720]**), 72 are NVIDIA A100 accelerated nodes (**Acn[01-72]**), 1 is a data analytics node (**Sdf1**), and 36 are cloud partitions (**CLn[01-36]**). Each node is a powerful x86-64 computer, equipped with 128/768 cores (64-core AMD EPYC™ 7H12 / 64-core AMD EPYC™ 7763 / 24-core Intel Xeon-SC 8268) and at least 256 GB of RAM.

[User access][5] to Karolina is provided by four login nodes **login[1-4]**. The nodes are interlinked through high speed InfiniBand and Ethernet networks.

The Accelerated nodes, Data analytics node, and Cloud nodes are available [upon request][a] from a PI. For more information about accessing the nodes, see also the [Resources Allocation Policy][2] section.

For more technical information, see the [Compute Nodes][1] section.

The parameters are summarized in the following tables:

| **In general**                              |                                                |
| ------------------------------------------- | ---------------------------------------------- |
| Primary purpose                             | High Performance Computing                     |
| Architecture of compute nodes               | x86-64                                         |
| Operating system                            | Linux                                          |
| **Compute nodes**                           |                                                |
| Total                                       | 829                                            |
| Processor cores                             | 128/768 (2x32 cores/2x64 cores/32x24 cores)    |
| RAM                                         | min. 256 GB                                    |
| Local disk drive                            | no                                             |
| Compute network                             | InfiniBand HDR                                 |
| Universal compute node                      | 720, Cn[001-720]                               |
| Accelerated compute nodes                   | 72, Acn[01-72]                                 |
| Data analytics compute nodes                | 1, Sdf1                                        |
| Cloud compute nodes                         | 36, CLn[01-36]                                 |
| **In total**                                |                                                |
| Total theoretical peak performance  (Rpeak) | 15.7 PFLOP/s                                   |
| Total amount of RAM                         | 313 TB                                         |

| Node                     | Processor                                | Memory  | Accelerator                  |
| ------------------------ | ---------------------------------------  | ------  | ---------------------------- |
| Universal compute node   | 2 x AMD Zen 2 EPYC™ 7H12, 2.6 GHz        | 256 GB  | -                            |
| Accelerated compute node | 2 x AMD Zen 2 EPYC™ 7763, 2.45 GHz       | 1024 GB | 8 x NVIDIA A100 (40 GB HBM2) |
| Data analytics node      | 32 x Intel Xeon-SC 8268, 2.9 GHz         | 24 TB   | -                            |
| Cloud compute node       | 2 x AMD Zen 2 EPYC™ 7H12, 2.6 GHz        | 256 GB  | -                            |

[1]: compute-nodes.md
[2]: ../general/resources-allocation-policy.md
[3]: network.md
[4]: storage.md
[5]: ../general/shell-and-data-access.md
[6]: visualization.md

[a]: https://support.it4i.cz/rt
