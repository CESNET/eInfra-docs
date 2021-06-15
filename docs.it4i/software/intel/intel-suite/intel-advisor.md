# Intel Advisor

## Introduction

Intel Advisor is a tool aiming to assist you in vectorization and threading of your code. You can use it to profile your application and identify loops that could benefit from vectorization and/or threading parallelism.

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av Advisor
```

## Usage

Your program should be compiled with the `-g` switch to include symbol names. You should compile with `-O2` or higher to see code that is already vectorized by the compiler.

Profiling is possible either directly from the GUI or from the command line.

To profile from the GUI, launch Advisor:

```console
$ advixe-gui
```

Then select the menu *File -> New -> Project*. Choose a directory to which the project data is saved. After clicking OK, the *Project properties* window appears, where you can configure the path to your binary, launch arguments, working directory, etc. After clicking OK, the project is ready.

In the left pane, you can switch between *Vectorization* and *Threading* workflows. Each has several possible steps, which you can execute by clicking the *Collect* button. Alternatively, you can click on *Command Line* to see the command line required to run the analysis directly from the command line.

## References

1. [Intel® Advisor 2015 Tutorial: Find Where to Add Parallelism - C++ Sample][a]
1. [Product page][b]
1. [Documentation][c]

[a]: https://software.intel.com/en-us/intel-advisor-tutorial-vectorization-windows-cplusplus
[b]: https://software.intel.com/en-us/intel-advisor-xe
[c]: https://software.intel.com/en-us/intel-advisor-2016-user-guide-linux
