# Documentation

Welcome to the IT4Innovations documentation.
The IT4Innovations National Supercomputing Center operates the [Karolina][1] and [Barbora][2] supercomputers.
The supercomputers are available to the academic community within the Czech Republic and Europe, and the industrial community worldwide.
The purpose of these pages is to provide comprehensive documentation of the hardware, software, and usage of the computers.

## How to Read the Documentation

1. Select the subject of interest from the left column or use the Search tool in the upper right corner.
1. Scan for all the notes and reminders on the page.
1. If more information is needed, read the details and **look for examples** illustrating the concepts.

## Required Proficiency

!!! note
    Basic proficiency in Linux environments is required.

In order to use the system for your calculations, you need basic proficiency in Linux environments.
To gain this proficiency, we recommend you read the [introduction to Linux][a] operating system environments,
and install a Linux distribution on your personal computer.
For example, the [CentOS][b] distribution is similar to systems on the clusters at IT4Innovations and it is easy to install and use,
but any Linux distribution would do.

!!! note
    Learn how to parallelize your code.

In many cases, you will run your own code on the cluster.
In order to fully exploit the cluster, you will need to carefully consider how to utilize all the cores available on the node
and how to use multiple nodes at the same time.
You need to **parallelize** your code.
Proficiency in MPI, OpenMP, CUDA, UPC, or GPI2 programming may be gained via [training provided by IT4Innovations][c].

## Terminology Frequently Used on These Pages

* **node:** a computer, interconnected via a network to other computers – Computational nodes are powerful computers, designed for, and dedicated to executing demanding scientific computations.
* **core:** a processor core, a unit of processor, executing computations
* **node-hour:** a metric of computer utilization, [see definition][3].
* **job:** a calculation running on the supercomputer – the job allocates and utilizes the resources of the supercomputer for certain time.
* **HPC:** High Performance Computing
* **HPC (computational) resources:** nodehours, storage capacity, software licenses
* **code:** a program
* **primary investigator (PI):** a person responsible for execution of computational project and utilization of computational resources allocated to that project
* **collaborator:** a person participating in the execution of a computational project and utilization of computational resources allocated to that project
* **project:** a computational project under investigation by the PI – the project is identified by the project ID. Computational resources are allocated and charged per project.
* **jobscript:** a script to be executed by the PBS Professional workload manager

## Conventions

In this documentation, you will find a number of examples.
We use the following conventions:

Cluster command prompt:

```console
$
```

Your local Linux host command prompt:

```console
local $
```

## Errors

Although we have taken every care to ensure the accuracy of the content, mistakes do happen.
If you find an inconsistency or error, please report it by visiting [support][d], creating a new ticket, and entering the details.
By doing so, you can save other readers from frustration and help us improve.

[1]: karolina/introduction.md
[2]: barbora/introduction.md
[3]: general/resources-allocation-policy.md#resource-accounting-policy

[a]: http://www.tldp.org/LDP/intro-linux/html/
[b]: http://www.centos.org/
[c]: https://www.it4i.cz/en/education/training-activities
[d]: http://support.it4i.cz/rt
