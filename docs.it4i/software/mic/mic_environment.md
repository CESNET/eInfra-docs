# Intel Xeon Phi Environment

The Intel Xeon Phi (so-called MIC) accelerator can be used in several modes ([Offload][1] and [Native][2]). The default mode on the cluster is the offload mode, but all modes described in this document are supported.

For more details, see the sections below.

## Intel Utilities for Xeon Phi

Continue [here][3].

## GCC With KNC Support

On Salomon, we have the `GCC/5.1.1-knc` module with cross-compiled (offload) support for [KNC][a]. (gcc, g++ and gfortran)

!!! warning
    Available on Salomon only.

To compile a code using GCC compiler, run the following commands:

* Create `reduce_mul.c`:

```console
$ vim reduce_mul.c
```

```c
#include <immintrin.h>

double reduce(double* values)
{
   __m512d val = _mm512_load_pd(values);
   return _mm512_reduce_mul_pd(val);
}
```

* Create `main.c`:

```console
vim main.c
```

```c
#include <immintrin.h>
#include <stdio.h>
#include <stdlib.h>

double reduce(double* values);

int main(int argc, char* argv[])
{
   // Generate random input vector of [-1, 1] values.
   double values[8] __attribute__((aligned(64)));
   for (int i = 0; i < 8; i++)
      values[i] = 2 * (0.5 - rand() / (double)RAND_MAX);

   double vector = reduce(values);
   double scalar = values[0];
   for (int i = 1; i < 8; i++)
      scalar *= values[i];

   printf("%f vs %f\n", vector, scalar);

   fflush(stdout);

   return 0;
}
```

* Compile:

```console
$ ml GCC/5.1.1-knc
$ gcc -mavx512f -O3 -c reduce_mul.c -o reduce_mul.s -S
$ gcc -O3 -c reduce_mul.s -o reduce_mul.o
$ gcc -std=c99 -O3 -c main.c -o main_gcc.o
$ gcc -O3 reduce_mul.o main_gcc.o -o reduce_mul
```

* To execute the code, run the following command on the host:

```console
$ micnativeloadex ./reduce_mul
-0.004276 vs -0.004276
```

## Native Mode

In the native mode, a program is executed directly on Intel Xeon Phi without involvement of the host machine. Similarly to offload mode, the code is compiled on the host computer with Intel compilers.

To compile code, the user has to be connected to a compute node with MIC and load the Intel compilers module. To get an interactive session on a compute node with an Intel Xeon Phi and load the module, use following commands:

```console
$ qsub -I -q qprod -l select=1:ncpus=24:accelerator=True -A NONE-0-0
$ ml intel/2017b
```

To produce a binary compatible with the Intel Xeon Phi architecture, the user has to specify the `-mmic` compiler flag. Two compilation examples are shown below. The first example shows how to compile the OpenMP parallel code `vect-add.c` for host only:

```c
#include <stdio.h>

typedef int T;

#define SIZE 1000

#pragma offload_attribute(push, target(mic))
T in1[SIZE];
T in2[SIZE];
T res[SIZE];
#pragma offload_attribute(pop)

// MIC function to add two vectors
__attribute__((target(mic))) add_mic(T *a, T *b, T *c, int size) {
  int i = 0;
  #pragma omp parallel for
    for (i = 0; i < size; i++)
      c[i] = a[i] + b[i];
}

// CPU function to add two vectors
void add_cpu (T *a, T *b, T *c, int size) {
  int i;
  for (i = 0; i < size; i++)
    c[i] = a[i] + b[i];
}

// CPU function to generate a vector of random numbers
void random_T (T *a, int size) {
  int i;
  for (i = 0; i < size; i++)
    a[i] = rand() % 10000; // random number between 0 and 9999
}

// CPU function to compare two vectors
int compare(T *a, T *b, T size ){
  int pass = 0;
  int i;
  for (i = 0; i < size; i++){
    if (a[i] != b[i]) {
      printf("Value mismatch at location %d, values %d and %dn",i, a[i], b[i]);
      pass = 1;
    }
  }
  if (pass == 0) printf ("Test passedn"); else printf ("Test Failedn");
  return pass;
}

int main()
{
  int i;
  random_T(in1, SIZE);
  random_T(in2, SIZE);

  #pragma offload target(mic) in(in1,in2)  inout(res)
  {

    // Parallel loop from main function
    #pragma omp parallel for
    for (i=0; i<SIZE; i++)
      res[i] = in1[i] + in2[i];

    // or parallel loop is called inside the function
    add_mic(in1, in2, res, SIZE);

  }

  //Check the results with CPU implementation
  T res_cpu[SIZE];
  add_cpu(in1, in2, res_cpu, SIZE);
  compare(res, res_cpu, SIZE);

}
```

```console
$ icc -xhost -no-offload -fopenmp vect-add.c -o vect-add-host
```

* To run this code on host, use:

```console
$ ./vect-add-host
Test passed
```

* The second example shows how to compile the same code for Intel Xeon Phi:

```console
$ icc -mmic -fopenmp vect-add.c -o vect-add-mic
```

* Execution of the Program in Native Mode on Intel Xeon Phi:

The user access to the Intel Xeon Phi is through the SSH. Since user home directories are mounted using NFS on the accelerator, users do not have to copy binary files or libraries between the host and accelerator. Get the PATH of MIC enabled libraries for currently used Intel Compiler.

* To run this code on Intel Xeon Phi:

```console
$ ssh mic0
$ ./vect-add-mic
./vect-add-mic: error while loading shared libraries: libiomp5.so: cannot open shared object file: No such file or directory
$ export LD_LIBRARY_PATH=LD_LIBRARY_PATH:/apps/all/icc/2017.4.196-GCC-6.4.0-2.28/compilers_and_libraries/linux/lib/mic
$ ./vect-add-mic
Test passed
```

!!! tip
    Alternatively, use the procedure from the [Devel Environment][4] chapter.

## Only Intel Xeon Phi Cards

Execute a native job:

```console
$ qsub -A NONE-0-0 -q qmic -l select=1 -l walltime=10:00:00 -I
r21u01n577-mic1:~$
```

## Devel Environment

To get an overview of the currently loaded modules, use `module list` or `ml` (without specifying extra arguments):

```console
r21u02n578-mic0:~$ ml
No modules loaded
```

To get an overview of all available modules, you can use `ml avail` or simply `ml av`:

```console
r21u02n578-mic0:~$ ml av

-------------- /apps/phi/system/devel --------------------------
   devel_environment/1.0 (S)

  Where:
   S:  Module is Sticky, requires --force to unload or purge

```

Activate devel environment:

```console
r21u02n578-mic0:~$ ml devel_environment
```

And again to get an overview of all available modules, you can use `ml avail` or simply `ml av`:

```console
r21u02n578-mic0:~$ ml av

-------------- /apps/phi/modules/compiler --------------------------
   icc/2017.4.196-GCC-6.4.0-2.28

-------------- /apps/phi/modules/devel --------------------------
   M4/1.4.18    devel_environment/1.0 (S)    ncurses/6.0

-------------- /apps/phi/modules/lang --------------------------
   Bison/3.0.4    Tcl/8.6.6    flex/2.6.4

-------------- /apps/phi/modules/lib --------------------------
   libreadline/7.0    zlib/1.2.11

-------------- /apps/phi/modules/math --------------------------
   Octave/3.8.2

-------------- /apps/phi/modules/mpi --------------------------
   impi/2017.3.196-iccifort-2017.4.196-GCC-6.4.0-2.28

-------------- /apps/phi/modules/toolchain --------------------------
   iccifort/2017.4.196-GCC-6.4.0-2.28    ifort/2017.4.196-GCC-6.4.0-2.28

-------------- /apps/phi/modules/tools --------------------------
   bzip2/1.0.6    cURL/7.53.1    expat/2.2.5

-------------- /apps/phi/modules/vis --------------------------
   gettext/0.19.8

  Where:
   S:  Module is Sticky, requires --force to unload or purge

```

After loading the `devel_environment` module, modules for the k1om-mpss-linux architecture become available and system software (GCC, CMake, Make, Git, htop, Vim...) can be used.

* Example

```console
r21u02n578-mic0:~$ gcc --version
gcc (GCC) 5.1.1
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

@r21u02n578-mic0:~$ cmake --version
cmake version 2.8.7

r21u02n578-mic0:~$ git --version
git version 1.7.7

r21u02n578-mic0:~$ make --version
GNU Make 3.82
Built for k1om-mpss-linux-gnu
Copyright (C) 2010  Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

r21u02n578-mic0:~$ perl --version

This is perl 5, version 14, subversion 2 (v5.14.2) built for k1om-linux

Copyright 1987-2011, Larry Wall

Perl may be copied only under the terms of either the Artistic License or the
GNU General Public License, which may be found in the Perl 5 source kit.

Complete documentation for Perl, including FAQ lists, should be found on
this system using "man perl" or "perldoc perl".  If you have access to the
Internet, point your browser at http://www.perl.org/, the Perl Home Page.

...
```

* Execute previous cross-compiled code `vect-add-mic`

```console
r21u01n577-mic1:~$ ml devel_environment
r21u01n577-mic1:~$ ml icc
r21u01n577-mic1:~$ ./vect-add-mic
Test passed
```

!!! tip
    PATH of MIC libraries for Intel Compiler is set automatically.

## Modules

Examples for modules.

### MPI

Load the `devel_environment` and the `impi/2017.3.196-iccifort-2017.4.196-GCC-6.4.0-2.28` (`intel/2017b`) modules.

Execute the test:

```console
$ qsub -A SERVICE -q qmic -l select=4 -l walltime=01:00:00 -I
r21u01n577-mic0:~$ ml devel_environment
r21u01n577-mic0:~$ ml impi
r21u01n577-mic0:~$ ml

Currently Loaded Modules:
  1) devel_environment/1.0    (S)   3) ifort/2017.4.196-GCC-6.4.0-2.28      5) impi/2017.3.196-iccifort-2017.4.196-GCC-6.4.0-2.28
  2) icc/2017.4.196-GCC-6.4.0-2.28       4) iccifort/2017.4.196-GCC-6.4.0-2.28

  Where:
   S:  Module is Sticky, requires --force to unload or purge
r21u01n577-mic0:~$ mpirun -n 244 hostname | sort | uniq -c | sort -n
     61 r21u01n577-mic0
     61 r21u01n577-mic1
     61 r21u02n578-mic0
     61 r21u02n578-mic1
r21u01n577-mic0:~$ mpirun -n 976 hostname | sort | uniq -c | sort -n
    244 r21u01n577-mic0
    244 r21u01n577-mic1
    244 r21u02n578-mic0
    244 r21u02n578-mic1
r21u01n577-mic0:~$ mpirun hostname | sort | uniq -c | sort -n
      1 r21u01n577-mic0
      1 r21u01n577-mic1
      1 r21u02n578-mic0
      1 r21u02n578-mic1
```

!!! warning
    Modules `icc`, `ifort`, and `iccifort` are only libraries and headers, not compilers. To compile, use the procedure from the [Native Mode](#native-mode) chapter.

### Octave/3.8.2

Load the `devel_environment` and the `Octave/3.8.2` modules and run the test:

```console
r21u01n577-mic0:~$ ml devel_environment
r21u01n577-mic0:~$ ml Octave/3.8.2
r21u01n577-mic0:~$ octave -q /apps/phi/software/Octave/3.8.2/example/test0.m
warning: docstring file '/apps/phi/software/Octave/3.8.2/share/octave/3.8.2/etc/built-in-docstrings' not found
warning: readline is not linked, so history control is not available
Use some basic operators ...
Work with some small matrixes ...
Save matrix to file ...
Load matrix from file ...
Display matrix ...
m3 =

    39.200    19.600    39.200
    58.800   117.600   156.800
   254.800   411.600   686.000

Work with some big matrixes ...
Sum ...
Multiplication ...
r21u01n577-mic0:~$ cat test.mat
# Created by Octave 3.8.2, Thu Dec 07 11:11:09 2017 CET <kru0052@r21u01n577-mic0>
# name: m3
# type: matrix
# rows: 3
# columns: 3
 39.2 19.6 39.2
 58.8 117.6 156.8
 254.8 411.6 686
```

## Native Build Software With Devel Environment

Compiler

* gcc (GCC) 5.1.1 **without** gfortran support

Architecture (depends on the compiled software):

* k1om-unknown-linux-gnu
* k1om-mpss-linux-gnu
* x86_64-k1om-linux
* k1om-mpss-linux

Configure step (for the `configure`,`make` and `make install` software).

* specify architecture `--build=`

```console
./configure --prefix=/apps/phi/software/ncurses/6.0 --build=k1om-mpss-linux
```

Modulefile and Lmod

* Read [Lmod][5]

[1]: ../intel/intel-xeon-phi-salomon.md#offload-mode
[2]: #native-mode
[3]: ../intel/intel-xeon-phi-salomon.md
[4]: #devel-environment
[5]: ../modules/lmod.md

[a]: https://en.wikipedia.org/wiki/Xeon_Phi
