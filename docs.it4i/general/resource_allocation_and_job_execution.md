# Resource Allocation and Job Execution

To run a [job][1], computational resources for this particular job must be allocated. This is done via the PBS Pro job workload manager software, which distributes workloads across the supercomputer. Extensive information about PBS Pro can be found in the [PBS Pro User's Guide][2].

## Resources Allocation Policy

Resources are allocated to the job in a fair-share fashion, subject to constraints set by the queue and resources available to the Project. [The Fair-share][3] ensures that individual users may consume approximately equal amount of resources per week. The resources are accessible via queues for queueing the jobs. The queues provide prioritized and exclusive access to the computational resources. Following queues are the most important:

* **qexp** - Express queue
* **qprod** - Production queue
* **qlong** - Long queue
* **qmpp** - Massively parallel queue
* **qnvidia**, **qmic**, **qfat** - Dedicated queues
* **qfree** - Free resource utilization queue

!!! note
    Check the queue status [here][a].

Read more on the [Resources Allocation Policy][4] page.

## Job Submission and Execution

!!! note
    Use the **qsub** command to submit your jobs.

The `qsub` command creates a request to the PBS Job manager for allocation of specified resources. The **smallest allocation unit is an entire node - 16 cores**, with the exception of the `qexp` queue. The resources will be allocated when available, subject to allocation policies and constraints. **After the resources are allocated, the jobscript or interactive shell is executed on first of the allocated nodes.**

Read more on the [Job Submission and Execution][5] page.

## Capacity Computing

!!! note
    Use Job arrays when running huge number of jobs.

Use GNU Parallel and/or Job arrays when running (many) single core jobs.

In many cases, it is useful to submit a huge (100+) number of computational jobs into the PBS queue system. A huge number of (small) jobs is one of the most effective ways to execute parallel calculations, achieving best runtime, throughput and computer utilization. In this chapter, we discuss the recommended way to run huge numbers of jobs, including **ways to run huge numbers of single core jobs**.

Read more on [Capacity Computing][6] page.

[1]: ../index.md#terminology-frequently-used-on-these-pages
[2]: ../pbspro.md
[3]: job-priority.md#fair-share-priority
[4]: resources-allocation-policy.md
[5]: job-submission-and-execution.md
[6]: capacity-computing.md

[a]: https://extranet.it4i.cz/rsweb/
