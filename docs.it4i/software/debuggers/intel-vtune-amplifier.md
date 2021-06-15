# Intel VTune Amplifier XE

## Introduction

Intel*®* VTune™ Amplifier, part of Intel Parallel studio, is a GUI profiling tool designed for Intel processors. It offers a graphical performance analysis of single core and multithreaded applications. A highlight of the features:

* Hotspot analysis
* Locks and waits analysis
* Low-level specific counters, such as branch analysis and memory bandwidth
* Power usage analysis - frequency and sleep states.

![](../../img/vtune-amplifier.png)

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av VTune
```

## Usage

To profile an application with VTune Amplifier, special kernel modules need to be loaded. The modules are not loaded on the login nodes, thus direct profiling on login nodes is not possible. By default, the kernel modules are not loaded on compute nodes either. In order to have the modules loaded, you need to specify the `vtune=version` PBS resource at job submit. The version is the same as for the environment module. For example, for VTune/2016_update1, use:

```console
$ qsub -q qexp -A OPEN-0-0 -I -l select=1,vtune=2016_update1
```

After that, you can verify the modules `sep*`, `pax`, and `vtsspp` are present in the kernel:

```console
$ lsmod | grep -e sep -e pax -e vtsspp
    vtsspp 362000 0
    sep3_15 546657 0
    pax 4312 0
```

To launch the GUI, first load the module:

```console
$ module add VTune/2016_update1
```

and launch the GUI:

```console
$ amplxe-gui
```

The GUI will open in a new window. Click on *New Project...* to create a new project. After clicking OK, a new window with project properties will appear.  At *Application:*, select the path to the binary you want to profile (the binary should be compiled with the `-g` flag). Some additional options, such as command line arguments, can be selected. At *Managed code profiling mode:* select `Native` (unless you want to profile managed mode .NET/Mono applications). After clicking OK, your project is created.

To run a new analysis, click *New analysis...*. You will see a list of possible analyses. Some of them will not be possible on the current CPU (e.g. Intel Atom analysis is not possible on Sandy Bridge CPU), the GUI will show an error box if you select the wrong analysis. For example, select *Advanced Hotspots*. Clicking on *Start* will start profiling of the application.

## Remote Analysis

VTune Amplifier also allows a form of remote analysis. In this mode, data for analysis is collected from the command line without GUI, and the results are then loaded to GUI on another machine. This allows profiling without interactive graphical jobs. To perform a remote analysis, launch the GUI somewhere, open the new analysis window and then click the *Command line* button in the bottom right corner. It will show the command line needed to perform the selected analysis.

The command line will look like this:

```console
/apps/all/VTune/2016_update1/vtune_amplifier_xe_2016.1.1.434111/bin64/amplxe-cl -collect advanced-hotspots -app-working-dir /home/sta545/tmp -- /home/sta545/tmp/sgemm
```

Copy the line to clipboard and then you can paste it in your jobscript or in the command line. After the collection is run, open the GUI once again, click the menu button in the upper right corner, and select *Open > Result...*. The GUI will load the results from the run.

## Xeon Phi

It is possible to analyze both native and offloaded Xeon Phi applications.

### Native Mode

This mode is useful for native Xeon Phi applications launched directly on the card. In the *Analysis Target* window, select *Intel Xeon Phi coprocessor (native)*, choose the path to the binary and MIC card to run on.

### Offload Mode

This mode is useful for applications that are launched from the host and use offload, OpenCL, or mpirun. In the *Analysis Target* window, select *Intel Xeon Phi coprocessor (native)*, choose the path to the binary and the MIC card to run on.

!!! note
    If the analysis is interrupted or aborted, a further analysis on the card might be impossible and you will get errors like *ERROR connecting to MIC card*. In this case, contact our support to reboot the MIC card.

You may also use remote analysis to collect data from the MIC and then analyze it in the GUI later:

Native launch:

```console
$ /apps/all/VTune/2016_update1/vtune_amplifier_xe_2016.1.1.434111/bin64/amplxe-cl -target-system mic-native:0 -collect advanced-hotspots -- /home/sta545/tmp/vect-add-mic
```

Host launch:

```console
$ /apps/all/VTune/2016_update1/vtune_amplifier_xe_2016.1.1.434111/bin64/amplxe-cl -target-system mic-host-launch:0 -collect advanced-hotspots -- /home/sta545/tmp/sgemm
```

You can obtain this command line by pressing the *Command line...* button on the Analysis Type screen.

## References

1. [Intel® VTune™ Amplifier Support][a]
1. [Amplifier Help Linux][b]

[a]: https://software.intel.com/en-us/intel-vtune-amplifier-xe-support/documentation
[b]: https://software.intel.com/en-us/amplifier_help_linux