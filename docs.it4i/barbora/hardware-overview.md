# Hardware Overview

The Barbora cluster consists of 201 computational nodes named **cn[1-201]** of which 192 are regular compute nodes, 8 are GPU Tesla V100 accelerated nodes and 1 is a fat node. Each node is a powerful x86-64 computer, equipped with 36/24/128 cores (18-core Intel Cascade Lake 6240 / 12-core Intel Skylake Gold 6126 / 16-core Intel Skylake 8153), at least 192 GB of RAM. User access to the Barbora cluster is provided by two login nodes **login[1,2]**. The nodes are interlinked through high speed InfiniBand and Ethernet networks.

The Fat node is equipped with a large amount (6144 GB) of memory. Virtualization infrastructure provides resources to run long-term servers and services in virtual mode. The Accelerated nodes, Fat node, and Virtualization infrastructure are available [upon request][a] from a PI.

**There are three types of compute nodes:**

* 192 compute nodes without an accelerator
* 8 compute nodes with a GPU accelerator - 4x NVIDIA Tesla V100-SXM2
* 1 fat node - equipped with 6144 GB of RAM

[More about Compute nodes][1].

GPU and accelerated nodes are available upon request, see the [Resources Allocation Policy][2].

All of these nodes are interconnected through fast InfiniBand and Ethernet networks.  [More about the Network][3].
Every chassis provides an InfiniBand switch, marked **isw**, connecting all nodes in the chassis, as well as connecting the chassis to the upper level switches.

User access to Barbora is provided by two login nodes: login1 and login2. [More about accessing the cluster][5].

The parameters are summarized in the following tables:

| **In general**                              |                                              |
| ------------------------------------------- | -------------------------------------------- |
| Primary purpose                             | High Performance Computing                   |
| Architecture of compute nodes               | x86-64                                       |
| Operating system                            | Linux                                        |
| [**Compute nodes**][1]                      |                                              |
| Total                                       | 201                                          |
| Processor cores                             | 36/24/128 (2x18 cores/2x12 cores/8x16 cores) |
| RAM                                         | min. 192 GB                                  |
| Local disk drive                            | no                                           |
| Compute network                             | InfiniBand HDR                               |
| w/o accelerator                             | 192, cn[1-192]                               |
| GPU accelerated                             | 8, cn[194-200]                               |
| Fat compute nodes                           | 1, cn[201]                                   |
| **In total**                                |                                              |
| Total theoretical peak performance  (Rpeak) | 848.8448 TFLOP/s                             |
| Total amount of RAM                         | 44.544 TB                                    |

| Node             | Processor                                | Memory  | Accelerator            |
| ---------------- | ---------------------------------------  | ------  | ---------------------- |
| w/o accelerator  | 2 x Intel Cascade Lake 6240, 2.6 GHz     | 192 GB  | -                      |
| GPU accelerated  | 2 x Intel Skylake Gold 6126, 2.6 GHz     | 192 GB  | NVIDIA Tesla V100-SXM2 |
| Fat compute node | 2 x Intel Skylake Platinum 8153, 2.0 GHz | 6144 GB | -                      |

For more details refer to [Compute nodes][1], [Storage][4], [Visualization servers][6], and [Network][3].

[1]: compute-nodes.md
[2]: ../general/resources-allocation-policy.md
[3]: network.md
[4]: storage.md
[5]: ../general/shell-and-data-access.md
[6]: visualization.md

[a]: https://support.it4i.cz/rt
