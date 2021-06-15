# Introduction

Welcome to the Anselm supercomputer cluster. The Anselm cluster consists of 209 compute nodes, totaling 3344 compute cores with 15 TB RAM, giving over 94 TFLOP/s theoretical peak performance. Each node is a powerful x86-64 computer, equipped with 16 cores, at least 64 GB of RAM, and a 500 GB hard disk drive. Nodes are interconnected through a fully non-blocking fat-tree InfiniBand network and are equipped with Intel Sandy Bridge processors. A few nodes are also equipped with NVIDIA Kepler GPU or Intel Xeon Phi MIC accelerators. Read more in [Hardware Overview][1].

Anselm runs with an operating system compatible with the Red Hat [Linux family][a]. We have installed a wide range of software packages targeted at different scientific domains. These packages are accessible via the [modules environment][2].

The user data shared file-system (HOME, 320 TB) and job data shared file-system (SCRATCH, 146 TB) are available to users.

The PBS Professional workload manager provides [computing resources allocations and job execution][3].

Read more on how to [apply for resources][4], [obtain login credentials][5] and [access the cluster][6].

[1]: hardware-overview.md
[2]: ../environment-and-modules.md
[3]: ../general/resources-allocation-policy.md
[4]: ../general/applying-for-resources.md
[5]: ../general/obtaining-login-credentials/obtaining-login-credentials.md
[6]: ../general/shell-and-data-access.md

[a]: http://upload.wikimedia.org/wikipedia/commons/1/1b/Linux_Distribution_Timeline.svg
