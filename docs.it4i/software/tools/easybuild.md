# EasyBuild

The objective of this tutorial is to show how EasyBuild can be used to ease, automate, and script the build of software on the IT4Innovations clusters. Two use-cases are considered. First, we are going to build a software that is supported by EasyBuild. Then, we will see through a simple example how to add support for a new software in EasyBuild.

The benefit of using EasyBuild for your builds is that it allows automated and reproducible build of software. Once a build has been made, the build script (via the EasyConfig file) or the installed software (via the module file) can be shared with other users.

## Short Introduction

EasyBuild is a tool that allows performing automated and reproducible software compilation and installation.

All builds and installations are performed at user level, so you do not need the admin rights. The software is installed in your home directory (by default in `$HOME/.local/easybuild/software/`) and a module file is generated (by default in `$HOME/.local/easybuild/modules/`) to use the software.

EasyBuild relies on two main concepts:

* Toolchains
* EasyConfig file (our easyconfigs is [here][a])

A detailed documentation is available [here][b].

## Toolchains

A toolchain corresponds to a compiler and a set of libraries, which are commonly used to build a software. The two main toolchains frequently used on the IT4Innovations clusters are the **foss** and **intel**.

* **foss** is based on the GCC compiler and on open-source libraries (OpenMPI, OpenBLAS, etc.).
* **intel** is based on the Intel compiler and on Intel libraries (Intel MPI, Intel Math Kernel Library, etc.).

Additional details are available [here][c].

## EasyConfig File

The EasyConfig file is a simple text file that describes the build process of a software. For most software that uses standard procedure (like configure, make, and make install), this file is very simple. Many EasyConfig files are already provided with EasyBuild.

By default, EasyConfig files and generated modules are named using the following convention:

`software-name-software-version-toolchain-name-toolchain-version(-suffix).eb`

Additional details are available [here][d].

## EasyBuild on IT4Innovations Clusters

To use EasyBuild on a compute node, load the `EasyBuild` module:

```console
$ ml av EasyBuild

-------------------------- /apps/modules/modulefiles/tools ---------------------
  EasyBuild/2.8.1    EasyBuild/3.0.0    EasyBuild/3.0.2    EasyBuild/3.1.0 (S,D)

  Where:
   S:  Module is Sticky, requires --force to unload or purge
   D:  Default Module

$ ml EasyBuild
```

The EasyBuild command is `eb`. Check the version you have loaded:

```console
$ eb --version
This is EasyBuild 3.1.0 (framework: 3.1.0, easyblocks: 3.1.0) on host login2
```

To get help on the EasyBuild options, use the `-h` or `-H` option flags:

```console
$ eb -h
Usage: eb [options] easyconfig [...]

Builds software based on easyconfig (or parse a directory). Provide one or
more easyconfigs or directories, use -H or --help more information.

Options:
  -h                show short help message and exit
  -H OUTPUT_FORMAT  show full help message and exit

  Debug and logging options (configfile section MAIN):
    -d              Enable debug log mode (def False)

  Basic options:
    Basic runtime options for EasyBuild. (configfile section basic)
...
```

## Build Software Using Provided EasyConfig File

### Search for Available Easyconfig

Searching for available easyconfig files can be done using the `--search` (long output) and `-S` (short output) command line options. All easyconfig files available in the robot search path are considered and searching is done case-insensitive.

```console
$ eb -S git
CFGS1=/apps/easybuild/easyconfigs/easybuild/easyconfigs
 * $CFGS1/g/git-lfs/git-lfs-1.1.1.eb
 * $CFGS1/g/git/git-1.7.12-goalf-1.1.0-no-OFED.eb
 * $CFGS1/g/git/git-1.7.12-goolf-1.4.10.eb
 * $CFGS1/g/git/git-1.7.12-ictce-4.0.6.eb
 * $CFGS1/g/git/git-1.7.12-ictce-5.3.0.eb
 * $CFGS1/g/git/git-1.8.2-cgmpolf-1.1.6.eb
 * $CFGS1/g/git/git-1.8.2-cgmvolf-1.1.12rc1.eb
 * $CFGS1/g/git/git-1.8.2-cgmvolf-1.2.7.eb
 * $CFGS1/g/git/git-1.8.2-cgoolf-1.1.7.eb
 * $CFGS1/g/git/git-1.8.2-gmvolf-1.7.12.eb
 * $CFGS1/g/git/git-1.8.2-gmvolf-1.7.12rc1.eb
 * $CFGS1/g/git/git-1.8.2-goolf-1.4.10.eb
 * $CFGS1/g/git/git-1.8.3.1-goolf-1.4.10.eb
 * $CFGS1/g/git/git-1.8.5.6-GCC-4.9.2.eb
 * $CFGS1/g/git/git-2.10.2.eb
 * $CFGS1/g/git/git-2.11.0-GNU-4.9.3-2.25.eb
 * $CFGS1/g/git/git-2.11.0.eb
 * $CFGS1/g/git/git-2.2.2-GCC-4.9.2.eb
 * $CFGS1/g/git/git-2.4.1-GCC-4.9.2.eb
 * $CFGS1/g/git/git-2.7.3-GNU-4.9.3-2.25.eb
 * $CFGS1/g/git/git-2.7.3-foss-2015g.eb
 * $CFGS1/g/git/git-2.8.0-GNU-4.9.3-2.25.eb
 * $CFGS1/g/git/git-2.8.0-foss-2016a.eb
 * $CFGS1/g/git/git-2.8.0-intel-2017.00.eb
 * $CFGS1/g/git/git-2.8.0.eb
```

### Get an Overview of Planned Installations

You can do a “dry-run” overview by supplying `-D`/`--dry-run` (typically combined with `--robot`, in the form of `-Dr`):

```console
$ eb git-2.8.0.eb -Dr
eb git-2.8.0.eb -Dr
== temporary log file in case of crash /tmp/eb-JcU1eA/easybuild-emly2F.log
Dry run: printing build status of easyconfigs and dependencies
CFGS=/apps/easybuild/easyconfigs/easybuild/easyconfigs
 * [x] $CFGS/c/cURL/cURL-7.37.1.eb (module: cURL/7.37.1)
 * [x] $CFGS/e/expat/expat-2.1.0.eb (module: expat/2.1.0)
 * [x] $CFGS/g/gettext/gettext-0.19.2.eb (module: gettext/0.19.2)
 * [x] $CFGS/p/Perl/Perl-5.20.2-bare.eb (module: Perl/5.20.2-bare)
 * [x] $CFGS/m/M4/M4-1.4.17.eb (module: M4/1.4.17)
 * [x] $CFGS/a/Autoconf/Autoconf-2.69.eb (module: Autoconf/2.69)
 * [ ] $CFGS/g/git/git-2.8.0.eb (module: git/2.8.0)
== Temporary log file(s) /tmp/eb-JcU1eA/easybuild-emly2F.log* have been removed.
== Temporary directory /tmp/eb-JcU1eA has been removed.
```

### Compile and Install Module

If we try to build *git-2.8.0.eb*, nothing will happen as it is already installed on the cluster. To enable dependency resolution, use the `--robot` command line option (or `-r` for short):

```console
$ eb git-2.8.0.eb -r
== temporary log file in case of crash /tmp/eb-PXe3Zo/easybuild-hEckF4.log
== git/2.8.0 is already installed (module found), skipping
== No easyconfigs left to be built.
== Build succeeded for 0 out of 0
== Temporary log file(s) /tmp/eb-PXe3Zo/easybuild-hEckF4.log* have been removed.
== Temporary directory /tmp/eb-PXe3Zo has been removed.
```

Rebuild *git-2.8.0.eb*. Use `eb --rebuild` to rebuild a given easyconfig/module or use `eb --force`/`-f` to force the reinstallation of a given easyconfig/module. The behavior of `--force` is the same as `--rebuild` and `--ignore-osdeps`.

```console
$ eb git-2.8.0.eb -r -f
== temporary log file in case of crash /tmp/eb-JS_Fb5/easybuild-OwJZKn.log
== resolving dependencies ...
== processing EasyBuild easyconfig /apps/easybuild/easyconfigs/easybuild/easyconfigs/g/git/git-2.8.0.eb
== building and installing git/2.8.0...
== fetching files...
== creating build dir, resetting environment...
== unpacking...
== patching...
== preparing...
== configuring...
== building...
== testing...
== installing...
== taking care of extensions...
== postprocessing...
== sanity checking...
== cleaning up...
== creating module...
== permissions...
== packaging...
== COMPLETED: Installation ended successfully
== Results of the build can be found in the log file(s) /apps/all/git/2.8.0/easybuild/easybuild-git-2.8.0-20170221.110059.log
== Build succeeded for 1 out of 1
== Temporary log file(s) /tmp/eb-JS_Fb5/easybuild-OwJZKn.log\* have been removed.
== Temporary directory /tmp/eb-JS_Fb5 has been removed.
```

If we try to build *git-2.11.0.eb*:

```console
== temporary log file in case of crash /tmp/eb-JS_Fb5/easybuild-OwXCKn.log
== resolving dependencies ...
== processing EasyBuild easyconfig /apps/easybuild/easyconfigs/easybuild/easyconfigs/g/git/git-2.11.0.eb
== building and installing git/2.11.0...
== fetching files...
== creating build dir, resetting environment...
== unpacking...
== patching...
== preparing...
== configuring...
== building...
== testing...
== installing...
== taking care of extensions...
== postprocessing...
== sanity checking...
== cleaning up...
== creating module...
== permissions...
== packaging...
== COMPLETED: Installation ended successfully
== Results of the build can be found in the log file(s) /apps/all/git/2.11.0/easybuild/easybuild-git-2.11.0-20170221.110059.log
== Build succeeded for 1 out of 1
== Temporary log file(s) /tmp/eb-JS_Fb5/easybuild-OwXCKn.log\* have been removed.
== Temporary directory /tmp/eb-JS_Fb5 has been removed.
```

If we try to build *git-2.11.1*, but we used easyconfig *git-2.11.0.eb*, change the version command `--try-software-version=2.11.1`:

```console
$ eb git-2.11.0.eb -r --try-software-version=2.11.1
== temporary log file in case of crash /tmp/eb-oisi0q/easybuild-2rNh7I.log
== resolving dependencies ...
== processing EasyBuild easyconfig /tmp/eb-oisi0q/tweaked_easyconfigs/git-2.11.1.eb
== building and installing git/2.11.1...
== fetching files...
== creating build dir, resetting environment...
== unpacking...
== patching...
== preparing...
== configuring...
== building...
== testing...
== installing...
== taking care of extensions...
== postprocessing...
== sanity checking...
== cleaning up...
== creating module...
== permissions...
== packaging...
== COMPLETED: Installation ended successfully
== Results of the build can be found in the log file(s) /apps/all/git/2.11.1/easybuild/easybuild-git-2.11.1-20170221.111005.log
== Build succeeded for 1 out of 1
== Temporary log file(s) /tmp/eb-oisi0q/easybuild-2rNh7I.log\* have been removed.
== Temporary directory /tmp/eb-oisi0q has been removed.
```

If we try to build *git-2.11.1-intel-2017a*, but we used easyconfig *git-2.11.0.eb*, change toolchains `--try-toolchain-name=intel`, `--try-toolchain-version=2017a` or `--try-toolchain=intel,2017a`:

```console
$ eb git-2.11.0.eb -r --try-toolchain=intel,2017a
== temporary log file in case of crash /tmp/eb-oisi0q/easybuild-2Trh7I.log
== resolving dependencies ...
== processing EasyBuild easyconfig /tmp/eb-oisi0q/tweaked_easyconfigs/git-2.11.1-intel-2017a.eb
== building and installing git/2.11.1-intel-2017a...
== fetching files...
== creating build dir, resetting environment...
== unpacking...
== patching...
== preparing...
== configuring...
== building...
== testing...
== installing...
== taking care of extensions...
== postprocessing...
== sanity checking...
== cleaning up...
== creating module...
== permissions...
== packaging...
== COMPLETED: Installation ended successfully
== Results of the build can be found in the log file(s) /apps/all/git/2.11.1-intel-2017a/easybuild/easybuild-git-2.11.1-20170221.111005.log
== Build succeeded for 1 out of 1
== Temporary log file(s) /tmp/eb-oisi0q/easybuild-2Trh7I.log\* have been removed.
== Temporary directory /tmp/eb-oisi0q has been removed.
```

### MODULEPATH

To see the newly installed modules, you need to add the path where they were installed to the MODULEPATH. On the cluster, you have to use the `module use` command:

```console
$ module use $HOME/.local/easybuild/modules/all/
```

or modify your `.bash_profile`:

```console
$ cat ~/.bash_profile
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

# User specific environment and startup programs

module use $HOME/.local/easybuild/modules/all/

PATH=$PATH:$HOME/bin

export PATH
```

## Build Software Using Your Own EasyConfig File

For this example, we create an EasyConfig file to build Git 2.11.1 with the *foss* toolchain. Open your favorite editor and create a file named *git-2.11.1-foss-2017a.eb* with the following content:

```console
$ vim git-2.11.1-foss-2017a.eb
```

```python
easyblock = 'ConfigureMake'

name = 'git'
version = '2.11.1'

homepage = 'http://git-scm.com/'
description = """Git is a free and open source distributed version control system designed
to handle everything from small to very large projects with speed and efficiency."""

toolchain = {'name': 'foss', 'version': '2017a'}

sources = ['v%(version)s.tar.gz']
source_urls = ['https://github.com/git/git/archive']

builddependencies = [('Autoconf', '2.69')]

dependencies = [
    ('cURL', '7.37.1'),
    ('expat', '2.1.0'),
    ('gettext', '0.19.2'),
    ('Perl', '5.20.2'),
]

preconfigopts = 'make configure && '

# Work around git build system bug.  If LIBS contains -lpthread, then configure
# will not append -lpthread to LDFLAGS, but Makefile ignores LIBS.
configopts = "--with-perl=${EBROOTPERL}/bin/perl --enable-pthreads='-lpthread'"

sanity_check_paths = {
    'files': ['bin/git'],
    'dirs': [],
}

moduleclass = 'tools'
```

This is a simple EasyConfig. Most of the fields are self-descriptive. No build method is explicitly defined, so it uses by default the standard configure/make/make install approach.

Let us build Git with this EasyConfig file:

```console
$ eb ./git-2.11.1-foss-2017a.eb -r
== temporary log file in case of crash /tmp/eb-oisi0q/easybuild-2Tii7I.log
== resolving dependencies ...
== processing EasyBuild easyconfig /home/username/git-2.11.1-foss-2017a.eb
== building and installing git/2.11.1-foss-2017a...
== fetching files...
== creating build dir, resetting environment...
== unpacking...
== patching...
== preparing...
== configuring...
== building...
== testing...
== installing...
== taking care of extensions...
== postprocessing...
== sanity checking...
== cleaning up...
== creating module...
== permissions...
== packaging...
== COMPLETED: Installation ended successfully
== Results of the build can be found in the log file(s) /home/username/.local/easybuild/modules/all/git/2.11.1-foss-2017a/easybuild/easybuild-git-2.11.1-20170221.111005.log
== Build succeeded for 1 out of 1
== Temporary log file(s) /tmp/eb-oisi0q/easybuild-2Tii7I.log\* have been removed.
== Temporary directory /tmp/eb-oisi0q has been removed.
```

We can now check that our version of Git is available via the modules:

```console
$ ml av git

-------------------------------- /apps/modules/modulefiles/tools -------------------------
   git/2.8.0-GNU-4.9.3-2.25    git/2.11.0-GNU-4.9.3-2.25    git/2.11.1-GNU-4.9.3-2.25 (D)

-------------------------------- /home/username/.local/easybuild/modules/all -------------
   git/2.11.1-foss-2017a

  Where:
   D:  Default Module

  If you need software that is not listed, request it at support@it4i.cz.
```

## Submitting Build Jobs (Experimental)

Using the `--job` command line option, you can instruct EasyBuild to submit jobs for the installations that should be performed, rather than performing the installations locally on the system you are on.

```console
$ eb git-2.11.0-GNU-4.9.3-2.25.eb -r --job
== temporary log file in case of crash /tmp/eb-zeLzBb/easybuild-H_Z0fB.log
== resolving dependencies ...
== GC3Pie job overview: 1 submitted (total: 1)
== GC3Pie job overview: 1 running (total: 1)
== GC3Pie job overview: 1 running (total: 1)
== GC3Pie job overview: 1 running (total: 1)
== GC3Pie job overview: 1 running (total: 1)
== GC3Pie job overview: 1 running (total: 1)
== GC3Pie job overview: 1 running (total: 1)
== GC3Pie job overview: 1 running (total: 1)
== GC3Pie job overview: 1 running (total: 1)
== GC3Pie job overview: 1 terminated, 1 ok (total: 1)
== GC3Pie job overview: 1 terminated, 1 ok (total: 1)
== Done processing jobs
== GC3Pie job overview: 1 terminated, 1 ok (total: 1)
== Submitted parallel build jobs, exiting now
== Temporary log file(s) /tmp/eb-zeLzBb/easybuild-H_Z0fB.log* have been removed.
== Temporary directory /tmp/eb-zeLzBb has been removed.
```

!!! note ""
    Salomon jobs ... XXXXX.isrv5

```console
$ qstat -u username -w
                                                                                                    Req'd  Req'd   Elap
Job ID                         Username        Queue           Jobname         SessID   NDS  TSK   Memory Time  S Time
------------------------------ --------------- --------------- --------------- -------- ---- ----- ------ ----- - -----
1319314.isrv5                    username        qprod           git-2.11.0-GNU-    85605    1    16    --  24:00 R 00:00:17
```

[a]: https://code.it4i.cz/sccs/easyconfigs-it4i
[b]: http://easybuild.readthedocs.io
[c]: https://github.com/hpcugent/easybuild/wiki/Compiler-toolchains
[d]: https://github.com/hpcugent/easybuild-easyconfigs
