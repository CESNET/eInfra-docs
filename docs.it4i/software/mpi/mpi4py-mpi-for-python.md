# MPI4Py (MPI for Python)

## Introduction

MPI for Python provides bindings of the Message Passing Interface (MPI) standard for the Python programming language, allowing any Python program to exploit multiple processors.

This package is constructed on top of the MPI-1/2 specifications and provides an object-oriented interface, which closely follows MPI-2 C++ bindings. It supports point-to-point (sends, receives) and collective (broadcasts, scatters, gathers) communications of any picklable Python object, as well as optimized communications of Python object exposing the single-segment buffer interface (NumPy arrays, builtin bytes/string/array objects).

MPI4Py is available in standard Python modules on the clusters.

## Modules

MPI4Py is built for OpenMPI. Before you start with MPI4Py, you need to load the Python and OpenMPI modules.

```console
$ ml av Python/
--------------------------------------- /apps/modules/lang -------------------------
   Python/2.7.8-intel-2015b    Python/2.7.11-intel-2016a  Python/3.5.1-intel-2017.00
   Python/2.7.11-intel-2017a   Python/2.7.9-foss-2015b    Python/2.7.9-intel-2015b
   Python/2.7.11-foss-2016a    Python/3.5.2-foss-2016a    Python/3.5.1
   Python/2.7.9-foss-2015g     Python/3.4.3-intel-2015b   Python/2.7.9
   Python/2.7.11-intel-2015b   Python/3.5.2

$ ml av OpenMPI/
--------------------------------------- /apps/modules/mpi --------------------------
OpenMPI/1.8.6-GCC-4.4.7-system   OpenMPI/1.8.8-GNU-4.9.3-2.25  OpenMPI/1.10.1-GCC-4.9.3-2.25
OpenMPI/1.8.6-GNU-5.1.0-2.25     OpenMPI/1.8.8-GNU-5.1.0-2.25  OpenMPI/1.10.1-GNU-4.9.3-2.25
    OpenMPI/1.8.8-iccifort-2015.3.187-GNU-4.9.3-2.25   OpenMPI/2.0.2-GCC-6.3.0-2.27
```

!!! warning "Flavours"

    * modules Python/x.x.x-intel... - intel MPI
    * modules Python/x.x.x-foss...  - OpenMPI
    * modules Python/x.x.x - without MPI

## Execution

You need to import MPI to your Python program. Include the following line to the Python script:

```python
from mpi4py import MPI
```

The MPI4Py-enabled Python programs [execute as any other OpenMPI][1] code. The simpliest way is to run:

```console
$ mpiexec python <script>.py
```

For example:

```console
$ mpiexec python hello_world.py
```

## Examples

### Hello World!

```python
from mpi4py import MPI

comm = MPI.COMM_WORLD

print "Hello! I'm rank %d from %d running in total..." % (comm.rank, comm.size)

comm.Barrier()   # wait for everybody to synchronize
```

### Collective Communication With NumPy Arrays

```python
from mpi4py import MPI
from __future__ import division
import numpy as np

comm = MPI.COMM_WORLD

print("-"*78)
print(" Running on %d cores" % comm.size)
print("-"*78)

comm.Barrier()

# Prepare a vector of N=5 elements to be broadcasted...
N = 5
if comm.rank == 0:
    A = np.arange(N, dtype=np.float64)    # rank 0 has proper data
else:
    A = np.empty(N, dtype=np.float64)     # all other just an empty array

# Broadcast A from rank 0 to everybody
comm.Bcast( [A, MPI.DOUBLE] )

# Everybody should now have the same...
print "[%02d] %s" % (comm.rank, A)
```

Execute the above code as:

```console
$ qsub -q qexp -l select=4:ncpus=16:mpiprocs=16:ompthreads=1 -I # Salomon: ncpus=24:mpiprocs=24
$ ml Python
$ ml OpenMPI
$ mpiexec -bycore -bind-to-core python hello_world.py
```

In this example, we run MPI4Py-enabled code on 4 nodes, 16 cores per node (total of 64 processes), each Python process is bound to a different core. More examples and documentation can be found on [MPI for Python webpage][a].

### Adding Numbers

Task: count sum of numbers from 1 to 1 000 000. (There is an easy formula to count the sum of arithmetic sequence, but we are showing the MPI solution with adding numbers one by one).

```python
#!/usr/bin/python

import numpy
from mpi4py import MPI
import time

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

a = 1
b = 1000000

perrank = b//size
summ = numpy.zeros(1)

comm.Barrier()
start_time = time.time()

temp = 0
for i in range(a + rank*perrank, a + (rank+1)*perrank):
    temp = temp + i

summ[0] = temp

if rank == 0:
    total = numpy.zeros(1)
else:
    total = None

comm.Barrier()
#collect the partial results and add to the total sum
comm.Reduce(summ, total, op=MPI.SUM, root=0)

stop_time = time.time()

if rank == 0:
    #add the rest numbers to 1 000 000
    for i in range(a + (size)*perrank, b+1):
        total[0] = total[0] + i
    print ("The sum of numbers from 1 to 1 000 000: ", int(total[0]))
    print ("time spent with ", size, " threads in milliseconds")
    print ("-----", int((time.time()-start_time)*1000), "-----")
```

Execute the code above as:

```console
$ qsub -I -q qexp -l select=4:ncpus=16,walltime=00:30:00

$ ml Python/3.5.2-intel-2017.00

$ mpirun -n 2 python myprogram.py
```

You can increase `n` and watch the time lowering.

[1]: running_openmpi.md

[a]: https://pypi.python.org/pypi/mpi4py
