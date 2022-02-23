## Resource Accounting Policy

Starting with the 24<sup>th</sup> open access grant competition, the accounting policy has been changed from [normalized core hours (NCH)][2a] to **node-hours**. This means that it is now required to apply for node hours of the specific cluster and node type:

1. [Barbora CPU][3a]
1. [Barbora GPU][4a] 
1. [Barbora FAT][5a]
1. [DGX-2][6a]
1. [Karolina CPU][7a]
1. [Karolina GPU][8a]
1. [Karolina FAT][9a]

The accounting runs whenever the nodes are allocated via the PBS Pro workload manager (the qsub command), regardless of whether
the nodes are actually used for any calculation.

### Conversion Table

| Resources | Conversion for 1 node-hour |
| ------------ | ----------------------- | 
| Barbora CPU  | 36 core-hours           |
| Barbora GPU  | 4 GPU core-hours        |
| Barbora FAT  | 128 core-hours          |
| DGX-2        | 16 GPU core-hours       |
| Karolina CPU | 128 core-hours          |
| Karolina GPU | 8 GPU core-hours        |
| Karolina FAT | 768 core-hours          |

## Original Resource Accounting Policy

The original policy, as stated below, is still applied to projects from previous grant competitions.

### Wall-Clock Core-Hours WCH

The wall-clock core-hours (WCH) are the basic metric of computer utilization time.
1 wall-clock core-hour is defined as 1 processor core allocated for 1 hour of wall-clock time. For example, allocating a full node (i.e. 24 cores) on Salomon for 1 hour amounts to 24 wall-clock core-hours.

### Normalized Core-Hours NCH

The resources subject to accounting are the normalized core-hours (NCH).
The normalized core-hours are obtained from WCH by applying a normalization factor:

$$
NCH = F*WCH
$$

All jobs are accounted in normalized core-hours, using factor F valid at the time of the execution:

| System        | F    | Validity                  |
| --------------| ---: | --------                  |
| Karolina      | 1.00 |  2021-08-02 to 2022-09-06 |
| Barbora CPU   | 1.40 |  2020-02-01 to 2022-09-06 |
| Barbora GPU   | 4.50 |  2020-04-01 to 2022-09-06 |
| DGX-2         | 5.50 |  2020-04-01 to 2022-09-06 |

The normalized core-hours were introduced to treat systems of different age on equal footing.
Normalized core-hour is an accounting tool to discount the legacy systems.

See examples in the [Job submission and execution][1a] section.

### Consumed Resources

Check how many core-hours have been consumed. The command `it4ifree` is available on cluster login nodes.

```console
$ it4ifree

Projects I am participating in
==============================
PID         Days left      Total    Used WCHs    Used NCHs    WCHs by me    NCHs by me     Free
----------  -----------  -------  -----------  -----------  ------------  ------------  -------
OPEN-XX-XX  323                0      5169947      5169947         50001         50001  1292555


Projects I am Primarily Investigating
=====================================
PID        Login         Used WCHs    Used NCHs
---------- ----------  -----------  -----------
OPEN-XX-XX user1            376670       376670
           user2           4793277      4793277

Legend
======
WCH   =    Wall-clock Core Hour
NCH   =    Normalized Core Hour
```

The `it4ifree` command is a part of the `it4i.portal.clients` package, located [here][pypi].

[1a]: job-submission-and-execution.md
[2a]: #normalized-core-hours-nch
[3a]: ../../barbora/compute-nodes/#compute-nodes-without-accelerators
[4a]: ../../barbora/compute-nodes/#compute-nodes-with-a-gpu-accelerator
[5a]: ../../barbora/compute-nodes/#fat-compute-node
[6a]: ../../dgx2/introduction/
[7a]: ../../karolina/compute-nodes/#compute-nodes-without-accelerators
[8a]: ../../karolina/compute-nodes/#compute-nodes-with-a-gpu-accelerator
[9a]: ../../karolina/compute-nodes/#data-analytics-compute-node

[pypi]: https://pypi.python.org/pypi/it4i.portal.clients
