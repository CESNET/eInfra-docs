# Score-P

## Introduction

The [Score-P measurement infrastructure][a] is a highly scalable and easy-to-use tool suite for profiling, event tracing, and online analysis of HPC applications.

Score-P can be used as an instrumentation tool for [Scalasca][1].

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av Score-P
```

## Instrumentation

There are three ways to instrument your parallel applications in order to enable performance data collection:

1. Automated instrumentation using compiler
1. Manual instrumentation using API calls
1. Manual instrumentation using directives

### Automated Instrumentation

This the easiest method. Score-P will automatically add instrumentation to every routine entry and exit using compiler hooks, and will intercept MPI calls and OpenMP regions. However, this method might produce a large number of data. If you want to focus on profiling a specific regions of your code, consider using the manual instrumentation methods. To use automated instrumentation, simply prepend scorep to your compilation command. For example, replace:

```console
$ mpif90 -c foo.f90
$ mpif90 -c bar.f90
$ mpif90 -o myapp foo.o bar.o
```

with:

```console
$ scorep mpif90 -c foo.f90
$ scorep mpif90 -c bar.f90
$ scorep mpif90 -o myapp foo.o bar.o
```

Usually your program is compiled using a Makefile or similar script, so it is advisable to add the `scorep` command to your definition of variables CC, CXX, FCC, etc.

It is important that scorep is prepended also to the linking command, in order to link with Score-P instrumentation libraries.

### Manual Instrumentation Using API Calls

To use this kind of instrumentation, use `scorep` with the `--user` switch. You will then mark regions to be instrumented by inserting API calls.

An example in C/C++:

```cpp
#include <scorep/SCOREP_User.h>
void foo()
{
    SCOREP_USER_REGION_DEFINE( my_region_handle )
    // more declarations
    SCOREP_USER_REGION_BEGIN( my_region_handle, "foo", SCOREP_USER_REGION_TYPE_COMMON )
    // do something
    SCOREP_USER_REGION_END( my_region_handle )
}
```

and Fortran:

```fortran
#include "scorep/SCOREP_User.inc"
subroutine foo
    SCOREP_USER_REGION_DEFINE( my_region_handle )
    ! more declarations
    SCOREP_USER_REGION_BEGIN( my_region_handle, "foo", SCOREP_USER_REGION_TYPE_COMMON )
    ! do something
    SCOREP_USER_REGION_END( my_region_handle )
end subroutine foo
```

Refer to the [documentation for description of the API][b].

### Manual Instrumentation Using Directives

This method uses POMP2 directives to mark regions to be instrumented. To use this method, use the `scorep --pomp` command.

Example directives in C/C++:

```cpp
void foo(...)
{
    /* declarations */
    #pragma pomp inst begin(foo)
    ...
    if (<condition>)
    {
        #pragma pomp inst altend(foo)
        return;
    }
    ...
    #pragma pomp inst end(foo)
}
```

and in Fortran:

```fortran
subroutine foo(...)
    !declarations
    !POMP$ INST BEGIN(foo)
    ...
    if (<condition>) then
 !POMP$ INST ALTEND(foo)
 return
 end if
 ...
 !POMP$ INST END(foo)
end subroutine foo
```

The directives are ignored if the program is compiled without Score-P. For details, refer to the [documentation][c].

[1]: scalasca.md
[2]: ../../modules-matrix.md
[3]: ../compilers.md
[4]: ../mpi/running_openmpi.md
[5]: ../mpi/running-mpich2.md

[a]: http://www.vi-hps.org/projects/score-p/
[b]: https://silc.zih.tu-dresden.de/scorep-current/pdf/scorep.pdf
[c]: https://silc.zih.tu-dresden.de/scorep-current/pdf/scorep.pdf
