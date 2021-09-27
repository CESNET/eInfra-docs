# Spack

Spack is a package manager for supercomputers, Linux, and macOS. It makes installing scientific software easy. With Spack, you can build a package with multiple versions, configurations, platforms, and compilers, and all of these builds can coexist on the same machine.

For more information, see Spack's [documentation][a].

## Spack on IT4Innovations Clusters

```console

$ ml av Spack

---------------------- /apps/modules/devel ------------------------------
   Spack/0.16.2 (D)
```

!!! note
    Spack/default is the rule for setting up local installation

## First Usage Module Spack/Default

Spack will be installed into the ~/Spack folder. You can set the configuration by modifying ~/.spack/configure.yml.

```console
$ ml Spack
== Settings for first use
Couldn't import dot_parser, loading of dot files will not be possible.
== temporary log file in case of crash /tmp/eb-wLh1RT/easybuild-54vEn3.log
== processing EasyBuild easyconfig /apps/easybuild/easyconfigs-master/easybuild/easyconfigs/s/Spack/Spack-0.16.2.eb
== building and installing Spack/0.16.2...
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
== Results of the build can be found in the log file(s) /home/user/.local/easybuild/software/Spack/0.16.2/easybuild/easybuild-Spack-0.16.2-20210922.123022.log
== Build succeeded for 1 out of 1
== Temporary log file(s) /tmp/eb-wLh1RT/easybuild-54vEn3.log* have been removed.
== Temporary directory /tmp/eb-wLh1RT has been removed.
== Create folder ~/Spack

The following have been reloaded with a version change:
  1) Spack/default => Spack/0.16.2

$ spack --version
0.16.2
```

## Usage Module Spack/Default

```console
$ ml Spack
$ ml

Currently Loaded Modules:
  1) Spack/0.16.2
```

## Build Software Package

Packages in Spack are written in pure Python, so you can do anything in Spack that you can do in Python. Python was chosen as the implementation language for two reasons. First, Python is becoming ubiquitous in the scientific software community. Second, it is a modern language and has many powerful features to help make package writing easy.

### Search for Available Software

To install software with Spack, you need to know what software is available. Use the `spack list` command.

```console
$ spack list
==> 1114 packages.
abinit                    font-bh-100dpi                   libffi             npm                                    py-ply                     r-maptools       tetgen
ack                       font-bh-75dpi                    libfontenc         numdiff                                py-pmw                     r-markdown       tethex
activeharmony             font-bh-lucidatypewriter-100dpi  libfs              nwchem                                 py-prettytable             r-mass           texinfo
adept-utils               font-bh-lucidatypewriter-75dpi   libgcrypt          ocaml                                  py-proj                    r-matrix         texlive
adios                     font-bh-ttf                      libgd              oce                                    py-prompt-toolkit          r-matrixmodels   the-platinum-searcher
adol-c                    font-bh-type1                    libgpg-error       oclock                                 py-protobuf                r-memoise        the-silver-searcher
allinea-forge             font-bitstream-100dpi            libgtextutils      octave                                 py-psutil                  r-mgcv           thrift
allinea-reports           font-bitstream-75dpi             libhio             octave-splines                         py-ptyprocess              r-mime           tinyxml
ant                       font-bitstream-speedo            libice             octopus                                py-pudb                    r-minqa          tinyxml2
antlr                     font-bitstream-type1             libiconv           ompss                                  py-py                      r-multcomp       tk
ape                       font-cronyx-cyrillic             libint             ompt-openmp                            py-py2cairo                r-munsell        tmux
apex                      font-cursor-misc                 libjpeg-turbo      opari2                                 py-py2neo                  r-mvtnorm        tmuxinator
applewmproto              font-daewoo-misc                 libjson-c          openblas                               py-pychecker               r-ncdf4          transset
appres                    font-dec-misc                    liblbxutil         opencoarrays                           py-pycodestyle             r-networkd3      trapproto
apr                       font-ibm-type1                   libmesh            opencv                                 py-pycparser               r-nlme           tree
...
```

#### Specify Software Version (For Package)

To see more available versions of a package, run `spack versions`.

```console
$ spack versions git
==> Safe versions (already checksummed):
  2.29.0  2.27.0  2.25.0  2.20.1  2.19.1  2.17.1  2.15.1  2.13.0  2.12.1  2.11.1  2.9.3  2.9.1  2.8.4  2.8.2  2.8.0  2.7.1
  2.28.0  2.26.0  2.21.0  2.19.2  2.18.0  2.17.0  2.14.1  2.12.2  2.12.0  2.11.0  2.9.2  2.9.0  2.8.3  2.8.1  2.7.3
==> Remote versions (not yet checksummed):
  2.33.0  2.26.2  2.23.3  2.21.1  2.18.3  2.16.1  2.13.6  2.10.4  2.7.0  2.5.2   2.4.2   2.3.0  2.0.2    1.8.5.2    1.8.3.1
  2.32.0  2.26.1  2.23.2  2.20.5  2.18.2  2.16.0  2.13.5  2.10.3  2.6.7  2.5.1   2.4.1   2.2.3  2.0.1    1.8.5.1    1.8.3
  2.31.1  2.25.5  2.23.1  2.20.4  2.18.1  2.15.4  2.13.4  2.10.2  2.6.6  2.5.0   2.4.0   2.2.2  2.0.0    1.8.5      1.8.2.3
  2.31.0  2.25.4  2.23.0  2.20.3  2.17.6  2.15.3  2.13.3  2.10.1  2.6.5  2.4.12  2.3.10  2.2.1  1.9.5    1.8.4.5    0.7
  2.30.2  2.25.3  2.22.5  2.20.2  2.17.5  2.15.2  2.13.2  2.10.0  2.6.4  2.4.11  2.3.9   2.2.0  1.9.4    1.8.4.4    0.6
  2.30.1  2.25.2  2.22.4  2.20.0  2.17.4  2.15.0  2.13.1  2.9.5   2.6.3  2.4.10  2.3.8   2.1.4  1.9.3    1.8.4.3    0.5
  2.30.0  2.25.1  2.22.3  2.19.6  2.17.3  2.14.6  2.12.5  2.9.4   2.6.2  2.4.9   2.3.7   2.1.3  1.9.2    1.8.4.2    0.04
  2.29.3  2.24.4  2.22.2  2.19.5  2.17.2  2.14.5  2.12.4  2.8.6   2.6.1  2.4.8   2.3.6   2.1.2  1.9.1    1.8.4.1    0.03
  2.29.2  2.24.3  2.22.1  2.19.4  2.16.6  2.14.4  2.12.3  2.8.5   2.6.0  2.4.7   2.3.5   2.1.1  1.9.0    1.8.4.rc0  0.02
  2.29.1  2.24.2  2.22.0  2.19.3  2.16.5  2.14.3  2.11.4  2.7.6   2.5.6  2.4.6   2.3.4   2.1.0  1.8.5.6  1.8.4      0.01
  2.28.1  2.24.1  2.21.4  2.19.0  2.16.4  2.14.2  2.11.3  2.7.5   2.5.5  2.4.5   2.3.3   2.0.5  1.8.5.5  1.8.3.4
  2.27.1  2.24.0  2.21.3  2.18.5  2.16.3  2.14.0  2.11.2  2.7.4   2.5.4  2.4.4   2.3.2   2.0.4  1.8.5.4  1.8.3.3
  2.26.3  2.23.4  2.21.2  2.18.4  2.16.2  2.13.7  2.10.5  2.7.2   2.5.3  2.4.3   2.3.1   2.0.3  1.8.5.3  1.8.3.2
```

## Graph for Software Package

Spack provides the `spack graph` command to display the dependency graph. By default, the command generates an ASCII rendering of a spec’s dependency graph.

```console
$ spack graph git
==> Warning: gcc@4.8.5 cannot build optimized binaries for "zen2". Using best target possible: "x86_64"
o  git
|\
| |\
| | |\
| | | |\
| | | | |\
| | | | | |\
| | | | | | |\
| | | | | | | |\
| | | | | | | | |\
| | | | | | | | | |\
| | | | | | | | | | |\
| | | | | | | | | | | |\
| | | | | | | | | | | | |\
| | | | o | | | | | | | | |  openssh
| |_|_|/| | | | | | | | | |
|/| | |/| | | | | | | | | |
| | | | |\ \ \ \ \ \ \ \ \ \
| | | | | | | | | | | | o | |  curl
| |_|_|_|_|_|_|_|_|_|_|/| | |
|/| | | |_|_|_|_|_|_|_|/| | |
| | | |/| | | | | |_|_|/ / /
| | | | | | | | |/| | | | |
| | | o | | | | | | | | | |  openssl
| |_|/| | | | | | | | | | |
|/| |/ / / / / / / / / / /
| |/| | | | | | | | | | |
| | | | | | | | | o | | |  gettext
| | | | |_|_|_|_|/| | | |
| | | |/| | | | |/| | | |
| | | | | | | | | |\ \ \ \
| | | | | | | | | | |\ \ \ \
| | | | | | | | | | | |\ \ \ \
| | | | | | | | | | | o | | | |  libxml2
| |_|_|_|_|_|_|_|_|_|/| | | | |
|/| | | | | | | | |_|/| | | | |
| | | | | | | | |/| |/| | | | |
| | | | | | | | | |/| | | | | |
o | | | | | | | | | | | | | | |  zlib
 / / / / / / / / / / / / / / /
| | | | | | | | o | | | | | |  xz
| | | | | | | |  / / / / / /
| | | | | | | | o | | | | |  tar
| | | | | | | |/ / / / / /
| | | | | | | | | | | o |  automake
| |_|_|_|_|_|_|_|_|_|/| |
|/| | | | | | | | | | | |
| | | | | | | | | | | |/
| | | | | | | | | | | o  autoconf
| |_|_|_|_|_|_|_|_|_|/|
|/| | | | |_|_|_|_|_|/
| | | | |/| | | | | |
o | | | | | | | | | |  perl
|\ \ \ \ \ \ \ \ \ \ \
o | | | | | | | | | | |  gdbm
o | | | | | | | | | | |  readline
| |_|/ / / / / / / / /
|/| | | | | | | | | |
| | | o | | | | | | |  libedit
| |_|/ / / / / / / /
|/| | | | | | | | |
o | | | | | | | | |  ncurses
| |_|_|_|_|_|/ / /
|/| | | | | | | |
o | | | | | | | |  pkgconf
 / / / / / / / /
| o | | | | | |  pcre2
|  / / / / / /
| | o | | | |  libtool
| |/ / / / /
| o | | | |  m4
| | o | | |  libidn2
| | o | | |  libunistring
| | |/ / /
| o | | |  libsigsegv
|  / / /
| | o |  bzip2
| | o |  diffutils
| |/ /
| o |  libiconv
|  /
| o  expat
| o  libbsd
|
o  berkeley-db
```

### Information for Software Package

To get more information on a particular package from `spack list`, use `spack info`.

```console
$ spack info git
AutotoolsPackage:   git

Description:
    Git is a free and open source distributed version control system
    designed to handle everything from small to very large projects with
    speed and efficiency.

Homepage: http://git-scm.com

Tags:
    None

Preferred version:
    2.29.0    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.29.0.tar.gz

Safe versions:
    2.29.0    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.29.0.tar.gz
    2.28.0    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.28.0.tar.gz
    2.27.0    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.27.0.tar.gz
    2.26.0    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.26.0.tar.gz
    2.25.0    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.25.0.tar.gz
    2.21.0    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.21.0.tar.gz
    2.20.1    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.20.1.tar.gz
    2.19.2    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.19.2.tar.gz
    2.19.1    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.19.1.tar.gz
    2.18.0    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.18.0.tar.gz
    2.17.1    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.17.1.tar.gz
    2.17.0    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.17.0.tar.gz
    2.15.1    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.15.1.tar.gz
    2.14.1    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.14.1.tar.gz
    2.13.0    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.13.0.tar.gz
    2.12.2    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.12.2.tar.gz
    2.12.1    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.12.1.tar.gz
    2.12.0    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.12.0.tar.gz
    2.11.1    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.11.1.tar.gz
    2.11.0    https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.11.0.tar.gz
    2.9.3     https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.3.tar.gz
    2.9.2     https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.2.tar.gz
    2.9.1     https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.1.tar.gz
    2.9.0     https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.0.tar.gz
    2.8.4     https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.8.4.tar.gz
    2.8.3     https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.8.3.tar.gz
    2.8.2     https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.8.2.tar.gz
    2.8.1     https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.8.1.tar.gz
    2.8.0     https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.8.0.tar.gz
    2.7.3     https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.7.3.tar.gz
    2.7.1     https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.7.1.tar.gz

Variants:
    Name [Default]    Allowed values    Description
    ==============    ==============    ===========================================

    tcltk [off]       on, off           Gitk: provide Tcl/Tk in the run environment

Installation Phases:
    autoreconf    configure    build    install

Build Dependencies:
    autoconf  automake  curl  expat  gettext  iconv  libidn2  libtool  m4  openssl  pcre  pcre2  perl  tk  zlib

Link Dependencies:
    curl  expat  gettext  iconv  libidn2  openssl  pcre  pcre2  perl  tk  zlib

Run Dependencies:
    openssh

Virtual Packages:
    None
```

### Install Software Package

`spack install` will install any package shown by `spack list`. For example, to install the latest version of the `git` package, you might type `spack install git` for default version or `spack install git@version` to chose a particular one.

```console
$ spack install git@2.29.0
==> Warning: specifying a "dotkit" module root has no effect [support for "dotkit" has been dropped in v0.13.0]
==> Warning: gcc@4.8.5 cannot build optimized binaries for "zen2". Using best target possible: "x86_64"
==> Installing libsigsegv-2.12-lctnabj6w4bmnyxo7q6ct4wewke2bqin
==> No binary for libsigsegv-2.12-lctnabj6w4bmnyxo7q6ct4wewke2bqin found: installing from source
==> Fetching https://spack-llnl-mirror.s3-us-west-2.amazonaws.com/_source-cache/archive/3a/3ae1af359eebaa4ffc5896a1aee3568c052c99879316a1ab57f8fe1789c390b6.tar.gz
######################################################################## 100.0%
==> libsigsegv: Executing phase: 'autoreconf'
==> libsigsegv: Executing phase: 'configure'
==> libsigsegv: Executing phase: 'build'
==> libsigsegv: Executing phase: 'install'
[+] /home/kru0052/Spack/opt/spack/linux-centos7-x86_64/gcc-4.8.5/libsigsegv-2.12-lctnabj6w4bmnyxo7q6ct4wewke2bqin
==> Installing berkeley-db-18.1.40-bwuaqjex546zw3bimt23bgokfctnt46y
==> No binary for berkeley-db-18.1.40-bwuaqjex546zw3bimt23bgokfctnt46y found: installing from source
==> Fetching https://spack-llnl-mirror.s3-us-west-2.amazonaws.com/_source-cache/archive/0c/0cecb2ef0c67b166de93732769abdeba0555086d51de1090df325e18ee8da9c8.tar.gz
######################################################################## 100.0%
...
...
==> Fetching https://spack-llnl-mirror.s3-us-west-2.amazonaws.com/_source-cache/archive/8f/8f3bf70ddb515674ce2e19572920a39b1be96af12032b77f1dd57898981fb151.tar.gz
################################################################################################################################################################################################################################ 100.0%
==> Moving resource stage
        source : /tmp/kru0052/resource-git-manpages-cabbbb7qozeijgspy2wl3hf6on6f4b4c/spack-src/
        destination : /tmp/kru0052/spack-stage-git-2.29.0-cabbbb7qozeijgspy2wl3hf6on6f4b4c/spack-src/git-manpages
==> git: Executing phase: 'autoreconf'
==> git: Executing phase: 'configure'
==> git: Executing phase: 'build'
==> git: Executing phase: 'install'
[+] /home/kru0052/Spack/opt/spack/linux-centos7-x86_64/gcc-4.8.5/git-2.29.0-cabbbb7qozeijgspy2wl3hf6on6f4b4c
```

!!! warning
    `FTP` on cluster is not allowed, you must edit the source link.

### Edit Rule

```console
$ spack edit git
```

!!! note
    To change the source link (`ftp://` to `http://`), use `spack create URL -f` to regenerate rules.

## Available Spack Module

We know that `spack list` shows you the names of available packages, but how do you figure out which are already installed?

```console
==> 19 installed packages.
-- linux-centos6-x86_64 / gcc@4.4.7 -----------------------------
autoconf@2.69  cmake@3.7.1  expat@2.2.0       git@2.11.0     libsigsegv@2.10  m4@1.4.17    openssl@1.0.2j  perl@5.24.0        tar@1.29  zlib@1.2.10
bzip2@1.0.6    curl@7.50.3  gettext@0.19.8.1  libiconv@1.14  libxml2@2.9.4    ncurses@6.0  pcre@8.41       pkg-config@0.29.1  xz@5.2.2
```

Spack colorizes output.

```console
$ spack find | less -R
-- linux-centos7-x86_64 / gcc@4.8.5 -----------------------------
autoconf@2.69
automake@1.16.2
berkeley-db@18.1.40
bzip2@1.0.8
curl@7.72.0
diffutils@3.7
expat@2.2.10
gdbm@1.18.1
gettext@0.21
git@2.29.0
libbsd@0.10.0
libedit@3.1-20191231
libiconv@1.16
libidn2@2.3.0
libsigsegv@2.12
libtool@2.4.6
libunistring@0.9.10
libxml2@2.9.10
m4@1.4.18
ncurses@6.2
openssh@8.4p1
openssl@1.1.1h
pcre2@10.35
perl@5.32.0
pkgconf@1.7.3
readline@8.0
tar@1.32
xz@5.2.5
zlib@1.2.11
```

`spack find` shows the specs of installed packages. A spec is like a name, but it has a version, compiler, architecture, and build options associated with it. In Spack, you can have many installations of the same package with different specs.

## Load and Unload Module

Neither of these is particularly pretty, easy to remember, or easy to type. Luckily, Spack has its own interface for using modules and dotkits.

```console
$ spack load git
==> This command requires spack's shell integration.

  To initialize spack's shell commands, you must run one of
  the commands below.  Choose the right command for your shell.

  For bash and zsh:
      . ~/.local/easybuild/software/Spack/0.16.2/share/spack/setup-env.sh

  For csh and tcsh:
      setenv SPACK_ROOT ~/.local/easybuild/software/Spack/0.16.2
      source ~/.local/easybuild/software/Spack/0.16.2/share/spack/setup-env.csh
```

### First Usage

```console
$ . ~/.local/easybuild/software/Spack/0.16.2/share/spack/setup-env.sh
```

```console
$ git version 1.7.1
$ spack load git
$ git --version
git version 2.29.0
$ spack unload git
$ git --version
git version 1.7.1
```

## Uninstall Software Package

Spack will ask you either to provide a version number to remove the ambiguity or use the `--all` option to uninstall all of the matching packages.

You may force uninstall a package with the `--force` option.

```console
$ spack uninstall git
==> The following packages will be uninstalled :

-- linux-centos7-x86_64 / gcc@4.4.7 -----------------------------
xmh3hmb git@2.29.0%gcc


==> Do you want to proceed ? [y/n]
y
==> Successfully uninstalled git@2.29.00%gcc@4.8.5 arch=linux-centos6-x86_64 -xmh3hmb

```

[a]: https://spack.readthedocs.io/en/latest/
