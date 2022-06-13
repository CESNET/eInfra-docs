# Intel Inspector

## Introduction

Intel Inspector is a dynamic memory and threading error-checking tool for C/C++/Fortran applications. It can detect issues such as memory leaks, invalid memory references, uninitialized variables, race conditions, deadlocks, etc.

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av Inspector
```

## Usage

Your program should be compiled with the `-g` switch to include symbol names. Optimizations can be turned on.

Debugging is possible either directly from the GUI, or from command line.

### GUI Mode

To debug from GUI, launch Inspector:

```console
$ inspxe-gui &
```

Then select the *File -> New -> Project* menu. Choose a directory to which the project data is saved. After clicking OK, the *Project properties* window appears, where you can configure the path to your binary, launch arguments, working directory, etc. After clicking OK, the project is ready.

In the main pane, you can start a predefined analysis type or define your own. Click *Start* to start the analysis. Alternatively, you can click on *Command Line*, to see the command line required to run the analysis directly from the command line.

### Batch Mode

Analysis can be also run from the command line in batch mode. Batch mode analysis is run with the `inspxe-cl` command. To obtain the required parameters, consult the documentation or configure the analysis in the GUI and then click the *Command Line* button in the lower right corner to the respective command line.

Results obtained from batch mode can be then viewed in the GUI by selecting *File -> Open -> Result...*.

## References

1. [Product page][a]
1. [Documentation and Release Notes][b]
1. [Tutorials][c]

[a]: https://software.intel.com/en-us/intel-inspector-xe
[b]: https://software.intel.com/en-us/intel-inspector-xe-support/documentation
[c]: https://software.intel.com/en-us/articles/inspectorxe-tutorials
