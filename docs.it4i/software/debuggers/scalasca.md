# Scalasca

## Introduction

[Scalasca][a] is a software tool that supports the performance optimization of parallel programs by measuring and analyzing their runtime behavior. The analysis identifies potential performance bottlenecks – in particular those concerning communication and synchronization – and offers guidance in exploring their causes.

Scalasca supports profiling of MPI, OpenMP and hybrid MPI+OpenMP applications.

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av Scalasca
```

## Usage

Profiling a parallel application with Scalasca consists of three steps:

1. Instrumentation, compiling the application such way, that the profiling data can be generated.
1. Runtime measurement, running the application with the Scalasca profiler to collect performance data.
1. Analysis of reports

### Instrumentation

Instrumentation via `scalasca -instrument` is discouraged. Use [Score-P instrumentation][5].

### Runtime Measurement

After the application is instrumented, runtime measurement can be performed with the `scalasca -analyze` command. The syntax is:

`scalasca -analyze [scalasca options] [launcher] [launcher options] [program] [program options]`

An example:

```console
   $ scalasca -analyze mpirun -np 4 ./mympiprogram
```

Some notable Scalasca options are:

* `-t` enables trace data collection. By default, only summary data are collected.
* `-e <directory>` specifies a directory to which the collected data is saved. By default, Scalasca saves the data to a directory with the scorep\_ prefix, followed by the name of the executable and the launch configuration.

!!! note
    Scalasca can generate a huge amount of data, especially if tracing is enabled. Consider saving the data to a [scratch directory][6].

### Analysis of Reports

For the analysis, you must have the [Score-P][5] and [CUBE][7] modules loaded. The analysis is done in two steps. First, the data is preprocessed and then, the CUBE GUI tool is launched.

To launch the analysis, run:

```console
scalasca -examine [options] <experiment_directory>
```

If you do not wish to launch the GUI tool, use the `-s` option:

```console
scalasca -examine -s <experiment_directory>
```

Alternatively, you can open CUBE and load the data directly from here. Keep in mind that in this case, the pre-processing is not done and not all metrics will be shown in the viewer.

Refer to the [CUBE documentation][7] on usage of the GUI viewer.

## References

1. [http://www.scalasca.org/][a]

[1]: ../../modules-matrix.md
[2]: ../compilers.md
[3]: ../mpi/running_openmpi.md
[4]: ../mpi/running-mpich2.md
[5]: score-p.md
[6]: ../../salomon/storage.md
[7]: cube.md

[a]: http://www.scalasca.org/
