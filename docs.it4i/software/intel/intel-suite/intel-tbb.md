# Intel TBB

## Introduction

Intel Threading Building Blocks (Intel TBB) is a library that supports scalable parallel programming using standard ISO C++ code. It does not require special languages or compilers.  To use the library, you specify tasks, not threads, and let the library map tasks onto threads in an efficient manner.

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av tbb
```

The module sets up environment variables, required for linking and running TBB-enabled applications.

Link the TBB library using `-ltbb`.

## Examples

A number of examples demonstrating use of TBB and its built-in scheduler is available in the $TBB_EXAMPLES directory.

```console
$ ml intel/2020b tbb/2020.3-GCCcore-10.2.0
$ cp -a $TBB_EXAMPLES/common $TBB_EXAMPLES/parallel_reduce /tmp/
$ cd /tmp/parallel_reduce/primes
$ icc -O2 -DNDEBUG -o primes.x main.cpp primes.cpp -ltbb
$ ./primes.x
```

In this example, we compile, link, and run the primes example, demonstrating use of parallel task-based reduce in computation of prime numbers.

You will need the `tbb` module loaded to run the TBB-enabled executable. This may be avoided by compiling library search paths into the executable.

```console
$ icc -O2 -o primes.x main.cpp primes.cpp -Wl,-rpath=$LIBRARY_PATH -ltbb
```

## Further Reading

Read more on Intel [website][a].

[a]: https://www.intel.com/content/www/us/en/developer/articles/guide/get-started-with-tbb.html?wapkw=tbb
