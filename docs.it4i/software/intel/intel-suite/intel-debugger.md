# Intel Debugger

!!! note
    IDB is no longer available since Intel Parallel Studio 2015.

## Introduction

The Intel debugger version is available via the `intel/13.5.192` module. The debugger works for serial and parallel applications compiled with the C and C++ compiler and the ifort Fortran 77/90/95 compiler. The debugger provides a Java GUI environment. Use [X display][1] to run the GUI.

```console
$ ml intel/13.5.192
$ ml Java
$ idb
```

The debugger may run in text mode. To debug in the text mode, use:

```console
$ idbc
```

To debug on compute nodes, the `intel` module must be loaded. The GUI on compute nodes may be accessed using the same way as in the [GUI section][1].

## Debugging Serial Applications

Example:

```console
$ qsub -q qexp -l select=1:ncpus=24 -X -I
    qsub: waiting for job 19654.srv11 to start
    qsub: job 19654.srv11 ready
$ ml intel
$ ml Java
$ icc -O0 -g myprog.c -o myprog.x
$ idb ./myprog.x
```

In this example, we allocate 1 full compute node, compile the myprog.c program with the `-O0 -g` debugging options and run the IDB debugger interactively on the myprog.x executable. The GUI access is via the X11 port forwarding provided by the PBS workload manager.

## Debugging Parallel Applications

 The Intel debugger is capable of debugging multithreaded and MPI parallel programs as well.

### Small Number of MPI Ranks

For debugging small number of MPI ranks, you may execute and debug each rank in a separate xterm terminal (do not forget the [X display][1]. Using Intel MPI, this may be done in the following way:

```console
$ qsub -q qexp -l select=2:ncpus=24 -X -I
    qsub: waiting for job 19654.srv11 to start
    qsub: job 19655.srv11 ready
$ ml intel
$ mpirun -ppn 1 -hostfile $PBS_NODEFILE --enable-x xterm -e idbc ./mympiprog.x
```

In this example, we allocate 2 full compute nodes, run xterm on each node, and start the IDB debugger in the command line mode, debugging two ranks of the mympiprog.x application. The xterm will pop up for each rank with IDB prompt ready. The example is not limited to use of Intel MPI.

### Large Number of MPI Ranks

Run the IDB debugger from within the MPI debug option. This will cause the debugger to bind to all ranks and provide aggregated outputs across the ranks, pausing execution automatically just after startup. You may then set break points and step the execution manually. Using Intel MPI:

```console
$ qsub -q qexp -l select=2:ncpus=24 -X -I
    qsub: waiting for job 19654.srv11 to start
    qsub: job 19655.srv11 ready
$ ml intel
$ mpirun -n 48 -idb ./mympiprog.x
```

### Debugging Multithreaded Application

Run the IDB debugger in GUI mode. The Parallel menu contains a number of tools for debugging multiple threads. One of the most useful tools is the **Serialize Execution** tool, which serializes execution of concurrent threads for easy orientation and identification of concurrency related bugs.

## Further Information

Exhaustive manual on IDB features and usage is published at the [Intel website][a].

[1]: ../../../general/accessing-the-clusters/graphical-user-interface/x-window-system.md

[a]: https://software.intel.com/sites/products/documentation/doclib/iss/2013/compiler/cpp-lin/
