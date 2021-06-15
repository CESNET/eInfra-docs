# Accessing the DGX-2

## Before You Access

!!! warning
    GPUs are single-user devices. GPU memory is not purged between job runs and it can be read (but not written) by any user. Consider the confidentiality of your running jobs.

## How to Access

The DGX-2 machine can be accessed through the scheduler from Salomon login nodes `salomon.it4i.cz`.

The NVIDIA DGX-2 has its own instance of the scheduler, it can be accessed by loading the `DGX-2` module. See [Resource Allocation and Job Execution][1].

[1]: job_execution.md
