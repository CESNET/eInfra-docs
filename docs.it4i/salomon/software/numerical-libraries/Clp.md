# CLP

## Introduction

Clp (Coin-or linear programming) is an open-source linear programming solver written in C++. It is primarily meant to be used as a callable library, but a basic, stand-alone executable version is also available.

Clp ([projects.coin-or.org/Clp][1]) is a part of the COIN-OR (The Computational Infrastracture for Operations Research) project ([projects.coin-or.org/][2]).

## Modules

Clp, version 1.16.10 is available on Salomon via module Clp:

```console
$ ml Clp
```

The module sets up environment variables required for linking and running applications using Clp. This particular command loads the default module Clp/1.16.10-intel-2017a, Intel module intel/2017a and other related modules.

## Compiling and Linking

!!! note
    Link with -lClp

Load the Clp module. Link using -lClp switch to link your code against Clp.

```console
$ ml Clp
$ icc myprog.c -o myprog.x -Wl,-rpath=$LIBRARY_PATH -lClp
```

## Example

An example of Clp enabled application follows. In this example, the library solves linear programming problem loaded from file.

```cpp
#include "coin/ClpSimplex.hpp"

int main (int argc, const char *argv[])
{
    ClpSimplex model;
    int status;
    if (argc<2)
        status=model.readMps("/apps/all/Clp/1.16.10-intel-2017a/lib/p0033.mps");
    else
        status=model.readMps(argv[1]);
    if (!status) {
        model.primal();
    }
    return 0;
}
```

### Load Modules and Compile:

```console
ml Clp
icc lp.c -o lp.x -Wl,-rpath=$LIBRARY_PATH -lClp
```

In this example, the lp.c code is compiled using the Intel compiler and linked with Clp. To run the code, the Intel module has to be loaded.

[1]: https://projects.coin-or.org/Clp
[2]: https://projects.coin-or.org/
