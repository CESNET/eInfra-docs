# Debuggers and Profilers Summary

## Introduction

We provide state of the art programs and tools to develop, profile, and debug HPC codes at IT4Innovations. In this cestion, we provide an overview of the profiling and debugging tools available on IT4I clusters.

## Intel Debugger

The Intel debugger is no longer available since Parallel Studio version 2015

The Intel debugger version 13.0 is available, via the intel module. The debugger works for applications compiled with C and C++ compiler and the ifort fortran 77/90/95 compiler. The debugger provides a Java GUI environment.

```console
$ ml intel
$ idb
```

Read more at the [Intel Debugger][1] page.

## Allinea Forge (DDT/MAP)

Allinea DDT is a commercial debugger primarily for debugging parallel MPI or OpenMP programs. It also has a support for GPU (CUDA) and Intel Xeon Phi accelerators. DDT provides all the standard debugging features (stack trace, breakpoints, watches, view variables, threads, etc.) for every thread running as part of your program, or for every process - even if these processes are distributed across a cluster using an MPI implementation.

```console
$ ml Forge
$ forge
```

Read more at the [Allinea DDT][2] page.

## Allinea Performance Reports

Allinea Performance Reports characterize the performance of HPC application runs. After executing your application through the tool, a synthetic HTML report is generated automatically, containing information about several metrics along with clear behavior statements and hints to help you improve the efficiency of your runs. Our license is limited to 64 MPI processes.

```console
$ ml PerformanceReports/6.0
$ perf-report mpirun -n 64 ./my_application argument01 argument02
```

Read more at the [Allinea Performance Reports][3] page.

## RougeWave Totalview

TotalView is a source- and machine-level debugger for multi-process, multi-threaded programs. Its wide range of tools provides ways to analyze, organize, and test programs, making it easy to isolate and identify problems in individual threads and processes in programs of great complexity.

```console
$ ml TotalView/8.15.4-6-linux-x86-64
$ totalview
```

Read more at the [Totalview][4] page.

## Vampir Trace Analyzer

Vampir is a GUI trace analyzer for traces in OTF format.

```console
    $ ml Vampir/8.5.0
    $ vampir
```

Read more at the [Vampir][5] page.

[1]: ../intel/intel-suite/intel-debugger.md
[2]: allinea-ddt.md
[3]: allinea-performance-reports.md
[4]: total-view.md
[5]: vampir.md
