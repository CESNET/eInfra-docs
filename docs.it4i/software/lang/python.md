# Python

Python is a widely used high-level programming language for general-purpose programming, created by Guido van Rossum and first released in 1991. An interpreted language, Python has a design philosophy that emphasizes code readability (notably using whitespace indentation to delimit code blocks rather than curly brackets or keywords), and a syntax that allows programmers to express concepts in fewer lines of code than might be used in languages such as C++ or Java. The language provides constructs intended to enable writing clear programs on both a small and large scale.

Python features a dynamic type system and automatic memory management and supports multiple programming paradigms, including object-oriented, imperative, functional programming, and procedural styles. It has a large and comprehensive standard library.

* [Documentation for Python 3.X][a]
* [Documentation for Python 2.X][b]
* [PEP 8 -- Style Guide for Python Code][c]

## Python on the IT4Innovations Clusters

On the clusters, we have the Python 2.X and Python 3.X software installed. How to use these modules is shown below.

!!! note
    Use the `ml av python/` command to get up-to-date versions of the modules.

```console
$ ml av python/

-------------------------- /apps/modules/lang --------------------------
   Python/2.7.8-intel-2015b       Python/2.7.9-gompi-2015e      Python/2.7.10-GCC-4.9.3-2.25-bare    Python/2.7.11-intel-2016a      Python/3.4.3-intel-2015b      Python/3.5.2-intel-2017.00
   Python/2.7.8-intel-2016.01     Python/2.7.9-ictce-7.3.5      Python/2.7.10-GNU-4.9.3-2.25-bare    Python/2.7.11-intel-2017a      Python/3.5.1-intel-2016.01    Python/3.5.2
   Python/2.7.9-foss-2015b        Python/2.7.9-intel-2015b      Python/2.7.11-foss-2016a             Python/2.7.11-intel-2017.00    Python/3.5.1-intel-2017.00    Python/3.6.1
   Python/2.7.9-foss-2015g        Python/2.7.9-intel-2016.01    Python/2.7.11-GCC-4.9.3-2.25-bare    Python/2.7.13-base             Python/3.5.1                  Python/3.6.2-base          (D)
   Python/2.7.9-GNU-5.1.0-2.25    Python/2.7.9                  Python/2.7.11-intel-2015b            Python/2.7.13                  Python/3.5.2-foss-2016a

-------------------------- /apps/modules/math ---------------------------
   ScientificPython/2.9.4-intel-2015b-Python-2.7.9    ScientificPython/2.9.4-intel-2015b-Python-2.7.11    ScientificPython/2.9.4-intel-2016.01-Python-2.7.9 (D)

  Where:
   D:  Default Module

  If you need software that is not listed, request it at support@it4i.cz.
```

## Python 2.X

Python 2.7 is scheduled to be the last major version in the 2.x series before it moves into an extended maintenance period. This release contains many of the features that were first released in Python 3.1.

```console
$ ml av python/2

----------------------------------------------------------------------------------------------- /apps/modules/lang ------------------------------------------------------------------------------------------------
   Python/2.7.8-intel-2015b      Python/2.7.9-GNU-5.1.0-2.25    Python/2.7.9-intel-2016.01           Python/2.7.11-foss-2016a             Python/2.7.11-intel-2017a
   Python/2.7.8-intel-2016.01    Python/2.7.9-gompi-2015e       Python/2.7.9                         Python/2.7.11-GCC-4.9.3-2.25-bare    Python/2.7.11-intel-2017.00
   Python/2.7.9-foss-2015b       Python/2.7.9-ictce-7.3.5       Python/2.7.10-GCC-4.9.3-2.25-bare    Python/2.7.11-intel-2015b            Python/2.7.13-base
   Python/2.7.9-foss-2015g       Python/2.7.9-intel-2015b       Python/2.7.10-GNU-4.9.3-2.25-bare    Python/2.7.11-intel-2016a            Python/2.7.13

----------------------------------------------------------------------------------------------- /apps/modules/math ------------------------------------------------------------------------------------------------
   ScientificPython/2.9.4-intel-2015b-Python-2.7.9    ScientificPython/2.9.4-intel-2015b-Python-2.7.11    ScientificPython/2.9.4-intel-2016.01-Python-2.7.9 (D)

  Where:
   D:  Default Module

  If you need software that is not listed, request it at support@it4i.cz.
```

### Used Module Python/2.x

```console
$ python --version
Python 2.6.6
$ ml Python/2.7.13
$ python --version
Python 2.7.1
```

### Packages in Python/2.x

```console
$ pip list
appdirs (1.4.3)
asn1crypto (0.22.0)
backports-abc (0.5)
backports.shutil-get-terminal-size (1.0.0)
backports.ssl-match-hostname (3.5.0.1)
BeautifulSoup (3.2.1)
beautifulsoup4 (4.5.3)
...
```

### How to Install New Package to Python/2.x?

```console
$ ml Python/2.7.13
$ python --version
$ pip install wheel --user
Collecting wheel
  Downloading wheel-0.30.0-py2.py3-none-any.whl (49kB)
    100% |████████████████████████████████| 51kB 835kB/s
Installing collected packages: wheel
Successfully installed wheel-0.30.0
```

### How to Update Package in Python/2.x?

```console
$ ml Python/2.7.13
$ python --version
$ pip install scipy --upgrade --user
Collecting scipy
  Downloading scipy-0.19.1-cp27-cp27mu-manylinux1_x86_64.whl (45.0MB)
    100% |████████████████████████████████| 45.0MB 5.8kB/s
Requirement already up-to-date: numpy>=1.8.2 in /apps/all/Python/2.7.13/lib/python2.7/site-packages (from scipy)
Installing collected packages: scipy
Successfully installed scipy-0.19.1
```

## Python 3.X

Python 3.0 (a.k.a. "Python 3000" or "Py3k") is a new version of the language that is incompatible with the 2.x line of releases. The language is mostly the same, but many details, especially how built-in objects like dictionaries and strings work, have changed considerably, and many deprecated features have been removed. In addition, the standard library has been reorganized in a few prominent places.

```console
$ ml av python/3

---------------------- /apps/modules/lang ----------------------
   Python/3.4.3-intel-2015b      Python/3.5.1-intel-2017.00    Python/3.5.2-foss-2016a       Python/3.5.2    Python/3.6.2-base (D)
   Python/3.5.1-intel-2016.01    Python/3.5.1                  Python/3.5.2-intel-2017.00    Python/3.6.1

  Where:
   D:  Default Module

  If you need software that is not listed, request it at support@it4i.cz.

```

### Used Module Python/3.x

```console
$ python --version
Python 2.6.6
$ ml Python/3.6.2-base
$ python --version
Python 3.6.2
```

### Packages in Python/3.x

```console
$ pip3 list
nose (1.3.7)
pip (8.0.2)
setuptools (20.1.1)
```

### How to Install New Package to Python/3.x

```console
$ ml Python/3.6.2-base
$ python --version
Python 3.6.2
$ pip3 install pandas --user
Collecting pandas
  Downloading pandas-0.20.3.tar.gz (10.4MB)
    100% |████████████████████████████████| 10.4MB 42kB/s
Collecting python-dateutil>=2 (from pandas)
  Downloading python_dateutil-2.6.1-py2.py3-none-any.whl (194kB)
    100% |████████████████████████████████| 196kB 1.3MB/s
Collecting pytz>=2011k (from pandas)
  Downloading pytz-2017.2-py2.py3-none-any.whl (484kB)
    100% |████████████████████████████████| 487kB 757kB/s
Collecting numpy>=1.7.0 (from pandas)
  Using cached numpy-1.13.1.zip
Collecting six>=1.5 (from python-dateutil>=2->pandas)
  Downloading six-1.11.0-py2.py3-none-any.whl
Building wheels for collected packages: pandas, numpy
  Running setup.py bdist_wheel for pandas ... done
  Stored in directory: /home/kru0052/.cache/pip/wheels/dd/17/6c/a1c7e8d855f3a700b21256329fd396d105b533c5ed3e20c5e9
  Running setup.py bdist_wheel for numpy ... done
  Stored in directory: /home/kru0052/.cache/pip/wheels/94/44/90/4ce81547e3e5f4398b1601d0051e828b8160f8d3f3dd5a0c8c
Successfully built pandas numpy
Installing collected packages: six, python-dateutil, pytz, numpy, pandas
Successfully installed numpy-1.13.1 pandas-0.20.3 python-dateutil-2.6.1 pytz-2017.2 six-1.11.0
```

### How to Update Package in Python/3.x?

```console
$ pip3 install scipy --upgrade --user
Collecting scipy
  Downloading scipy-0.19.1-cp27-cp27mu-manylinux1_x86_64.whl (45.0MB)
    100% |████████████████████████████████| 45.0MB 5.8kB/s
Requirement already up-to-date: numpy>=1.8.2 in /apps/all/Python/3.6.2/lib/python3.6/site-packages (from scipy)
Installing collected packages: scipy
Successfully installed scipy-0.19.1
```

[a]: https://docs.python.org/3/
[b]: https://docs.python.org/2/
[c]: https://www.python.org/dev/peps/pep-0008/
