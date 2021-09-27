# Python

Python is a widely used high-level programming language for general-purpose programming, created by Guido van Rossum and first released in 1991. An interpreted language, Python has a design philosophy that emphasizes code readability (notably using whitespace indentation to delimit code blocks rather than curly brackets or keywords), and a syntax that allows programmers to express concepts in fewer lines of code than might be used in languages such as C++ or Java. The language provides constructs intended to enable writing clear programs on both a small and large scale.

Python features a dynamic type system and automatic memory management and supports multiple programming paradigms, including object-oriented, imperative, functional programming, and procedural styles. It has a large and comprehensive standard library.

* [Documentation for Python 3.X][a]
* [PEP 8 -- Style Guide for Python Code][c]
* [Get into Python -- Tutorial][d]

## Python on the IT4Innovations Clusters

On the clusters, we have the Python 3.X software installed. How to use these modules is shown below.

!!! note
    Use the `ml av python/` command to get up-to-date versions of the modules.

!!! warn
    Python 2.7 is not supported - [EOL][b] January 1st, 2020.

```console
$ ml av python/

------------------------------------------------------ /apps/modules/lang -------------------------------------------------------
   Python/3.8.2-GCCcore-9.3.0    Python/3.8.6-GCCcore-10.2.0    Python/3.9.5-GCCcore-10.3.0 (D)

  Where:
   D:  Default Module

  If you need software that is not listed, request it at support@it4i.cz.
```

## Python 3.X

Python 3.0 (a.k.a. "Python 3000" or "Py3k") is a new version of the language that is incompatible with the 2.x line of releases. The language is mostly the same, but many details, especially how built-in objects like dictionaries and strings work, have changed considerably, and many deprecated features have been removed. In addition, the standard library has been reorganized in a few prominent places.

```console
$ ml av python3/

------------------------------------------------------ /apps/modules/lang -------------------------------------------------------
   Python/3.8.2-GCCcore-9.3.0    Python/3.8.6-GCCcore-10.2.0    Python/3.9.5-GCCcore-10.3.0 (D)

  Where:
   D:  Default Module

  If you need software that is not listed, request it at support@it4i.cz.

```

### Used Module Python/3.x

```console
$  python --version
Python 2.7.5
$ ml Python/3.8.6-GCCcore-10.2.0
$ python --version
Python 3.8.6
```

### Packages in Python/3.x

```console
$ pip3 list
Package                       Version
----------------------------- ----------
alabaster                     0.7.12
appdirs                       1.4.4
ase                           3.22.0
asn1crypto                    1.4.0
atomicwrites                  1.4.0
attrs                         20.2.0
Babel                         2.8.0
...
...
$ pip3 list | wc -l
138
```

### How to Install New Package to Python/3.x

```console
$ ml ml Python/3.8.6-GCCcore-10.2.0
$ python --version
Python 3.8.6
$ pip3 install pandas --user
Collecting pandas
  Downloading pandas-1.3.3-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (11.5 MB)
     |████████████████████████████████| 11.5 MB 4.8 MB/s
...
Installing collected packages: pandas
Successfully installed pandas-1.3.3
```

### How to Update Package in Python/3.x?

```console
$ pip3 install setuptools --upgrade --user
Collecting setuptools
  Downloading setuptools-58.0.4-py3-none-any.whl (816 kB)
     |███████████████████████████████▎| 798 kB 5.4 MB/s eta 0:00:01
     |███████████████████████████████▊| 808 kB 5.4 MB/s eta 0:00:01
     |████████████████████████████████| 816 kB 5.4 MB/s
Installing collected packages: setuptools
Successfully installed setuptools-58.0.4
```

[a]: https://docs.python.org/3/
[b]: https://www.python.org/doc/sunset-python-2/
[c]: https://www.python.org/dev/peps/pep-0008/
[d]: https://jobtensor.com/Tutorial/Python/en/Introduction
