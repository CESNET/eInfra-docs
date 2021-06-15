# Spack

Spack is a package manager for supercomputers, Linux, and macOS. It makes installing scientific software easy. With Spack, you can build a package with multiple versions, configurations, platforms, and compilers, and all of these builds can coexist on the same machine.

For more information, see Spack's [documentation][a].

## Spack on IT4Innovations Clusters

```console

$ ml av Spack

---------------------- /apps/modules/devel ------------------------------
   Spack/default

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
== processing EasyBuild easyconfig /apps/easybuild/easyconfigs-it4i/s/Spack/Spack-0.10.0.eb
== building and installing Spack/0.10.0...
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
== Results of the build can be found in the log file(s) ~/.local/easybuild/software/Spack/0.10.0/easybuild/easybuild-Spack-0.10.0-20170707.122650.log
== Build succeeded for 1 out of 1
== Temporary log file(s) /tmp/eb-wLh1RT/easybuild-54vEn3.log* have been removed.
== Temporary directory /tmp/eb-wLh1RT has been removed.
== Create folder ~/Spack

The following have been reloaded with a version change:
  1) Spack/default => Spack/0.10.0

$ spack --version
0.10.0
```

## Usage Module Spack/Default

```console
$ ml Spack

The following have been reloaded with a version change:
  1) Spack/default => Spack/0.10.0

$ spack --version
0.10.0
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
  2.11.0  2.9.3  2.9.2  2.9.1  2.9.0  2.8.4  2.8.3  2.8.2  2.8.1  2.8.0  2.7.3  2.7.1
==> Remote versions (not yet checksummed):
  Found no versions for git
```

## Graph for Software Package

Spack provides the `spack graph` command to display the dependency graph. By default, the command generates an ASCII rendering of a spec’s dependency graph.

```console
$ spack graph git
o  git
|\
| |\
| | |\
| | | |\
| | | | |\
| | | | | |\
| | | | | | |\
| | | | | | | |\
| | | | | | | o |  curl
| |_|_|_|_|_|/| |
|/| | | |_|_|/ /
| | | |/| | | |
| | | o | | | |  openssl
| |_|/ / / / /
|/| | | | | |
| | | | o | |  gettext
| | | | |\ \ \
| | | | | |\ \ \
| | | | | | |\ \ \
| | | | | | | |\ \ \
| | | | | | | o | | |  libxml2
| |_|_|_|_|_|/| | | |
|/| | | | |_|/| | | |
| | | | |/| | | | | |
o | | | | | | | | | |  zlib
 / / / / / / / / / /
| | | o | | | | | |  xz
| | |  / / / / / /
| | | o | | | | |  tar
| | |  / / / / /
| | | | o | | |  pkg-config
| | | |  / / /
o | | | | | |  perl
 / / / / / /
o | | | | |  pcre
 / / / / /
| o | | |  ncurses
|  / / /
| | | o  autoconf
| | | o  m4
| | | o  libsigsegv
| | |
o | |  libiconv
 / /
| o  expat
|
o  bzip2
```

### Information for Software Package

To get more information on a particular package from `spack list`, use `spack info`.

```console
$ spack info git
Package:    git
Homepage:   http://git-scm.com

Safe versions:
    2.11.0    https://github.com/git/git/tarball/v2.11.0
    2.9.3     https://github.com/git/git/tarball/v2.9.3
    2.9.2     https://github.com/git/git/tarball/v2.9.2
    2.9.1     https://github.com/git/git/tarball/v2.9.1
    2.9.0     https://github.com/git/git/tarball/v2.9.0
    2.8.4     https://github.com/git/git/tarball/v2.8.4
    2.8.3     https://github.com/git/git/tarball/v2.8.3
    2.8.2     https://github.com/git/git/tarball/v2.8.2
    2.8.1     https://github.com/git/git/tarball/v2.8.1
    2.8.0     https://github.com/git/git/tarball/v2.8.0
    2.7.3     https://github.com/git/git/tarball/v2.7.3
    2.7.1     https://github.com/git/git/tarball/v2.7.1

Variants:
    None

Installation Phases:
    install

Build Dependencies:
    autoconf  curl  expat  gettext  libiconv  openssl  pcre  perl  zlib

Link Dependencies:
    curl  expat  gettext  libiconv  openssl  pcre  perl  zlib

Run Dependencies:
    None

Virtual Packages:
    None

Description:
    Git is a free and open source distributed version control system
    designed to handle everything from small to very large projects with
    speed and efficiency.
```

### Install Software Package

`spack install` will install any package shown by `spack list`. For example, to install the latest version of the `git` package, you might type `spack install git` for default version or `spack install git@version` to chose a particular one.

```console
$ spack install git@2.11.0
==> Installing git
==> Installing pcre
==> Fetching http://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.39.tar.bz2
...
```

!!! warning
    `FTP` on cluster is not allowed, you must edit the source link.

### Edit Rule

```console
$ spack edit git
```

!!! note
    To change the source link (`ftp://` to `http://`), use `spack create URL -f` to regenerate rules.

#### **Example**

```console
$ spack install git
==> Installing git
==> Installing pcre
==> Fetching ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.39.tar.bz2
curl: (7) couldn't connect to host
==> Fetching from ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.39.tar.bz2 failed.
==> Error: FetchError: All fetchers failed for pcre-8.39-bm3lumpbghly2l7bkjsi4n2l3jyam6ax
...

$ spack create http://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.39.tar.bz2 -f
==> This looks like a URL for pcre
==> Found 2 versions of pcre:

  8.41  http://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.41.tar.bz2
  8.40  http://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.bz2

How many would you like to checksum? (default is 1, q to abort) 1
==> Downloading...
==> Fetching http://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.41.tar.bz2
######################################################################## 100,0%
==> Checksummed 1 version of pcre
==> This package looks like it uses the cmake build system
==> Created template for pcre package
==> Created package file: ~/.local/easybuild/software/Spack/0.10.0/var/spack/repos/builtin/packages/pcre/package.py
$
$ spack install git
==> Installing git
==> Installing pcre
==> Installing cmake
==> Installing ncurses
==> Fetching http://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz
######################################################################## 100,0%
...
```

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
      . ~/.local/easybuild/software/Spack/0.10.0/share/spack/setup-env.sh

  For csh and tcsh:
      setenv SPACK_ROOT ~/.local/easybuild/software/Spack/0.10.0
      source ~/.local/easybuild/software/Spack/0.10.0/share/spack/setup-env.csh
```

### First Usage

```console
$ . ~/.local/easybuild/software/Spack/0.10.0/share/spack/setup-env.sh
```

```console
$ git version 1.7.1
$ spack load git
$ git --version
git version 2.11.0
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

-- linux-centos6-x86_64 / gcc@4.4.7 -----------------------------
xmh3hmb git@2.11.0%gcc


==> Do you want to proceed ? [y/n]
y
==> Successfully uninstalled git@2.11.0%gcc@4.4.7 arch=linux-centos6-x86_64 -xmh3hmb

```

[a]: https://spack.readthedocs.io/en/latest/
