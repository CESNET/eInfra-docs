# OpenMPI Sample Applications

Sample MPI applications provided both as a trivial primer to MPI as well as simple tests to ensure that your OpenMPI installation is working properly.

## Examples

There are two MPI examples, each using one of six different MPI interfaces:

### Hello World

```c tab="C"
/*
 * Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
 *                         University Research and Technology
 *                         Corporation.  All rights reserved.
 * Copyright (c) 2006      Cisco Systems, Inc.  All rights reserved.
 *
 * Sample MPI "hello world" application in C
 */

<!-- markdownlint-disable MD018 MD025 -->
#include <stdio.h>
#include "mpi.h"

int main(int argc, char* argv[])
{
    int rank, size, len;
    char version[MPI_MAX_LIBRARY_VERSION_STRING];

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Get_library_version(version, &len);
    printf("Hello, world, I am %d of %d, (%s, %d)\n",
           rank, size, version, len);
    MPI_Finalize();

    return 0;
}
```

```c++ tab="C++"
//
// Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
//                         University Research and Technology
//                         Corporation.  All rights reserved.
// Copyright (c) 2006      Cisco Systems, Inc.  All rights reserved.
//
// Sample MPI "hello world" application in C++
//
// NOTE: The MPI C++ bindings were deprecated in MPI-2.2 and removed
// from the standard in MPI-3.  Open MPI still provides C++ MPI
// bindings, but they are no longer built by default (and may be
// removed in a future version of Open MPI).  You must
// --enable-mpi-cxx when configuring Open MPI to enable the MPI C++
// bindings.
//

<!-- markdownlint-disable MD018 MD025 -->
#include "mpi.h"
<!-- markdownlint-disable MD022 -->
#include <iostream>

int main(int argc, char **argv)
{
    int rank, size, len;
    char version[MPI_MAX_LIBRARY_VERSION_STRING];

    MPI::Init();
    rank = MPI::COMM_WORLD.Get_rank();
    size = MPI::COMM_WORLD.Get_size();
    MPI_Get_library_version(version, &len);
    std::cout << "Hello, world!  I am " << rank << " of " << size
              << "(" << version << ", " << len << ")" << std::endl;
    MPI::Finalize();

    return 0;
}
```

```fortran tab="F mpi.h"
C
C Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
C                         University Research and Technology
C                         Corporation.  All rights reserved.
C Copyright (c) 2006-2015 Cisco Systems, Inc.  All rights reserved.
C $COPYRIGHT$
C
C Sample MPI "hello world" application using the Fortran mpif.h
C bindings.
C
        program main
        implicit none
        include 'mpif.h'
        integer ierr, rank, size, len
        character(len=MPI_MAX_LIBRARY_VERSION_STRING) version

        call MPI_INIT(ierr)
        call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
        call MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierr)
        call MPI_GET_LIBRARY_VERSION(version, len, ierr)

        write(*, '("Hello, world, I am ", i2, " of ", i2, ": ", a)')
     &        rank, size, version

        call MPI_FINALIZE(ierr)

        end
```

```fortran tab="F use mpi"
!
! Copyright (c) 2004-2006 The Trustees of Indiana University and Indiana
!                         University Research and Technology
!                         Corporation.  All rights reserved.
! Copyright (c) 2004-2005 The Regents of the University of California.
!                         All rights reserved.
! Copyright (c) 2006-2015 Cisco Systems, Inc.  All rights reserved.
! $COPYRIGHT$
!
! Sample MPI "hello world" application using the Fortran mpi module
! bindings.
!
program main
    use mpi
    implicit none
    integer :: ierr, rank, size, len
    character(len=MPI_MAX_LIBRARY_VERSION_STRING) :: version

    call MPI_INIT(ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierr)
    call MPI_GET_LIBRARY_VERSION(version, len, ierr)

    write(*, '("Hello, world, I am ", i2, " of ", i2, ": ", a)') &
          rank, size, version

    call MPI_FINALIZE(ierr)
end
```

```java tab="Java"
/*
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
/*
 * Author of revised version: Franklyn Pinedo
 *
 * Adapted from Source Code in C of Tutorial/User's Guide for MPI by
 * Peter Pacheco.
 */
/*
 * Copyright (c) 2011      Cisco Systems, Inc.  All rights reserved.
 *
 */

import mpi.*;

class Hello {
    static public void main(String[] args) throws MPIException {

	MPI.Init(args);

	int myrank = MPI.COMM_WORLD.getRank();
	int size = MPI.COMM_WORLD.getSize() ;
	System.out.println("Hello world from rank " + myrank + " of " + size);

	MPI.Finalize();
    }
}
```

* C:                   [hello_c.c](../../src/ompi/hello_c.c)
* C++:                 [hello_cxx.cc](../../src/ompi/hello_cxx.cc)
* Fortran mpif.h:      [hello_mpifh.f](../../src/ompi/hello_mpifh.f)
* Fortran use mpi:     [hello_usempi.f90](../../src/ompi/hello_usempi.f90)
* Fortran use mpi_f08: [hello_usempif08.f90](../../src/ompi/hello_usempif08.f90)
* Java:                [Hello.java](../../src/ompi/Hello.java)
* C shmem.h:           [hello_oshmem_c.c](../../src/ompi/hello_oshmem_c.c)
* Fortran shmem.fh:    [hello_oshmemfh.f90](../../src/ompi/hello_oshmemfh.f90)

<!-- markdownlint-disable MD001 -->
### Send a Trivial Message Around in a Ring

* C:                   [ring_c.c](../../src/ompi/ring_c.c)
* C++:                 [ring_cxx.cc](../../src/ompi/ring_cxx.cc)
* Fortran mpif.h:      [ring_mpifh.f](../../src/ompi/ring_mpifh.f)
* Fortran use mpi:     [ring_usempi.f90](../../src/ompi/ring_usempi.f90)
* Fortran use mpi_f08: [ring_usempif08.f90](../../src/ompi/ring_usempif08.f90)
* Java:                [Ring.java](../../src/ompi/Ring.java)
* C shmem.h:           [ring_oshmem_c.c](../../src/ompi/ring_oshmem_c.c)
* Fortran shmem.fh:    [ring_oshmemfh.f90](../../src/ompi/ring_oshmemfh.f90)

Additionally, there's one further example application, but this one only uses the MPI C bindings:

<!-- markdownlint-disable MD001 -->
### Test the Connectivity Between All Pross

* C:   [connectivity_c.c](../../src/ompi/connectivity_c.c)

## Build Examples

Download [examples](../../src/ompi/ompi.tar.gz).

The Makefile in this directory will build the examples for the supported languages (e.g., if you do not have the Fortran "use mpi" bindings compiled as part of OpenMPI, those examples will be skipped).

The Makefile assumes that the wrapper compilers mpicc, mpic++, and mpifort are in your path.

Although the Makefile is tailored for OpenMPI (e.g., it checks the *mpi_info* command to see if you have support for C++, mpif.h, use mpi, and use mpi_f08 F90), all of the example programs are pure MPI, and therefore not specific to OpenMPI.  Hence, you can use a different MPI implementation to compile and run these programs if you wish.

```console
[login@cn204.anselm ]$ tar xvf ompi.tar.gz
./
./connectivity_c.c
./Hello.java
./ring_mpifh.f
./hello_oshmem_cxx.cc
...
...
./hello_cxx.cc
[login@cn204.anselm ]$ ml OpenMPI/2.1.1-GCC-6.3.0-2.27
[login@cn204.anselm ]$ make
mpicc -g  hello_c.c  -o hello_c
mpicc -g  ring_c.c  -o ring_c
mpicc -g  connectivity_c.c  -o connectivity_c
mpicc -g  spc_example.c  -o spc_example
mpic++ -g  hello_cxx.cc  -o hello_cxx
mpic++ -g  ring_cxx.cc  -o ring_cxx
mpifort -g  hello_mpifh.f  -o hello_mpifh
mpifort -g  ring_mpifh.f  -o ring_mpifh
mpifort -g  hello_usempi.f90  -o hello_usempi
mpifort -g  ring_usempi.f90  -o ring_usempi
mpifort -g  hello_usempif08.f90  -o hello_usempif08
mpifort -g  ring_usempif08.f90  -o ring_usempif08
mpijavac Hello.java
mpijavac Ring.java
shmemcc -g  hello_oshmem_c.c  -o hello_oshmem
shmemc++ -g  hello_oshmem_cxx.cc  -o hello_oshmemcxx
shmemcc -g  ring_oshmem_c.c  -o ring_oshmem
shmemcc -g  oshmem_shmalloc.c  -o oshmem_shmalloc
shmemcc -g  oshmem_circular_shift.c  -o oshmem_circular_shift
shmemcc -g  oshmem_max_reduction.c  -o oshmem_max_reduction
shmemcc -g  oshmem_strided_puts.c  -o oshmem_strided_puts
shmemcc -g  oshmem_strided_puts.c  -o oshmem_strided_puts
shmemcc -g  oshmem_symmetric_data.c  -o oshmem_symmetric_data
shmemfort -g  hello_oshmemfh.f90  -o hello_oshmemfh
shmemfort -g  ring_oshmemfh.f90  -o ring_oshmemfh
[login@cn204.anselm ]$ find . -executable -type f
./hello_oshmem
./dtrace/myppriv.sh
./dtrace/partrace.sh
./oshmem_shmalloc
./ring_cxx
./ring_usempi
./hello_mpifh
./hello_cxx
./oshmem_max_reduction
./oshmem_symmetric_data
./oshmem_strided_puts
./hello_usempif08
./ring_usempif08
./spc_example
./hello_oshmemfh
./ring_oshmem
./oshmem_circular_shift
./hello_c
./ring_c
./hello_usempi
./ring_oshmemfh
./connectivity_c
./ring_mpifh
```
