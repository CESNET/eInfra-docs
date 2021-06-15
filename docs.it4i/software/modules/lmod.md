# Lmod Environment

Lmod is a modules tool, a modern alternative to the outdated & no longer actively maintained Tcl-based environment modules tool.

Detailed documentation on Lmod is available [here][a].

## Benefits

* significantly more responsive module commands, in particular `ml av`
* easier to use interface
* module files can be written in either the Tcl or Lua syntax (and both types of modules can be mixed together)

## Introduction

Below you will find more details and examples.

| command                  | equivalent/explanation                                           |
| ------------------------ | ---------------------------------------------------------------- |
| ml                       | module list                                                      |
| ml GCC/6.2.0-2.27        | ml GCC/6.2.0-2.27                                                |
| ml -GCC/6.2.0-2.27       | module unload GCC/6.2.0-2.27                                     |
| ml purge                 | module unload all modules                                        |
| ml av                    | ml av                                                            |
| ml show GCC/6.2.0-2.27   | module show GCC                                                  |
| ml spider gcc            | searches (case-insensitive) for gcc in all available modules |
| ml spider GCC/6.2.0-2.27 | show all information about the module GCC/6.2.0-2.27             |
| ml save mycollection     | stores the currently loaded modules to a collection              |
| ml restore mycollection  | restores a previously stored collection of modules               |

## Listing Loaded Modules

To get an overview of the currently loaded modules, use `module list` or `ml` (without specifying extra arguments):

```console
$ ml
Currently Loaded Modules:
   1) EasyBuild/3.0.0 (S)  2) lmod/7.2.2
  Where:
   S:  Module is Sticky, requires --force to unload or purge
```

!!! tip
    For more details on sticky modules, see the section on [ml purge][1].

## Searching for Available Modules

To get an overview of all available modules, you can use `ml avail` or simply `ml av`:

```console
$ ml av
---------------------------------------- /apps/modules/compiler ----------------------------------------------
   GCC/5.2.0    GCCcore/6.2.0 (D)    icc/2013.5.192     ifort/2013.5.192    LLVM/3.9.0-intel-2017.00 (D)
                                 ...                                  ...

---------------------------------------- /apps/modules/devel -------------------------------------------------
   Autoconf/2.69-foss-2015g    CMake/3.0.0-intel-2016.01   M4/1.4.17-intel-2016.01   pkg-config/0.27.1-foss-2015g
   Autoconf/2.69-foss-2016a    CMake/3.3.1-foss-2015g      M4/1.4.17-intel-2017.00   pkg-config/0.27.1-intel-2015b
                                 ...                                  ...
```

In the current module naming scheme, each module name consists of two parts:

* the part before the first /, corresponding to the software name
* the remainder, corresponding to the software version, the compiler toolchain that was used to install the software, and a possible version suffix

!!! tip
    `(D)` indicates that this particular version of the module is the default, but we strongly recommend to not rely on this, as the default can change at any point. Usually, the default points to the latest version available.

## Searching for Modules

If you just provide a software name, for example `gcc`, it prints an overview of all available modules for GCC.

```console
$ ml spider gcc
---------------------------------------------------------------------------------
  GCC:
---------------------------------------------------------------------------------
    Description:
      The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Java, and Ada, as well as libraries for these languages (libstdc++, libgcj,...). - Homepage: http://gcc.gnu.org/

     Versions:
        GCC/4.4.7-system
        GCC/4.7.4
        GCC/4.8.3
        GCC/4.9.2-binutils-2.25
        GCC/4.9.2
        GCC/4.9.3-binutils-2.25
        GCC/4.9.3
        GCC/4.9.3-2.25
        GCC/5.1.0-binutils-2.25
        GCC/5.2.0
        GCC/5.3.0-binutils-2.25
        GCC/5.3.0-2.25
        GCC/5.3.0-2.26
        GCC/5.3.1-snapshot-20160419-2.25
        GCC/5.4.0-2.26
        GCC/6.2.0-2.27

     Other possible modules matches:
        GCCcore
---------------------------------------------------------------------------------
  To find other possible module matches do:
      module -r spider '.*GCC.*'
---------------------------------------------------------------------------------
  For detailed information about a specific "GCC" module (including how to load the modules) use the module's full name.
  For example:
     $ module spider GCC/6.2.0-2.27
---------------------------------------------------------------------------------
```

!!! tip
    `spider` is case-insensitive.

If you use `spider` on a full module name like `GCC/6.2.0-2.27`, it will tell on which cluster(s) that module is available:

```console
$ module spider GCC/6.2.0-2.27
--------------------------------------------------------------------------------------------------------------
  GCC: GCC/6.2.0-2.27
--------------------------------------------------------------------------------------------------------------
    Description:
      The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Java, and Ada, as well as libraries for these languages (libstdc++, libgcj...). - Homepage: http://gcc.gnu.org/

    This module can be loaded directly: ml GCC/6.2.0-2.27

    Help:
      The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Java, and Ada,
       as well as libraries for these languages (libstdc++, libgcj,...). - Homepage: http://gcc.gnu.org/
```

This tells you what the module contains and what the URL to the homepage of the software is.

## Available Modules for a Particular Software Package

To check which modules are available for a particular software package, you can provide the software name to `ml av`.
For example, to check which versions of Git are available:

```console
$ ml av git

-------------------------------------- /apps/modules/tools ----------------------------------------
   git/2.8.0-GNU-4.9.3-2.25    git/2.8.0-intel-2017.00    git/2.9.0    git/2.9.2    git/2.11.0 (D)

  Where:
   D:  Default Module

Use "module spider" to find all possible modules.
Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".
```

!!! tip
    The specified software name is case-insensitive.

Lmod does a partial match on the module name, so sometimes you need to specify the end of the software name you are interested in:

```console
$ ml av GCC/

------------------------------------------ /apps/modules/compiler -------------------------------------------
GCC/4.4.7-system    GCC/4.8.3   GCC/4.9.2   GCC/4.9.3   GCC/5.1.0-binutils-2.25 GCC/5.3.0-binutils-2.25   GCC/5.3.0-2.26   GCC/5.4.0-2.26   GCC/4.7.4   GCC/4.9.2-binutils-2.25   GCC/4.9.3-binutils-2.25   GCC/4.9.3-2.25   GCC/5.2.0   GCC/5.3.0-2.25 GCC/6.2.0-2.27 (D)

  Where:
   D:  Default Module

Use "module spider" to find all possible modules.
Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".
```

## Inspecting a Module

To see how a module would change the environment, use `ml show`:

```console
$ ml show Python/3.5.2

help([[Python is a programming language that lets you work more quickly and integrate your systems more effectively. - Homepage: http://python.org/]])
whatis("Description: Python is a programming language that lets you work more quickly and integrate your systems more effectively. - Homepage: http://python.org/")
conflict("Python")
load("bzip2/1.0.6")
load("zlib/1.2.8")
load("libreadline/6.3")
load("ncurses/5.9")
load("SQLite/3.8.8.1")
load("Tk/8.6.3")
load("GMP/6.0.0a")
load("XZ/5.2.2")
prepend_path("CPATH","/apps/all/Python/3.5.2/include")
prepend_path("LD_LIBRARY_PATH","/apps/all/Python/3.5.2/lib")
prepend_path("LIBRARY_PATH","/apps/all/Python/3.5.2/lib")
prepend_path("MANPATH","/apps/all/Python/3.5.2/share/man")
prepend_path("PATH","/apps/all/Python/3.5.2/bin")
prepend_path("PKG_CONFIG_PATH","/apps/all/Python/3.5.2/lib/pkgconfig")
setenv("EBROOTPYTHON","/apps/all/Python/3.5.2")
setenv("EBVERSIONPYTHON","3.5.2")
setenv("EBDEVELPYTHON","/apps/all/Python/3.5.2/easybuild/Python-3.5.2-easybuild-devel")
setenv("EBEXTSLISTPYTHON","setuptools-20.1.1,pip-8.0.2,nose-1.3.7")
```

!!! tip
    Note that both the direct changes to the environment as well as other modules that will be loaded are shown.

## Loading Modules

!!! warning
    Always specify the name **and** the version when loading a module.
    Loading a default module in your script (e.g. `$ ml intel`) will cause divergent results in the case the default module is upgraded.
    **IT4Innovations is not responsible for any loss of allocated core-hours resulting from the use of improper modules in your calculations.**

To effectively apply the changes to the environment that are specified by a module, use `ml` and specify the name of the module.
For example, to set up your environment to use Intel:

```console
$ ml intel/2017.00
$ ml
Currently Loaded Modules:
  1) GCCcore/5.4.0
  2) binutils/2.26-GCCcore-5.4.0                        (H)
  3) icc/2017.0.098-GCC-5.4.0-2.26
  4) ifort/2017.0.098-GCC-5.4.0-2.26
  5) iccifort/2017.0.098-GCC-5.4.0-2.26
  6) impi/2017.0.098-iccifort-2017.0.098-GCC-5.4.0-2.26
  7) iimpi/2017.00-GCC-5.4.0-2.26
  8) imkl/2017.0.098-iimpi-2017.00-GCC-5.4.0-2.26
  9) intel/2017.00

  Where:
   H:  Hidden Module
```

!!! tip
    Note that even though we only loaded a single module, the output of `ml` shows that a whole set of modules was loaded. These are required dependencies for `intel/2017.00`.

## Conflicting Modules

!!! warning
    It is important to note that **only modules that are compatible with each other can be loaded together. In particular, modules must be installed either with the same toolchain as the modules that are already loaded, or with a compatible (sub)toolchain**.

For example, once you have loaded one or more modules that were installed with the `intel/2017.00` toolchain, all other modules that you load should have been installed with the same toolchain.

In addition, only **one single version** of each software package can be loaded at a particular time. For example, once you have the `Python/3.5.2-intel-2017.00` module loaded, you cannot load a different version of Python in the same session/job script, neither directly, nor indirectly as a dependency of another module you want to load.

## Unloading Modules

To revert the changes to the environment that were made by a particular module, you can use `ml -<modname>`.
For example:

```console
$ ml
Currently Loaded Modules:
  1) EasyBuild/3.0.0 (S)   2) lmod/7.2.2
$ which gcc
/usr/bin/gcc
$ ml GCC/
$ ml
Currently Loaded Modules:
  1) EasyBuild/3.0.0 (S)   2) lmod/7.2.2   3) GCCcore/6.2.0   4) binutils/2.27-GCCcore-6.2.0 (H)   5) GCC/6.2.0-2.27
$ which gcc
/apps/all/GCCcore/6.2.0/bin/gcc
$ ml -GCC
$ ml
Currently Loaded Modules:
  1) EasyBuild/3.0.0 (S)   2) lmod/7.2.2   3) GCCcore/6.2.0   4) binutils/2.27-GCCcore-6.2.0 (H)
$ which gcc
/usr/bin/gcc
```

## Resetting by Unloading All Modules

To reset your environment back to a clean state, you can use `ml purge` or `ml purge --force`:

```console
$ ml
Currently Loaded Modules:
  1) EasyBuild/3.0.0 (S)   2) lmod/7.2.2   3) GCCcore/6.2.0   4) binutils/2.27-GCCcore-6.2.0 (H)
$ ml purge
The following modules were not unloaded:
   (Use "module --force purge" to unload all):
 1) EasyBuild/3.0.0
$ ml
Currently Loaded Modules:
 1) EasyBuild/3.0.0 (S)
$ ml purge --force
$ ml
No modules loaded
```

As such, you should not (re)load the cluster module anymore after running `ml purge`.

## Module Collections

If you have a set of modules that you need to load often, you can save these in a collection (only works with Lmod).

First, load all the modules you need, for example:

```console
$ ml intel/2017.00 Python/3.5.2-intel-2017.00
```

Now store them in a collection using `ml save`:

```console
$ ml save my-collection
```

Later, for example in a job script, you can reload all these modules with `ml restore`:

```console
$ ml restore my-collection
```

With `ml savelist`, you can get a list of all saved collections:

```console
$ ml savelist
Named collection list:
  1) my-collection
  2) my-test-collection
```

To inspect a collection, use `ml describe`.

To remove a module collection, remove the corresponding entry in $HOME/.lmod.d.

[1]: #resetting-by-unloading-all-modules

[a]: http://lmod.readthedocs.io
