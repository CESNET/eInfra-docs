# Hardware Overview

Karolina consists of 827 computational nodes of which 720 are universal compute nodes (**Cn[001-720]**), 70 are NVIDIA A100 accelerated nodes (**Acn[01-70]**), 1 is a data analytics node (**DAcn1**), and 36 are cloud partitions (**CLn[01-36]**). Each node is a powerful x86-64 computer, equipped with 64/128/768 cores (64-core AMD EPYC™ 7H12 / 32-core AMD EPYC™ 7452 / 24-core Intel Xeon-SC 8268) and at least 256 GB of RAM.

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
| Total                                       | 827                                            |
| Processor cores                             | 64/128/768 (2x32 cores/2x64 cores/32x24 cores) |
| RAM                                         | min. 256 GB                                    |
| Local disk drive                            | no                                             |
| Compute network                             | InfiniBand HDR                                 |
| Universal compute node                      | 720, Cn[001-720]                               |
| Accelerated compute nodes                   | 70, Acn[01-70]                                 |
| Data analytics compute nodes                | 1, DAcn1                                       |
| Cloud compute nodes                         | 36, CLn[01-36]                                 |
| **In total**                                |                                                |
| Total theoretical peak performance  (Rpeak) | 15.2 PFLOP/s                                   |
| Total amount of RAM                         | 248 TB                                         |

| Node                     | Processor                                | Memory  | Accelerator            |
| ------------------------ | ---------------------------------------  | ------  | ---------------------- |
| Universal compute node   | 2 x AMD Zen 2 EPYC™ 7H12, 2.6 GHz        | 256 GB  | -                      |
| Accelerated compute node | 2 x AMD Zen 2 EPYC™ 7452, 2.35 GHz       | 512 GB  | NVIDIA A100            |
| Data analytics node      | 32 x Intel Xeon-SC 8268, 2.9 GHz         | 24 TB   | -                      |
| Cloud compute node       | 2 x AMD Zen 2 EPYC™ 7H12, 2.6 GHz        | 256 GB  | -                      |

[1]: compute-nodes.md
[2]: ../general/resources-allocation-policy.md
[3]: network.md
[4]: storage.md
[5]: ../general/shell-and-data-access.md
[6]: visualization.md

[a]: https://support.it4i.cz/rt
