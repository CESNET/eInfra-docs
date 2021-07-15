## Resource Accounting Policy

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
| Barbora CPU   | 1.40 |  2020-02-01 to 2021-06-30 |
| Barbora GPU   | 4.50 |  2020-04-01 to 2021-06-30 |
| DGX-2         | 5.50 |  2020-04-01 to 2021-06-30 |
| Salomon       | 1.00 |  2017-09-11 to 2021-06-30 |


The accounting runs whenever the computational cores are allocated via the PBS Pro workload manager (the qsub command), regardless of whether
the cores are actually used for any calculation.

!!! note
    **The allocations are requested/granted in normalized core-hours NCH.**

!!! warning
    Whenever the term core-hour is used in this documentation, we mean the normalized core-hour, NCH.

The normalized core-hours were introduced to treat systems of different age on equal footing.
Normalized core-hour is an accounting tool to discount the legacy systems. The past (before 2017-09-11) F factors are all 1.0.
In future, the factors F will be updated, as new systems are installed. Factors F are expected to only decrease in time.

See examples in the [Job submission and execution][1] section.

### Consumed Resources

Check how many core-hours have been consumed. The command it4ifree is available on cluster login nodes.

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

[1]: job-submission-and-execution.md

[pypi]: https://pypi.python.org/pypi/it4i.portal.clients
