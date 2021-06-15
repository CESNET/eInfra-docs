# Dask

[Dask](https://docs.dask.org/en/latest/) is a popular open-source library that allows you to
parallelize your Python code using a distributed cluster easily. It can parallelize arbitrary
Python code in the form of a task DAG (Directed Acyclic Graph), but it also offers parallelized
versions of popular Python data science libraries like
[numpy](https://docs.dask.org/en/latest/array.html) or
[Pandas](https://docs.dask.org/en/latest/dataframe.html).

## Installation

To install Dask, load a recent version of Python 3 and install Dask using `pip`. We heavily
recommend you to install Python packages inside a Python virtual environment.

```bash
# Load Python (preferably use a specific Python version)
$ ml Python3

# Create a virtual environment
$ python3 -m venv dask

# Activate and update the virtual environment
$ source dask/bin/activate
(dask) $ pip install -U setuptools pip wheel

# Install Dask
(dask) $ pip install distributed
```

## Starting a Dask Cluster

Before you can use Dask, you need to set up a Dask cluster, which consists of a single server
component which coordinates the cluster, and an arbitrary number of workers, which actually
execute your tasks.

![Dask cluster architecture](imgs/dask-arch.svg)

After you start a PBS job, you should therefore first start the server and the workers on the
available computing nodes and then run your Python program that uses Dask. There are multiple ways
of deploying the cluster. A common scenario is to run a Dask server on a single computing node,
run a single worker per node on all remaining computing nodes and then run your program on the node
with the server.

> There are some performance considerations to be taken into account regarding Dask cluster
> deployment, see [below](#dask-performance-considerations) for more information.

!!! note
    All the following deployment methods assume that you are inside a Python environment that has
    Dask installed. Do not forget to load Python and activate the correct virtual environment at
    the beginning of your PBS job! And also do the same after connecting to any worker nodes
    manually using SSH.

### Manual Deployment

Both the server and the worker nodes can be started using a CLI command. If you prefer manual
deployment, you can manually start the server on a selected node and then start the workers on
other nodes available inside your PBS job.

```bash
# Start the server on some node N
$ dask-scheduler

# Start a single worker on some other node, pass it the address of the server
$ dask-worker tcp://<hostname-of-N>:8786
```

### Dask-ssh Deployment

Dask actually contains [built-in support](https://docs.dask.org/en/latest/setup/ssh.html) for
automating Dask deployment using SSH. It also supports nodefiles provided by PBS, so inside of your
PBS job, you can simply run

```bash
$ dask-ssh --hostfile $PBS_NODEFILE
```

to start the Dask cluster on all available computing nodes. This will start the server on the first
node of your PBS job and then a single worker on each node. The first node will therefore be shared
by a server and a worker, which might not be ideal from a performance point of view.

> Note that for this to work, the `paramiko` Python library has to be installed inside your Python
> environment (you can install it using `$ pip install paramiko`).

You can also start the Cluster directly from your
[Python script](https://docs.dask.org/en/latest/setup/ssh.html#python-interface). In this way you
can start the scheduler and the workers on separate nodes to avoid overcrowding the server node.

### Other Deployment Options

Dask has a lot of other ways of being deployed, e.g. using MPI, or using a shared file on the
network file system. It also allows you to create a PBS job directly, wait for it to be started and
then it starts the whole cluster inside the PBS job. You can find more information about Dask HPC
deployment [here](https://docs.dask.org/en/latest/setup/hpc.html).

## Connecting to the Cluster

Once you have deployed your cluster, you must create a `Client` at the beginning of your program
and pass it the address of the server.

```python
from distributed import Client

client = Client("<hostname-of-server>:8786")
```

Once the client connects to the server successfully, all subsequent Dask computations will be
parallelized using the cluster.

Below are some examples of computations that you can perform with Dask. Note that the code should
only be executed after a client was connected to a server!

### Parallelize Arbitrary Python Code Using `Delayed`

The `delayed` function (or a decorator) turns a Python function into a lazy computation. If you
call such a function, it will not execute right away. It will only return a future object that can
be composed with other futures to build a DAG of tasks. After you describe your whole computation,
you can actually execute it using `dask.compute(<future>)`.

```python
import dask

@dask.delayed
def inc(x):
    return x + 1

@dask.delayed
def double(x):
    return x * 2

@dask.delayed
def add(x, y):
    return x + y

data = [1, 2, 3, 4, 5]

output = []
for x in data:
    a = inc(x)
    b = double(x)
    c = add(a, b)
    output.append(c)

total = dask.delayed(sum)(output)

# `total` is just a lazy computation
# To get the actual value, call dask.compute
result = dask.compute(total)
```

You can find more information about the `delayed` API
[here](https://docs.dask.org/en/latest/delayed.html).

### Parallelize `Pandas`

Dask contains a module called `dataframe` which mirrors the API of `pandas`, a popular library for
tabular analysis. Using `dataframe` you can distribute your `pandas` code to multiple nodes easily.
You can find more information about it [here](https://docs.dask.org/en/latest/dataframe.html).

Here is an example of its usage:

```python
import dask.dataframe as pd

# Load CSV
df = pd.read_csv("table.csv")

# Describe a lazy computation (this is not computed yet)
df2 = df[df.y == "a"].x + 1

# Actually compute the table operations on worker nodes
result = df2.compute()
```

### Parallelize `Numpy`

Dask contains a module called `array` which mirrors the API of `numpy`, a popular library for
n-dimensional array computations. Using `array` you can distribute your `numpy` code to multiple
nodes easily. You can find more information about it
[here](https://examples.dask.org/array.html).

Here is an example of its usage:

```python
import dask.array as np
x = np.random.random((10000, 10000), chunks=(1000, 1000))

# Describe a lazy computation (this is not computed yet)
y = x + x.T
z = y[::2, 5000:].mean(axis=1)

# Actually compute the arary operations on worker nodes
result = z.compute()
```

## Dask Performance Considerations

Dask should be fast enough by default for most use cases, but there are some considerations that
should be taken into account.

### Selecting the Number of Processes and Threads Per Worker

When starting a Dask worker on a node, it will by default use a number of threads equal to the
number of cores on the given machine. At the same time, (C)Python uses a global lock
([GIL](https://realpython.com/python-gil/)) that prevents more than a single thread to execute at
once. This is fine if your computational tasks are I/O bound or if they spend most of their time
inside C libraries that release the GIL.

However, if your tasks executed with Dask are heavily compute-bound, and they hold the GIL (e.g.
the heavy computation is performed directly inside Python), you might not be able to fully harness
all cores of the worker node.

To solve this, you can run multiple workers (each with a reduced number of threads) per node. This
is a trade-off. With more workers on a node, you will be able to utilize more cores (assuming
your tasks are compute-bound). However, you will also increase the pressure on the central server
and on the network, because there will be more workers that will communicate with each other and
with the server.

You can choose the number of workers and threads per each worker using the `--nprocs` and
`--nthreads` parameters of `dask-worker` (there are similar arguments when using other deployment
methods).

Some examples (assuming a node with 24 cores):

```bash
# Run a single worker using 24 threads. Reduces network and server traffic, but may not utilize all cores.
$ dask-worker --nprocs 1 --nthreads 24

# Run 24 workers, each with a single thread. Maximizes core usage, but may overload server or network.
$ dask-worker --nprocs 24 --nthreads 1

# Run 6 workers, each with 4 threads. Strikes a balance between core usage and network/server pressure.
$ dask-worker --nprocs 6 --nthreads 4
```

From our experiments, we found that often it is best to run a single worker per each core of a
node to achieve the best performance. With this configuration, we found that Dask scales reasonably
up to 200 workers (e.g. <10 Barbora nodes). If you start to run into performance problems because
of the amount of workers, try to use [RSDS](#rsds) to achieve better scaling.

### Memory Considerations

A common reason to use Dask is that your computation does not fit inside the memory of a single
node. Dask can alleviate this, but you still have to be careful about your memory usage. For
example, when you use the `dataframe` or `array` API, you should pay attention into how many
partitions (or chunks) is your data split it. If you use a single partition, it will probably take
a lot of memory, and it will not offer many possibilities for parallelization. You can find more
information [here](https://docs.dask.org/en/latest/dataframe-design.html#partitions).

By default, multiple workers on a node will split the available memory. Therefore, if the node
has 100 GiB of RAM and you start the Dask worker on a single node like this:

```bash
$ dask-worker --nprocs 10
```

Each worker will have around 10 GiB memory available. You can set the memory requirements of each
worker manually using the `--memory-limit` argument.

If your program is strictly memory-bound, you can also try alternative approaches to Dask.
As an example, [Vaex](https://github.com/vaexio/vaex) is a library that allows you to easily
process dataframes that do not fit inside your operating memory.

### UCX

In some cases (especially with many workers), the network can be a bottleneck. By default, Dask
uses TCP/IP for communication, but it also has support for UCX, which enables more efficient usage
of the available InfiniBand interfaces. It is a bit cumbersome to set up, but if you want to try,
check [this tutorial](https://ucx-py.readthedocs.io/en/latest/dask.html).

### Nvidia

Dask has built-in support for GPU workers. You can find more information about this use case
[here](https://docs.dask.org/en/latest/gpu.html).

### RSDS

If you need to run a large amount of tasks and Dask does not perform well enough, you can try to
use [RSDS](https://github.com/It4innovations/rsds). It is our version of Dask which is optimized
for HPC use cases, and it should provide better scaling than Dask. You can read more about RSDS
in this [article](https://arxiv.org/abs/2010.11105).
