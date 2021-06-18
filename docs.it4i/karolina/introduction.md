# Introduction

Karolina is the latest and most powerful supercomputer cluster built for IT4Innovations in Q2 of 2021. The Karolina cluster consists of 827 compute nodes, totaling 102,016 compute cores with 248 TB RAM, giving over 15.2 PFLOP/s theoretical peak performance and is ranked in the top 10 of the most powerful supercomputers in Europe.

Nodes are interconnected through a fully non-blocking fat-tree InfiniBand network, and are equipped with AMD Zen 2 and Intel Cascade Lake architecture processors. Seventy nodes are also equipped with NVIDIA A100 accelerators. Read more in [Hardware Overview][1].

The cluster runs with an operating system compatible with the Red Hat [Linux family][a]. We have installed a wide range of software packages targeted at different scientific domains. These packages are accessible via the [modules environment][2].

The user data shared file-system and job data shared file-system are available to users.

The [PBS Professional Open Source Project][b] workload manager provides [computing resources allocations and job execution][3].

Read more on how to [apply for resources][4], [obtain login credentials][5] and [access the cluster][6].

[1]: hardware-overview.md
[2]: ../environment-and-modules.md
[3]: ../general/resources-allocation-policy.md
[4]: ../general/applying-for-resources.md
[5]: ../general/obtaining-login-credentials/obtaining-login-credentials.md
[6]: ../general/shell-and-data-access.md

[a]: http://upload.wikimedia.org/wikipedia/commons/1/1b/Linux_Distribution_Timeline.svg
[b]: https://www.pbspro.org/
