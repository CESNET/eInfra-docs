# Vasp

## Introduction

The Vienna Ab initio Simulation Package (VASP) is a local computer program for atomic scale materials modelling, e.g. electronic structure calculations and quantum-mechanical molecular dynamics, from first principles.

To use VASP, You need academic licenses from the University of Vienna. Follow the [official FAQ instructions](https://www.vasp.at/faqs/) at the [official website](https://www.vasp.at/).

Once obtained, it is necessary to send us a list of authorized users and their IDs for which you need this access. Please, use only [our ticketing system](https://support.it4i.cz/rt). We are responsible for verifying your licences, and as such, you will be allowed to use VASP in our enviroment only **after** the sucessful verification.

## Installed Versions

For the current list of installed versions, use:

```console
ml av vasp
```

## Running Jobs

To learn how to submit a job, please refer to the [Job Submission and Execution](https://docs.it4i.cz/general/job-submission-and-execution/) part of this documentation.

VASP uses a [Message Passing Interface](https://en.wikipedia.org/wiki/Message_Passing_Interface) to distribute the workload, and as such can be run via the `mpirun` command, such as

```console
mpirun vasp_std
```

### VASP Compilations

VASP can be ran using several different binaries, each being compiled for a specific purpose, for example:

* `vasp_std` is the standard VASP binary for regular jobs
* `vasp_ncl` must be used when running non-collinear (spin-orbit coupling) jobs
* `vasp_gam` is optimized for calculations at the Gamma point

<!---

* `vasp_gpu_std` is a compilation for GPU calculations
* `vasp_gpu_ncl` has to be used when running a non-collinear job on GPU

-->

## Tutorials and Examples

Tutorials and examples can be found at the [offical VASP wiki](https://www.vasp.at/wiki/index.php/The_VASP_Manual), specifically in the sections [Tutorials](https://www.vasp.at/wiki/index.php/Category:Tutorials) and [Examples](https://www.vasp.at/wiki/index.php/Category:Examples). These should provide you with enough information to write and run your own jobs.

VASP wiki also contains all the necessary information about the input and output files, tags, algorithms, and much more.

## Useful Links

* [VASP documentation](https://www.vasp.at/documentation/) containing all the necesary links, including to the VASP wiki, VASP workshop lectures resources, and other
* [VASP wiki](https://www.vasp.at/wiki/index.php/The_VASP_Manual) is **the** resource for questions regarding anything VASP-related
  * [offline PDF version](https://cms.mpi.univie.ac.at/vasp/vasp.pdf)
* [VASP forum](https://www.vasp.at/forum/) to look up & ask questions
* [how to cite VASP](https://www.vasp.at/forum/viewtopic.php?f=4&t=2971)
* [Google](https://www.google.com) :)
