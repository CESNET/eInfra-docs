# OpenCoarrays

## Introduction

Coarray Fortran (CAF) is an extension of Fortran language and offers a simple interface for parallel processing and memory sharing.
The advantage is that only small changes are required to convert existing Fortran code to support a robust and potentially efficient parallelism.

A CAF program is interpreted as if it was replicated a number of times and all copies were executed asynchronously.
The number of copies is decided at execution time. Each copy (called *image*) has its own private variables.
The variable syntax of Fortran language is extended with indexes in square brackets (called *co-dimension*) representing a reference to data distributed across images.

By default, the CAF is using Message Passing Interface (MPI) for lower-level communication, so there are some similarities with MPI.

Read more [here][a].

## Coarray Basics

### Indexing of Coarray Images

Indexing of individual images can be shown on the simple *Hello World* program:

```fortran
program hello_world
  implicit none
  print *, 'Hello world from image ', this_image() , 'of', num_images()
end program hello_world
```

* `num_images()` - returns the number of all images
* `this_image()` - returns the image index - numbered from 1 to `num_images()`

### Co-Dimension Variables Declaration

Coarray variables can be declared with the `codimension[*]` attribute or by adding a trailing index `[*]` after the variable name.
Notice, the `*` character always has to be in the square brackets.

```fortran
integer, codimension[*] :: scalar
integer :: scalar[*]
real, dimension(64), codimension[*] :: vector
real :: vector(64)[*]
```

### Images Synchronization

Because each image is running on its own, the image synchronization is needed to ensure, that all altered data is distributed to all images.
Synchronization can be done across all images or only between selected images. Be aware, that selective synchronization can lead to the race condition problems like deadlock.

Example program:

```fortran
program synchronization_test
  implicit none
  integer :: i          ! Local variable
  integer :: numbers[*] ! Scalar coarray

  ! Genereate random number on image 1
  if (this_image() == 1) then
    numbers = floor(rand(1) * 1000)
    ! Distribute information to other images
    do i = 2, num_images()
      numbers[i] = numbers
    end do
  end if

  sync all ! Barrier to synchronize all images

  print *, 'The random number is', numbers
end program synchronization_test
```

* `sync all` - Synchronize all images between each other
* `sync images(*)` - Synchronize this image to all other
* `sync images(index)` - Synchronize this image to image with `index`

!!! note
    `number` is the local variable while `number[index]` accesses the variable in the specific image.
    `number[this_image()]` is the same as `number`.

## Compile and Run

Currently, version 2.9.2 compiled with the OpenMPI 4.0.5 library is installed on the cluster. To load the `OpenCoarrays` module, type:

```console
$ ml OpenCoarrays/2.9.2-gompi-2020b
```

### Compile CAF Program

The preferred method for compiling a CAF program is by invoking the `caf` compiler wrapper.
The above mentioned *Hello World* program can be compiled as follows:

```console
$ caf hello_world.f90 -o hello_world.x
```

!!! warning
    The input file extension **.f90** or **.F90** are to be interpreted as *Fortran 90*.
    If the input file extension is **.f** or **.F** the source code will be interpreted as *Fortran 77*.

Another method for compiling is by invoking the `mpif90` compiler wrapper directly:

```console
$ mpif90 hello_world.f90 -o hello_world.x -fcoarray=lib -lcaf_mpi
```

### Run CAF Program

A CAF program can be run by invoking the `cafrun` wrapper or directly by the `mpirun`:

```console
$ cafrun -np 4 ./hello_world.x
    Hello world from image            1 of           4
    Hello world from image            2 of           4
    Hello world from image            3 of           4
    Hello world from image            4 of           4

$ mpirun -np 4 ./synchronization_test.x
    The random number is         242
    The random number is         242
    The random number is         242
    The random number is         242
```

`-np 4` is the number of images to run. The parameters of `cafrun` and `mpirun` are the same.

[a]: http://www.opencoarrays.org/
