# LMGC90

## Introduction

LMGC90 is a free and open source software dedicated to multiple physics simulation of discrete material and structures.

## Modules

The LMGC90, version 2017.rc1 is available on Salomon via module `LMGC90`:

```sh
$ ml LMGC90
```

The module sets up environment variables and loads some other modules required for running LMGC90 Python scripts. This particular command loads the default module `LMGC90/2017.rc1-GCC-6.3.0-2.27` and modules:

```console
GCCcore/6.3.0
binutils/2.27-GCCcore-6.3.0
GCC/6.3.0-2.27
bzip2/1.0.6
zlib/1.2.8
ncurses/6.0
libreadline/6.3
Tcl/8.6.3
SQLite/3.8.8.1
Python/2.7.9
```

## Running Generic Example

LMGC90's main API is a Python module. It comes with a pre-processor written in Python. There are several examples that you can copy from the `examples` directory which is in the `/apps/all/LMGC90/2017.rc1-GCC-6.3.0-2.27` folder. Follow the next steps to run one of them.

First choose an example and open a terminal in the directory of the copied example.

### Generation

For more information on the pre-processor, open in a web navigator the file [docs/pre_lmgc/index.html][pre_lmgc].

To run an example, if there is no `DATBOX` directory or it is empty, run the Python generation script which is mostly called `gen_sample.py` with the command:

```console
$ python gen_sample.py
```

You should now have a `DATBOX` directory containing all needed `.DAT` and `.INI` files.

### Computation

Now run the command script usually called `command.py`:

```console
$ python command.py
```

For more information on the structure on command scripts, read the documentation opening the file [docs/chipy/index.html][chipy] in a web browser.
Once the computation is done, you should get the directory `OUTBOX` containing ASCII output files, and a `DISPLAY` directory with an output file readable by paraview.

### Postprocessing and Visualization

The ASCII files in the `POSTPRO` directory result from the commands in the `DATBOX/POSTPRO.DAT` file. For more information on how to use these features, read the documents [manuals/LMGC90_Postpro.pdf][LMGC90_Postpro.pdf].
The files inside the `DISPLAY` directory can be visualized with paraview. It is advised to read the `.pvd` files which ensure time consistency. The different output files are:

- tacts: contactors of rigid objects
- rigids: center of mass of rigid objects
- inter: interactions
- mecafe: mechanical mesh
- therfe: thermal mesh
- porofe: porous mechanical mesh
- multife: multi-phasic fluid in porous media mesh

[Welcome](http://www.lmgc.univ-montp2.fr/~dubois/LMGC90/Web/Welcome_!.html)
[pre_lmgc](http://www.lmgc.univ-montp2.fr/%7Edubois/LMGC90/UserDoc/pre/index.html)
[chipy](http://www.lmgc.univ-montp2.fr/%7Edubois/LMGC90/UserDoc/chipy/index.html)
[LMGC90_Postpro.pdf](https://git-xen.lmgc.univ-montp2.fr/lmgc90/lmgc90_user/blob/2017.rc1/manuals/LMGC90_Postpro.pdf)
