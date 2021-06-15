# GPI-2

## Introduction

Programming Next Generation Supercomputers: GPI-2 is an API library for asynchronous interprocess, cross-node communication. It provides a flexible, scalable, and fault tolerant interface for parallel applications.

The GPI-2 library implements the GASPI specification ([Global Address Space Programming Interface][a]). GASPI is a Partitioned Global Address Space (PGAS) API. It aims at scalable, flexible, and failure-tolerant computing in massively parallel environments.

## Modules

The GPI-2 version 1.0.2 is available on Anselm via the `gpi2` module:

```console
$ ml gpi2

$ ml av GPI-2   # Salomon
```

The module sets up environment variables required for linking and running GPI-2 enabled applications. This particular command loads the default `gpi2/1.0.2` module.

## Linking

!!! note
    Link with -lGPI2 -libverbs

Load the `gpi2` module. Link using `-lGPI2` and `-libverbs` switches to link your code against GPI-2. The GPI-2 requires the OFED InfiniBand communication library ibverbs.

### Compiling and Linking With Intel Compilers

```console
$ ml intel
$ ml gpi2
$ icc myprog.c -o myprog.x -Wl,-rpath=$LIBRARY_PATH -lGPI2 -libverbs
```

### Compiling and Linking With GNU Compilers

```console
$ ml gcc
$ ml gpi2
$ gcc myprog.c -o myprog.x -Wl,-rpath=$LIBRARY_PATH -lGPI2 -libverbs
```

## Running the GPI-2 Codes

!!! note
    `gaspi_run` starts the GPI-2 application

The `gaspi_run` utility is used to start and run GPI-2 applications:

```console
$ gaspi_run -m machinefile ./myprog.x
```

A machine file (** machinefile **) must be provided with the hostnames of nodes where the application will run. The machinefile lists all nodes on which to run, one entry per node per process. This file may be hand created or obtained from standard $PBS_NODEFILE:

```console
$ cut -f1 -d"." $PBS_NODEFILE > machinefile
```

machinefile:

```console
    cn79
    cn80
```

This machinefile will run 2 GPI-2 processes, one on node cn79 and one on node cn80.

machinefle:

```console
    cn79
    cn79
    cn80
    cn80
```

This machinefile will run 4 GPI-2 processes, two on node cn79 and two on node cn80.

!!! note
    Use `mpiprocs` to control how many GPI-2 processes will run per node.

Example:

```console
$ qsub -A OPEN-0-0 -q qexp -l select=2:ncpus=16:mpiprocs=16 -I
```

This example will produce $PBS_NODEFILE with 16 entries per node.

### Gaspi_logger

!!! note
    `gaspi_logger` views the output from GPI-2 application ranks.

The `gaspi_logger` utility is used to view the output from all nodes except the master node (rank 0). `gaspi_logger` is started, on another session, on the master node - the node where the `gaspi_run` is executed. The output of the application, when called with `gaspi_printf()`, will be redirected to the `gaspi_logger`. Other I/O routines (e.g. `printf`) will not.

## Example

Following is an example of GPI-2 enabled code:

```cpp
#include <GASPI.h>
#include <stdlib.h>

void success_or_exit ( const char* file, const int line, const int ec)
{
  if (ec != GASPI_SUCCESS)
    {
      gaspi_printf ("Assertion failed in %s[%i]:%dn", file, line, ec);
      exit (1);
    }
}

#define ASSERT(ec) success_or_exit (__FILE__, __LINE__, ec);

int main(int argc, char *argv[])
{
  gaspi_rank_t rank, num;
  gaspi_return_t ret;

  /* Initialize GPI-2 */
  ASSERT( gaspi_proc_init(GASPI_BLOCK) );

  /* Get ranks information */
  ASSERT( gaspi_proc_rank(&rank) );
  ASSERT( gaspi_proc_num(&num) );

  gaspi_printf("Hello from rank %d of %dn",
           rank, num);

  /* Terminate */
  ASSERT( gaspi_proc_term(GASPI_BLOCK) );

  return 0;
}
```

Load the modules and compile:

```console
$ ml gcc gpi2
$ gcc helloworld_gpi.c -o helloworld_gpi.x -Wl,-rpath=$LIBRARY_PATH -lGPI2 -libverbs
```

Submit the job and run the GPI-2 application:

```console
$ qsub -q qexp -l select=2:ncpus=1:mpiprocs=1,place=scatter,walltime=00:05:00 -I
    qsub: waiting for job 171247.dm2 to start
    qsub: job 171247.dm2 ready
cn79 $ ml gpi2
cn79 $ cut -f1 -d"." $PBS_NODEFILE > machinefile
cn79 $ gaspi_run -m machinefile ./helloworld_gpi.x
    Hello from rank 0 of 2
```

At the same time, in another session, you may start the GASPI logger:

```console
$ ssh cn79
cn79 $ gaspi_logger
    GASPI Logger (v1.1)
    [cn80:0] Hello from rank 1 of 2
```

In this example, we compile the helloworld_gpi.c code using the **gnu compiler**(gcc) and link it to the GPI-2 and the ibverbs library. The library search path is compiled in. For execution, we use the qexp queue, 2 nodes 1 core each. The GPI module must be loaded on the master compute node (in this example cn79), `gaspi_logger` is used from a different session to view the output of the second process.

[a]: http://www.gaspi.de/en/project.html
