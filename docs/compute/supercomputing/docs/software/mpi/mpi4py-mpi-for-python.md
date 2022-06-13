# MPI4Py (MPI for Python)

## Introduction

MPI for Python provides bindings of the Message Passing Interface (MPI) standard for the Python programming language, allowing any Python program to exploit multiple processors.

This package is constructed on top of the MPI-1/2 specifications and provides an object-oriented interface, which closely follows MPI-2 C++ bindings. It supports point-to-point (sends, receives) and collective (broadcasts, scatters, gathers) communications of any picklable Python object, as well as optimized communications of Python object exposing the single-segment buffer interface (NumPy arrays, builtin bytes/string/array objects).

MPI4Py is available in standard Python modules on the clusters.

## Modules

MPI4Py is built for OpenMPI or Intel MPI. Before you start with MPI4Py, you need to load the mpi4py module.

```console
$ ml av mpi4py
------------------------------------------------------- /apps/modules/mpi -------------------------------------------------------
   mpi4py/3.1.1-gompi-2020b    mpi4py/3.1.1-intel-2020b (D)
```

!!! warning "Flavours"

    * modules mpi4py/x.x.x-intel... - intel MPI
    * modules mpi4py/x.x.x-gompi...  - OpenMPI

## Execution

You need to import MPI to your Python program. Include the following line to the Python script:

```python
from mpi4py import MPI
```

The MPI4Py-enabled Python programs execute as any other OpenMPI code. The simpliest way is to run:

```console
$ mpirun python <script>.py
```

For example:

```console
$ mpirun python hello_world.py
```

## Examples

Execute the above code as:

```console
$ qsub -q qprod -l select=4:ncpus=128:mpiprocs=128:ompthreads=1 -I -A PROJECT_ID
$ ml mpi4py/3.1.1-intel-2020b # or mpi4py/3.1.1-gompi-2020b
```

### Hello World!

```python
#!/usr/bin/env python
"""
Parallel Hello World
"""

from mpi4py import MPI
import sys

size = MPI.COMM_WORLD.Get_size()
rank = MPI.COMM_WORLD.Get_rank()
name = MPI.Get_processor_name()

sys.stdout.write(
    "Hello, World! I am process %d of %d on %s.\n"
    % (rank, size, name))
```

```console
mpirun python ./hello_world.py
...
Hello, World! I am process 81 of 512 on cn041.karolina.it4i.cz.
Hello, World! I am process 91 of 512 on cn041.karolina.it4i.cz.
Hello, World! I am process 15 of 512 on cn041.karolina.it4i.cz.
Hello, World! I am process 105 of 512 on cn041.karolina.it4i.cz.
Hello, World! I am process 112 of 512 on cn041.karolina.it4i.cz.
Hello, World! I am process 11 of 512 on cn041.karolina.it4i.cz.
Hello, World! I am process 83 of 512 on cn041.karolina.it4i.cz.
Hello, World! I am process 58 of 512 on cn041.karolina.it4i.cz.
Hello, World! I am process 103 of 512 on cn041.karolina.it4i.cz.
Hello, World! I am process 4 of 512 on cn041.karolina.it4i.cz.
Hello, World! I am process 28 of 512 on cn041.karolina.it4i.cz.
```

### Mandelbrot

```python
from mpi4py import MPI
import numpy as np

tic = MPI.Wtime()

x1 = -2.0
x2 =  1.0
y1 = -1.0
y2 =  1.0

w = 150
h = 100
maxit = 127

def mandelbrot(x, y, maxit):
    c = x + y*1j
    z = 0 + 0j
    it = 0
    while abs(z) < 2 and it < maxit:
        z = z**2 + c
        it += 1
    return it

comm = MPI.COMM_WORLD
size = comm.Get_size()
rank = comm.Get_rank()

rmsg = np.empty(4, dtype='f')
imsg = np.empty(3, dtype='i')

if rank == 0:
    rmsg[:] = [x1, x2, y1, y2]
    imsg[:] = [w, h, maxit]

comm.Bcast([rmsg, MPI.FLOAT], root=0)
comm.Bcast([imsg, MPI.INT], root=0)

x1, x2, y1, y2 = [float(r) for r in rmsg]
w, h, maxit    = [int(i) for i in imsg]
dx = (x2 - x1) / w
dy = (y2 - y1) / h

# number of lines to compute here
N = h // size + (h % size > rank)
N = np.array(N, dtype='i')
# indices of lines to compute here
I = np.arange(rank, h, size, dtype='i')
# compute local lines
C = np.empty([N, w], dtype='i')
for k in np.arange(N):
    y = y1 + I[k] * dy
    for j in np.arange(w):
        x = x1 + j * dx
        C[k, j] = mandelbrot(x, y, maxit)
# gather results at root
counts = 0
indices = None
cdata = None
if rank == 0:
    counts = np.empty(size, dtype='i')
    indices = np.empty(h, dtype='i')
    cdata = np.empty([h, w], dtype='i')
comm.Gather(sendbuf=[N, MPI.INT],
            recvbuf=[counts, MPI.INT],
            root=0)
comm.Gatherv(sendbuf=[I, MPI.INT],
             recvbuf=[indices, (counts, None), MPI.INT],
             root=0)
comm.Gatherv(sendbuf=[C, MPI.INT],
             recvbuf=[cdata, (counts*w, None), MPI.INT],
             root=0)
# reconstruct full result at root
if rank == 0:
    M = np.zeros([h,w], dtype='i')
    M[indices, :] = cdata

toc = MPI.Wtime()
wct = comm.gather(toc-tic, root=0)
if rank == 0:
    for task, time in enumerate(wct):
        print('wall clock time: %8.2f seconds (task %d)' % (time, task))
    def mean(seq): return sum(seq)/len(seq)
    print    ('all tasks, mean: %8.2f seconds' % mean(wct))
    print    ('all tasks, min:  %8.2f seconds' % min(wct))
    print    ('all tasks, max:  %8.2f seconds' % max(wct))
    print    ('all tasks, sum:  %8.2f seconds' % sum(wct))

# eye candy (requires matplotlib)
if rank == 0:
    try:
        from matplotlib import pyplot as plt
        plt.imshow(M, aspect='equal')
        plt.spectral()
        try:
            import signal
            def action(*args): raise SystemExit
            signal.signal(signal.SIGALRM, action)
            signal.alarm(2)
        except:
            pass
        plt.show()
    except:
        pass
MPI.COMM_WORLD.Barrier()
```

```console
mpirun python mandelbrot.py
...
wall clock time:     0.26 seconds (task 505)
wall clock time:     0.25 seconds (task 506)
wall clock time:     0.24 seconds (task 507)
wall clock time:     0.25 seconds (task 508)
wall clock time:     0.25 seconds (task 509)
wall clock time:     0.26 seconds (task 510)
wall clock time:     0.25 seconds (task 511)
all tasks, mean:     0.19 seconds
all tasks, min:      0.00 seconds
all tasks, max:      0.73 seconds
all tasks, sum:     96.82 seconds
```

In this example, we run MPI4Py-enabled code on 4 nodes, 128 cores per node (total of 512 processes), each Python process is bound to a different core. More examples and documentation can be found on [MPI for Python webpage][a].

You can increase `n` and watch the time lowering.

[a]: https://pypi.python.org/pypi/mpi4py
