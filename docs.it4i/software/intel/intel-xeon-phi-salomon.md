# Intel Xeon Phi

## Guide to Intel Xeon Phi Usage

The Intel Xeon Phi accelerator can be programmed in several modes. The default mode on the cluster is offload mode, but all modes described in this document are supported.

## Intel Utilities for Xeon Phi

To get access to a compute node with the Intel Xeon Phi accelerator, use the PBS interactive session:

```console
$ qsub -I -q qprod -l select=1:ncpus=24:accelerator=True:naccelerators=2:accelerator_model=phi7120 -A NONE-0-0
```

To set up the environment load the `intel` module. Without specifying the version, the default version is loaded (at time of writing this, it is 2015b):

```console
$ ml intel
```

Information about the hardware can be obtained by running the micinfo program on the host.

```console
$ /usr/bin/micinfo
```

The output of the "micinfo" utility executed on one of the cluster node is as follows (note: to get PCIe related details, the command has to be run with root privileges):

```console
MicInfo Utility Log
Created Wed Sep 13 13:39:28 2017


        System Info
                HOST OS                 : Linux
                OS Version              : 2.6.32-696.3.2.el6.x86_64
                Driver Version          : 3.8.2-1
                MPSS Version            : 3.8.2
                Host Physical Memory    : 128838 MB

Device No: 0, Device Name: mic0

        Version
                Flash Version            : 2.1.02.0391
                SMC Firmware Version     : 1.17.6900
                SMC Boot Loader Version  : 1.8.4326
                Coprocessor OS Version   : 2.6.38.8+mpss3.8.2
                Device Serial Number     : ADKC44601725

        Board
                Vendor ID                : 0x8086
                Device ID                : 0x225c
                Subsystem ID             : 0x7d95
                Coprocessor Stepping ID  : 2
                PCIe Width               : x16
                PCIe Speed               : 5 GT/s
                PCIe Max payload size    : 256 bytes
                PCIe Max read req size   : 512 bytes
                Coprocessor Model        : 0x01
                Coprocessor Model Ext    : 0x00
                Coprocessor Type         : 0x00
                Coprocessor Family       : 0x0b
                Coprocessor Family Ext   : 0x00
                Coprocessor Stepping     : C0
                Board SKU                : C0PRQ-7120 P/A/X/D
                ECC Mode                 : Enabled
                SMC HW Revision          : Product 300W Passive CS

        Cores
                Total No of Active Cores : 61
                Voltage                  : 1041000 uV
                Frequency                : 1238095 kHz

        Thermal
                Fan Speed Control        : N/A
                Fan RPM                  : N/A
                Fan PWM                  : N/A
                Die Temp                 : 50 C

        GDDR
                GDDR Vendor              : Samsung
                GDDR Version             : 0x6
                GDDR Density             : 4096 Mb
                GDDR Size                : 15872 MB
                GDDR Technology          : GDDR5
                GDDR Speed               : 5.500000 GT/s
                GDDR Frequency           : 2750000 kHz
                GDDR Voltage             : 1501000 uV

Device No: 1, Device Name: mic1

        Version
                Flash Version            : 2.1.02.0391
                SMC Firmware Version     : 1.17.6900
                SMC Boot Loader Version  : 1.8.4326
                Coprocessor OS Version   : 2.6.38.8+mpss3.8.2
                Device Serial Number     : ADKC44601893

        Board
                Vendor ID                : 0x8086
                Device ID                : 0x225c
                Subsystem ID             : 0x7d95
                Coprocessor Stepping ID  : 2
                PCIe Width               : x16
                PCIe Speed               : 5 GT/s
                PCIe Max payload size    : 256 bytes
                PCIe Max read req size   : 512 bytes
                Coprocessor Model        : 0x01
                Coprocessor Model Ext    : 0x00
                Coprocessor Type         : 0x00
                Coprocessor Family       : 0x0b
                Coprocessor Family Ext   : 0x00
                Coprocessor Stepping     : C0
                Board SKU                : C0PRQ-7120 P/A/X/D
                ECC Mode                 : Enabled
                SMC HW Revision          : Product 300W Passive CS

        Cores
                Total No of Active Cores : 61
                Voltage                  : 1053000 uV
                Frequency                : 1238095 kHz

        Thermal
                Fan Speed Control        : N/A
                Fan RPM                  : N/A
                Fan PWM                  : N/A
                Die Temp                 : 48 C

        GDDR
                GDDR Vendor              : Samsung
                GDDR Version             : 0x6
                GDDR Density             : 4096 Mb
                GDDR Size                : 15872 MB
                GDDR Technology          : GDDR5
                GDDR Speed               : 5.500000 GT/s
                GDDR Frequency           : 2750000 kHz
                GDDR Voltage             : 1501000 uV
```

## Offload Mode

To compile code for Intel Xeon Phi, an MPSS stack has to be installed on the machine where the compilation is executed. Currently, the MPSS stack is only installed on compute nodes equipped with accelerators.

```console
$ qsub -I -q qprod -l select=1:ncpus=24:accelerator=True:naccelerators=2:accelerator_model=phi7120 -A NONE-0-0
$ ml intel
```

For debugging purposes, it is also recommended to set the `OFFLOAD_REPORT` environment variable. The value can be set from 0 to 3, where a higher number means more debugging information.

```console
export OFFLOAD_REPORT=3
```

A very basic example of code that employs offload programming technique is shown in the next listing. Note that this code is sequential and utilizes only a single core of the accelerator.

```cpp
$ cat source-offload.cpp

#include <iostream>

int main(int argc, char* argv[])
{
    const int niter = 100000;
    double result = 0;

 #pragma offload target(mic)
    for (int i = 0; i < niter; ++i) {
        const double t = (i + 0.5) / niter;
        result += 4.0 / (t * t + 1.0);
    }
    result /= niter;
    std::cout << "Pi ~ " << result << '\n';
}
```

To compile the code using the Intel compiler, run:

```console
$ icc source-offload.cpp -o bin-offload
```

To execute the code, run the following command on the host:

```console
$ ./bin-offload
```

### Parallelization in Offload Mode Using OpenMP

One way of code paralelization for Xeon Phi is using OpenMP directives. The following example shows code for a parallel vector addition:

```cpp
$ cat ./vect-add

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

During the compilation, the Intel compiler shows which loops have been vectorized in both the host and the accelerator. This can be enabled with the `-vec-report2` compiler option. To compile and execute the code, run:

```console
$ icc vect-add.c -openmp_report2 -vec-report2 -o vect-add
$ ./vect-add
```

Some interesting compiler flags useful not only for code debugging are:

!!! note
    Debugging
    `openmp_report[0|1|2]` - controls the compiler based vectorization diagnostic level
    `vec-report[0|1|2]` - controls the OpenMP parallelizer diagnostic level

    Performance optimization
    `xhost` - FOR HOST ONLY - to generate AVX (Advanced Vector Extensions) instructions.

## Automatic Offload Using Intel MKL Library

Intel MKL includes an Automatic Offload (AO) feature that enables computationally intensive MKL functions called in user code to benefit from attached Intel Xeon Phi coprocessors automatically and transparently.

!!! note
    Behavior of the automatic offload mode is controlled by functions called within the program or by environmental variables. The complete list of controls is listed [here][a].

The Automatic Offload may be enabled by either an MKL function call within the code:

```cpp
mkl_mic_enable();
```

or by setting the environment variable:

```console
$ export MKL_MIC_ENABLE=1
```

To get more information about the automatic offload, refer to the "[Using Intel® MKL Automatic Offload on Intel ® Xeon Phi™ Coprocessors][b]" white paper or the [Intel MKL documentation][c].

### Automatic Offload Example

At first, get an interactive PBS session on a node with the MIC accelerator and load the `intel` module that automatically loads the `mkl` module, as well:

```console
$ qsub -I -q qprod -l select=1:ncpus=24:accelerator=True:naccelerators=2:accelerator_model=phi7120 -A NONE-0-0
$ ml intel
```

The code can be copied to a file and compiled without any necessary modification:

```cpp
$ vim sgemm-ao-short.c

#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <stdint.h>

#include "mkl.h"

int main(int argc, char **argv)
{
    float *A, *B, *C; /* Matrices */

    MKL_INT N = 2560; /* Matrix dimensions */
    MKL_INT LD = N; /* Leading dimension */
    int matrix_bytes; /* Matrix size in bytes */
    int matrix_elements; /* Matrix size in elements */

    float alpha = 1.0, beta = 1.0; /* Scaling factors */
    char transa = 'N', transb = 'N'; /* Transposition options */

    int i, j; /* Counters */

    matrix_elements = N * N;
    matrix_bytes = sizeof(float) * matrix_elements;

    /* Allocate the matrices */
    A = malloc(matrix_bytes); B = malloc(matrix_bytes); C = malloc(matrix_bytes);

    /* Initialize the matrices */
    for (i = 0; i < matrix_elements; i++) {
            A[i] = 1.0; B[i] = 2.0; C[i] = 0.0;
    }

    printf("Computing SGEMM on the host\n");
    sgemm(&transa, &transb, &N, &N, &N, &alpha, A, &N, B, &N, &beta, C, &N);

    printf("Enabling Automatic Offload\n");
    /* Alternatively, set environment variable MKL_MIC_ENABLE=1 */
    mkl_mic_enable();

    int ndevices = mkl_mic_get_device_count(); /* Number of MIC devices */
    printf("Automatic Offload enabled: %d MIC devices present\n",   ndevices);

    printf("Computing SGEMM with automatic workdivision\n");
    sgemm(&transa, &transb, &N, &N, &N, &alpha, A, &N, B, &N, &beta, C, &N);

    /* Free the matrix memory */
    free(A); free(B); free(C);

    printf("Done\n");

    return 0;
}
```

!!! note
    This example is a simplified version of an example from MKL. The expanded version can be found here: `$MKL_EXAMPLES/mic_ao/blasc/source/sgemm.c`.

To compile the code using the Intel compiler, use:

```console
$ icc -mkl sgemm-ao-short.c -o sgemm
```

For debugging purposes, enable the offload report to see more information about automatic offloading:

```console
$ export OFFLOAD_REPORT=2
```

The output of the code should look similar to the following listing, where the lines starting with [MKL] are generated by offload reporting:

```console
[user@r31u03n799 ~]$ ./sgemm
Computing SGEMM on the host
Enabling Automatic Offload
Automatic Offload enabled: 2 MIC devices present
Computing SGEMM with automatic workdivision
[MKL] [MIC --] [AO Function]    SGEMM
[MKL] [MIC --] [AO SGEMM Workdivision]    0.44 0.28 0.28
[MKL] [MIC 00] [AO SGEMM CPU Time]    0.252427 seconds
[MKL] [MIC 00] [AO SGEMM MIC Time]    0.091001 seconds
[MKL] [MIC 00] [AO SGEMM CPU->MIC Data]    34078720 bytes
[MKL] [MIC 00] [AO SGEMM MIC->CPU Data]    7864320 bytes
[MKL] [MIC 01] [AO SGEMM CPU Time]    0.252427 seconds
[MKL] [MIC 01] [AO SGEMM MIC Time]    0.094758 seconds
[MKL] [MIC 01] [AO SGEMM CPU->MIC Data]    34078720 bytes
[MKL] [MIC 01] [AO SGEMM MIC->CPU Data]    7864320 bytes
Done
```

!!! note
    Behavior of the automatic offload mode is controlled by functions called within the program or by environmental variables. The complete list of controls is listed [here][d].

### Automatic Offload Example #2

In this example, we will demonstrate the automatic offload control via the `MKL_MIC_ENABLE` environment variable. The DGEMM function will be offloaded.

At first, get an interactive PBS session on the node with the MIC accelerator.

```console
$ qsub -I -q qprod -l select=1:ncpus=24:accelerator=True:naccelerators=2:accelerator_model=phi7120 -A NONE-0-0
```

Once in, we enable the offload and run the Octave software. In Octave, we generate two large random matrices and let them multiply together:

```console
$ export MKL_MIC_ENABLE=1
$ export OFFLOAD_REPORT=2
$ ml Octave/3.8.2-intel-2015b
$ octave -q
octave:1> A=rand(10000);
octave:2> B=rand(10000);
octave:3> C=A*B;
[MKL] [MIC --] [AO Function]    DGEMM
[MKL] [MIC --] [AO DGEMM Workdivision]    0.14 0.43 0.43
[MKL] [MIC 00] [AO DGEMM CPU Time]    3.814714 seconds
[MKL] [MIC 00] [AO DGEMM MIC Time]    2.781595 seconds
[MKL] [MIC 00] [AO DGEMM CPU->MIC Data]    1145600000 bytes
[MKL] [MIC 00] [AO DGEMM MIC->CPU Data]    1382400000 bytes
[MKL] [MIC 01] [AO DGEMM CPU Time]    3.814714 seconds
[MKL] [MIC 01] [AO DGEMM MIC Time]    2.843016 seconds
[MKL] [MIC 01] [AO DGEMM CPU->MIC Data]    1145600000 bytes
[MKL] [MIC 01] [AO DGEMM MIC->CPU Data]    1382400000 bytes
octave:4> exit
```

In the example above, we observe that the DGEMM function workload was split over CPU, MIC 0 and MIC 1, in the ratio 0.14 0.43 0.43. The matrix multiplication was done on the CPU, accelerated by two Xeon Phi accelerators.

## Native Mode

In the native mode, a program is executed directly on Intel Xeon Phi without involvement of the host machine. Similarly to offload mode, the code is compiled on the host computer with the Intel compilers.

To compile the code, the user has to be connected to a compute node with MIC and load the Intel compilers module. To get an interactive session on a compute node with Intel Xeon Phi and load the module, use the following commands:

```console
$ qsub -I -q qprod -l select=1:ncpus=24:accelerator=True:naccelerators=2:accelerator_model=phi7120 -A NONE-0-0
$ ml intel
```

!!! note
    A particular version of the `intel` module is specified. This information is used later to specify the correct library paths.

To produce a binary compatible with the Intel Xeon Phi architecture, the user has to specify the `-mmic` compiler flag. Two compilation examples are shown below. The first example shows how to compile the OpenMP parallel code `vect-add.c` for the host only:

```console
$ icc -xhost -no-offload -fopenmp vect-add.c -o vect-add-host
```

To run this code on host, use:

```console
$ ./vect-add-host
```

The second example shows how to compile the same code for Intel Xeon Phi:

```console
$ icc -mmic -fopenmp vect-add.c -o vect-add-mic
```

### Execution of the Program in Native Mode on Intel Xeon Phi

User access to Intel Xeon Phi is via SSH. Since user home directories are mounted using NFS on the accelerator, users do not have to copy binary files or libraries between the host and the accelerator.

Get the PATH of MIC enabled libraries for currently used Intel Compiler (here `icc/2015.3.187-GNU-5.1.0-2.25` was used):

```console
$ echo $MIC_LD_LIBRARY_PATH
/apps/all/icc/2015.3.187-GNU-5.1.0-2.25/composer_xe_2015.3.187/compiler/lib/mic
```

To connect to the accelerator, run:

```console
$ ssh mic0
```

If the code is sequential, it can be executed directly:

```console
mic0 $ ~/path_to_binary/vect-add-seq-mic
```

If the code is parallelized using OpenMP, a set of additional libraries is required for execution. To locate these libraries, a new path has to be added to the `LD_LIBRARY_PATH` environment variable prior to the execution:

```console
mic0 $ export LD_LIBRARY_PATH=/apps/all/icc/2015.3.187-GNU-5.1.0-2.25/composer_xe_2015.3.187/compiler/lib/mic:$LD_LIBRARY_PATH
```

!!! note
    The path exported in the previous example contains the path to a specific compiler (here the version is `2015.3.187-GNU-5.1.0-2.25`). This version number has to match with the version number of the Intel compiler module that was used to compile the code on the host computer.

The list of libraries and their location required for execution of an OpenMP parallel code on Intel Xeon Phi is:

!!! note
    /apps/all/icc/2015.3.187-GNU-5.1.0-2.25/composer_xe_2015.3.187/compiler/lib/mic

    - libiomp5.so
    - libimf.so
    - libsvml.so
    - libirng.so
    - libintlc.so.5

Finally, to run the compiled code, use:

```console
$ ~/path_to_binary/vect-add-mic
```

## OpenCL

OpenCL (Open Computing Language) is an open standard for general-purpose parallel programming for diverse mix of multi-core CPUs, GPU coprocessors, and other parallel processors. OpenCL provides a flexible execution model and uniform programming environment for software developers to write portable code for systems running on both the CPU and graphics processors or accelerators like the Intel® Xeon Phi.

On Salomon, OpenCL is installed only on compute nodes with the MIC accelerator, so OpenCL code can be compiled only on these nodes.

```console
ml opencl-sdk opencl-rt
```

Always load `opencl-sdk` (providing devel files like headers) and `opencl-rt` (providing a dynamic library libOpenCL.so) modules to compile and link OpenCL code. Load `opencl-rt` for running your compiled code.

There are two basic examples of OpenCL code in the following directory:

```console
/apps/intel/opencl-examples/
```

The first example "CapsBasic" detects OpenCL compatible hardware, here CPU and MIC, and prints basic information about its capabilities.

```console
/apps/intel/opencl-examples/CapsBasic/capsbasic
```

To compile and run the example, copy it to your home directory, get a PBS interactive session on one of the nodes with MIC, and run make for compilation. Make files are very basic and show how the OpenCL code can be compiled on Salomon.

The compilation command for this example is:

```console
$ g++ capsbasic.cpp -lOpenCL -o capsbasic -I/apps/intel/opencl/include/
```

After executing the compiled binary file, the following output should be displayed:

```console
./capsbasic

Number of available platforms: 1
Platform names:
    [0] Intel(R) OpenCL [Selected]
Number of devices available for each type:
    CL_DEVICE_TYPE_CPU: 1
    CL_DEVICE_TYPE_GPU: 0
    CL_DEVICE_TYPE_ACCELERATOR: 1

** Detailed information for each device ***

CL_DEVICE_TYPE_CPU[0]
    CL_DEVICE_NAME:        Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
    CL_DEVICE_AVAILABLE: 1

...

CL_DEVICE_TYPE_ACCELERATOR[0]
    CL_DEVICE_NAME: Intel(R) Many Integrated Core Acceleration Card
    CL_DEVICE_AVAILABLE: 1

...
```

!!! note
    More information about this example can be found on the Intel website: <http://software.intel.com/en-us/vcsource/samples/caps-basic/>

To see the performance of Intel Xeon Phi performing the DGEMM, run the example as follows:

```console
./gemm -d 1
Platforms (1):
 [0] Intel(R) OpenCL [Selected]
Devices (2):
 [0] Intel(R) Xeon(R) CPU E5-2470 0 @ 2.30GHz
 [1] Intel(R) Many Integrated Core Acceleration Card [Selected]
Build program options: "-DT=float -DTILE_SIZE_M=1 -DTILE_GROUP_M=16 -DTILE_SIZE_N=128 -DTILE_GROUP_N=1 -DTILE_SIZE_K=8"
Running gemm_nn kernel with matrix size: 3968x3968
Memory row stride to ensure necessary alignment: 15872 bytes
Size of memory region for one matrix: 62980096 bytes
Using alpha = 0.57599 and beta = 0.872412
...
Host time: 0.292953 sec.
Host perf: 426.635 GFLOP/s
Host time: 0.293334 sec.
Host perf: 426.081 GFLOP/s
...
```

!!! hint
    GNU compiler is used to compile the OpenCL codes for Intel MIC. You do not need to load the Intel compiler module.

## MPI

### Environment Setup and Compilation

To achieve the best MPI performance, always use the following setup for Intel MPI on Xeon Phi accelerated nodes:

```console
$ export I_MPI_FABRICS=shm:dapl
$ export I_MPI_DAPL_PROVIDER_LIST=ofa-v2-mlx4_0-1u,ofa-v2-scif0,ofa-v2-mcm-1
```

This ensures that MPI inside the node will use the SHMEM communication; between HOST and Phi, the IB SCIF will be used and between different nodes or Phi's on different nodes, a CCL-Direct proxy will be used.

!!! note
    Other FABRICS like tcp or ofa may be used (even combined with shm) but there is a severe loss of performance (by order of magnitude).
    Usage of a single DAPL PROVIDER (e.g. `I_MPI_DAPL_PROVIDER=ofa-v2-mlx4_0-1u`) will cause a failure of Host<->Phi and/or Phi<->Phi communication.
    Usage of the `I_MPI_DAPL_PROVIDER_LIST` on a non-accelerated node will cause a failure of any MPI communication, since those nodes do not have aSCIF device and there's no CCL-Direct proxy runnig.

Again, an MPI code for Intel Xeon Phi has to be compiled on a compute node with the accelerator and MPSS software stack installed. To get to a compute node with the accelerator, use:

```console
$ qsub -I -q qprod -l select=1:ncpus=24:accelerator=True:naccelerators=2:accelerator_model=phi7120 -A NONE-0-0
```

The only supported implementation of the MPI standard for Intel Xeon Phi is Intel MPI. To setup a fully functional development environment a combination of Intel compiler and Intel MPI has to be used. Before compilation, load the following modules on the host:

```console
$ ml intel
```

To compile an MPI code for the host, use:

```console
$ mpiicc -xhost -o mpi-test mpi-test.c
```

To compile the same code for Intel Xeon Phi architecture, use:

```console
$ mpiicc -mmic -o mpi-test-mic mpi-test.c
```

If you are using Fortran:

```console
$ mpiifort -mmic -o mpi-test-mic mpi-test.f90
```

A basic MPI version of the "hello-world" example in C language, which can be executed on both the host and Xeon Phi, is (can be directly copied and pasted to a .c file):

```cpp
#include <stdio.h>
#include <mpi.h>

int main (argc, argv)
     int argc;
     char *argv[];
{
  int rank, size;

  int len;
  char node[MPI_MAX_PROCESSOR_NAME];

  MPI_Init (&argc, &argv);      /* starts MPI */
  MPI_Comm_rank (MPI_COMM_WORLD, &rank);        /* get current process id */
  MPI_Comm_size (MPI_COMM_WORLD, &size);        /* get number of processes */

  MPI_Get_processor_name(node,&len);

  printf( "Hello world from process %d of %d on host %s n", rank, size, node );
  MPI_Finalize();
  return 0;
}
```

### MPI Programming Models

Intel MPI for Xeon Phi coprocessors offers different MPI programming models:

!!! note
    **Host-only model** - all MPI ranks reside on the host. The coprocessors can be used by using offload pragmas. (Using MPI calls inside offloaded code is not supported.)

    **Coprocessor-only model** - all MPI ranks reside only on the coprocessors.

    **Symmetric model** - the MPI ranks reside on both the host and the coprocessor. Most general MPI case.

### Host-Only Model

In this case, all environment variables are set by modules, so to execute the compiled MPI program on a single node, use:

```console
$ mpirun -np 4 ./mpi-test
```

The output should be similar to:

```console
Hello world from process 1 of 4 on host r38u31n1000
Hello world from process 3 of 4 on host r38u31n1000
Hello world from process 2 of 4 on host r38u31n1000
Hello world from process 0 of 4 on host r38u31n1000
```

### Coprocessor-Only Model

There are two ways how to execute an MPI code on a single coprocessor: 1) launch the program using `mpirun` from the
coprocessor; or 2) launch the task using `mpiexec.hydra` from a host.

#### Execution on Coprocessor

Similarly to execution of OpenMP programs in native mode, since the environmental module is not supported on MIC, the user has to setup paths to Intel MPI libraries and binaries manually. One-time setup can be done by creating a "**.profile**" file in the user's home directory. This file sets up the environment on the MIC automatically once the user accesses the accelerator via SSH.

At first, get the `LD_LIBRARY_PATH` for currently used Intel Compiler and Intel MPI:

```console
$ echo $MIC_LD_LIBRARY_PATH
/apps/all/imkl/11.2.3.187-iimpi-7.3.5-GNU-5.1.0-2.25/mkl/lib/mic:/apps/all/imkl/11.2.3.187-iimpi-7.3.5-GNU-5.1.0-2.25/lib/mic:/apps/all/icc/2015.3.187-GNU-5.1.0-2.25/composer_xe_2015.3.187/compiler/lib/mic/
```

Use it in your ~/.profile:

```console
$ cat ~/.profile

PS1='[\u@\h \W]\$ '
export PATH=/usr/bin:/usr/sbin:/bin:/sbin

#IMPI
export PATH=/apps/all/impi/5.0.3.048-iccifort-2015.3.187-GNU-5.1.0-2.25/mic/bin/:$PATH

#OpenMP (ICC, IFORT), IMKL and IMPI
export LD_LIBRARY_PATH=/apps/all/imkl/11.2.3.187-iimpi-7.3.5-GNU-5.1.0-2.25/mkl/lib/mic:/apps/all/imkl/11.2.3.187-iimpi-7.3.5-GNU-5.1.0-2.25/lib/mic:/apps/all/icc/2015.3.187-GNU-5.1.0-2.25/composer_xe_2015.3.187/compiler/lib/mic:$LD_LIBRARY_PATH

```

!!! note
    \* this file sets up the environmental variable for both MPI and OpenMP libraries.
    \* this file sets up the paths to a particular version of the Intel MPI library and the particular version of the Intel compiler. These versions have to match with loaded modules.

To access the MIC accelerator located on a node that the user is currently connected to, use:

```console
$ ssh mic0
```

or in case you need to specify an MIC accelerator on a particular node, use:

```console
$ ssh r38u31n1000-mic0
```

To run the MPI code in parallel on multiple core of the accelerator, use:

```console
$ mpirun -np 4 ./mpi-test-mic
```

The output should be similar to:

```console
Hello world from process 1 of 4 on host r38u31n1000-mic0
Hello world from process 2 of 4 on host r38u31n1000-mic0
Hello world from process 3 of 4 on host r38u31n1000-mic0
Hello world from process 0 of 4 on host r38u31n1000-mic0
```

#### Execution on Host

If the MPI program is launched from the host instead of the coprocessor, the environmental variables are not set using the ".profile" file. Therefore, the user has to specify library paths from the command line when calling "mpiexec".

First step is to tell mpiexec that the MPI should be executed on the local accelerator by setting up the environmental variable `I_MPI_MIC`:

```console
$ export I_MPI_MIC=1
```

Now the MPI program can be executed as:

```console
$ mpirun -genv LD_LIBRARY_PATH $MIC_LD_LIBRARY_PATH -host mic0 -n 4 ~/mpi-test-mic
```

or using `mpirun`:

```console
$ mpirun -genv LD_LIBRARY_PATH $MIC_LD_LIBRARY_PATH -host mic0 -n 4 ~/mpi-test-mic
```

!!! note
    \* the full path to the binary has to be specified (here: "**>~/mpi-test-mic**")
    \* the `LD_LIBRARY_PATH` has to match with the Intel MPI module used to compile the MPI code

The output should be again similar to:

```console
Hello world from process 1 of 4 on host r38u31n1000-mic0
Hello world from process 2 of 4 on host r38u31n1000-mic0
Hello world from process 3 of 4 on host r38u31n1000-mic0
Hello world from process 0 of 4 on host r38u31n1000-mic0
```

!!! hint
    `mpiexec.hydra` requires a file on the MIC filesystem. If the file is missing, contact the system administrators.

A simple test to see if the file is present is to execute:

```console
$ ssh mic0 ls /bin/pmi_proxy
  /bin/pmi_proxy
```

#### Execution on Host - MPI Processes Distributed Over Multiple Accelerators on Multiple Nodes

To get access to multiple nodes with the MIC accelerator, the user has to use PBS to allocate the resources. To start an interactive session that allocates 2 compute nodes = 2 MIC accelerators, run qsub command with the following parameters:

```console
$ qsub -I -q qprod -l select=2:ncpus=24:accelerator=True:naccelerators=2:accelerator_model=phi7120 -A NONE-0-0
$ ml intel impi
```

This command connects the user via SSH to one of the nodes immediately. To see the other nodes that have been allocated, use:

```console
$ cat $PBS_NODEFILE
```

For example:

```console
r25u25n710.ib0.smc.salomon.it4i.cz
r25u26n711.ib0.smc.salomon.it4i.cz
```

This output means that the PBS allocated nodes cn204 and cn205, which means that the user has direct access to the "**r25u25n710-mic0**" and "**r25u26n711-mic0**" accelerators.

!!! note
    At this point, the user can connect to any of the allocated nodes or any of the allocated MIC accelerators using SSH:
    - to connect to the second node: `$ ssh r25u26n711`
    - to connect to the accelerator on the first node from the first node:  `$ ssh r25u25n710-mic0` or `$ ssh mic0`
    - to connect to the accelerator on the second node from the first node: `$ ssh r25u25n711-mic0`

At this point, we expect that the correct modules are loaded and the binary is compiled. For parallel execution, `mpiexec.hydra` is used. Again the first step is to tell mpiexec that the MPI can be executed on MIC accelerators by setting up the environmental variable `I_MPI_MIC`; do not forget to have correct FABRIC and PROVIDER defined.

```console
$ export I_MPI_MIC=1
$ export I_MPI_FABRICS=shm:dapl
$ export I_MPI_DAPL_PROVIDER_LIST=ofa-v2-mlx4_0-1u,ofa-v2-scif0,ofa-v2-mcm-1
```

To launch the MPI program ,use:

```console
$ mpirun -genv LD_LIBRARY_PATH $MIC_LD_LIBRARY_PATH \
 -host r25u25n710-mic0 -n 4 ~/mpi-test-mic \
: -host r25u26n711-mic0 -n 6 ~/mpi-test-mic
```

or using `mpirun`:

```console
$ mpirun -genv LD_LIBRARY_PATH \
 -host r25u25n710-mic0 -n 4 ~/mpi-test-mic \
: -host r25u26n711-mic0 -n 6 ~/mpi-test-mic
```

In this case, four MPI processes are executed on the cn204-mic accelerator and six processes are executed on the cn205-mic0 accelerator. The sample output (sorted after execution) is:

```console
Hello world from process 0 of 10 on host r25u25n710-mic0
Hello world from process 1 of 10 on host r25u25n710-mic0
Hello world from process 2 of 10 on host r25u25n710-mic0
Hello world from process 3 of 10 on host r25u25n710-mic0
Hello world from process 4 of 10 on host r25u26n711-mic0
Hello world from process 5 of 10 on host r25u26n711-mic0
Hello world from process 6 of 10 on host r25u26n711-mic0
Hello world from process 7 of 10 on host r25u26n711-mic0
Hello world from process 8 of 10 on host r25u26n711-mic0
Hello world from process 9 of 10 on host r25u26n711-mic0
```

The same way, MPI program can be executed on multiple hosts:

```console
$ mpirun -genv LD_LIBRARY_PATH $MIC_LD_LIBRARY_PATH \
 -host r25u25n710 -n 4 ~/mpi-test \
: -host r25u26n711 -n 6 ~/mpi-test
```

### Symmetric Model

In a symmetric mode, MPI programs are executed on both the host computer(s) and the MIC accelerator(s). Since MIC has a different
architecture and requires different binary file produced by the Intel compiler, two different files have to be compiled before the MPI program is executed.

In the previous section, we have compiled two binary files, one for hosts "**mpi-test**" and one for MIC accelerators "**mpi-test-mic**". These two binaries can be executed at once using `mpiexec.hydra`:

```console
$ mpirun \
 -genv $MIC_LD_LIBRARY_PATH \
 -host r38u32n1001 -n 2 ~/mpi-test \
: -host r38u32n1001-mic0 -n 2 ~/mpi-test-mic
```

In this example, the first two parameters (line 2 and 3) set up required environment variables for execution. The third line specifies the binary that is executed on the host (here r38u32n1001) and the last line specifies the binary that is executed on the accelerator (here r38u32n1001-mic0).

The output of the program is:

```console
Hello world from process 0 of 4 on host r38u32n1001
Hello world from process 1 of 4 on host r38u32n1001
Hello world from process 2 of 4 on host r38u32n1001-mic0
Hello world from process 3 of 4 on host r38u32n1001-mic0
```

The execution procedure can be simplified by using the `mpirun` command with the machine file as a parameter. The machine file contains a list of all nodes and accelerators that should be used to execute MPI processes.

An example of a machine file that uses 2 >hosts (**r38u32n1001** and **r38u32n1002**) and 2 accelerators **(r38u32n1001-mic0** and **r38u32n1002-mic0**) to run 2 MPI processes on each of them:

```console
$ cat hosts_file_mix
r38u32n1001:2
r38u32n1001-mic0:2
r38u33n1002:2
r38u33n1002-mic0:2
```

In addition, if a naming convention is set in a way that the name of the binary for the host is **"bin_name"** and the name of the binary for the accelerator is **"bin_name-mic"** then by setting up the environment variable `I_MPI_MIC_POSTFIX` to `-mic`, the user does not have to specify the names of both binaries. In this case, `mpirun` needs just the name of the host binary file (i.e. "mpi-test") and uses the suffix to get the name of the binary for accelerator (i.e. "mpi-test-mic").

```console
$ export I_MPI_MIC_POSTFIX=-mic
```

To run the MPI code using `mpirun` and the machine file "hosts_file_mix", use:

```console
$ mpirun \
 -genv LD_LIBRARY_PATH $MIC_LD_LIBRARY_PATH \
 -machinefile hosts_file_mix \
 ~/mpi-test
```

A possible output of the MPI "hello-world" example executed on two hosts and two accelerators is:

```console
Hello world from process 0 of 8 on host r38u31n1000
Hello world from process 1 of 8 on host r38u31n1000
Hello world from process 2 of 8 on host r38u31n1000-mic0
Hello world from process 3 of 8 on host r38u31n1000-mic0
Hello world from process 4 of 8 on host r38u32n1001
Hello world from process 5 of 8 on host r38u32n1001
Hello world from process 6 of 8 on host r38u32n1001-mic0
Hello world from process 7 of 8 on host r38u32n1001-mic0
```

!!! note
    At this point, the MPI communication between MIC accelerators on different nodes uses 1Gb Ethernet only.

### Using Automatically Generated Node-Files

A set of node-files, which can be used instead of manually creating a new one every time, is generated for the user's convenience. Six node-files are generated:

!!! note
    **Node-files:**

     - /lscratch/${PBS_JOBID}/nodefile-cn Hosts only node-file
     - /lscratch/${PBS_JOBID}/nodefile-mic MICs only node-file
     - /lscratch/${PBS_JOBID}/nodefile-mix Hosts and MICs node-file
     - /lscratch/${PBS_JOBID}/nodefile-cn-sn Hosts only node-file, using short names
     - /lscratch/${PBS_JOBID}/nodefile-mic-sn MICs only node-file, using short names
     - /lscratch/${PBS_JOBID}/nodefile-mix-sn Hosts and MICs node-file, using short names

Each host or accelerator is listed only once per file. The user has to specify how many jobs should be executed per node using the `-n` parameter of the `mpirun` command.

## Optimization

For more details about optimization techniques read the Intel document [Optimization and Performance Tuning for Intel® Xeon Phi™ Coprocessors][e].

[a]: http://software.intel.com/sites/products/documentation/doclib/mkl_sa/11/mkl_userguide_lnx/GUID-3DC4FC7D-A1E4-423D-9C0C-06AB265FFA86.htm
[b]: http://software.intel.com/sites/default/files/11MIC42_How_to_Use_MKL_Automatic_Offload_0.pdf
[c]: https://software.intel.com/en-us/articles/intel-math-kernel-library-documentation
[d]: http://software.intel.com/sites/products/documentation/doclib/mkl_sa/11/mkl_userguide_lnx/GUID-3DC4FC7D-A1E4-423D-9C0C-06AB265FFA86.htm
[e]: http://software.intel.com/en-us/articles/optimization-and-performance-tuning-for-intel-xeon-phi-coprocessors-part-1-optimization
