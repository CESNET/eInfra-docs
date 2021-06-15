# Allinea Performance Reports

## Introduction

Allinea Performance Reports characterize the performance of HPC application runs. After executing your application through the tool, a synthetic HTML report is generated automatically, containing information about several metrics along with clear behavior statements and hints to help you improve the efficiency of your runs.

Allinea Performance Reports is most useful in profiling MPI programs.

Our license is limited to 64 MPI processes.

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av PerformanceReports
```

The module sets up environment variables, required for using the Allinea Performance Reports.

## Usage

Instead of [running your MPI program the usual way][1], use the `perf-report` wrapper:

```console
$ perf-report mpirun ./mympiprog.x
```

The MPI program will run as usual. `perf-report` creates two additional files, in \*.txt and \*.html format, containing the performance report. Note that demanding MPI code should be run within [the queue system][2].

## Example

In this example, we will be profiling the mympiprog.x MPI program, using Allinea performance reports. Assume that the code is compiled with Intel compilers and linked against Intel MPI library:

First, we allocate nodes via the express queue:

```console
$ qsub -q qexp -l select=2:ppn=24:mpiprocs=24:ompthreads=1 -I
    qsub: waiting for job 262197.dm2 to start
    qsub: job 262197.dm2 ready
```

Then we load the modules and run the program the usual way:

```console
$ ml intel
$ ml PerfReports/6.0
$ mpirun ./mympiprog.x
```

Now let us profile the code:

```console
$ perf-report mpirun ./mympiprog.x
```

Performance report files [mympiprog_32p\*.txt][3] and [mympiprog_32p\*.html][4] were created. We can see that the code is very efficient on MPI and is CPU bounded.

[1]: ../mpi/mpi.md
[2]: ../../general/job-submission-and-execution.md
[3]: mympiprog_32p_2014-10-15_16-56.txt
[4]: mympiprog_32p_2014-10-15_16-56.html
