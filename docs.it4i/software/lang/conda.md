# Conda (Anaconda)

Conda is an open source package management system and environment management system that runs on Windows, macOS, and Linux. Conda quickly installs, runs, and updates packages and their dependencies. Conda easily creates, saves, loads, and switches between environments on your local computer. It was created for Python programs, but it can package and distribute software for any language.

Conda as a package manager helps you find and install packages. If you need a package that requires a different version of Python, you do not need to switch to a different environment manager, because Conda is also an environment manager. With just a few commands, you can set up a completely separate environment to run that different version of Python, while continuing to run your usual version of Python in your normal environment.

Conda treats Python the same as any other package, so it is easy to manage and update multiple installations.
Anaconda supports Python 2.7, 3.4, 3.5, and 3.6. Default Python is 2.7 or 3.6, depending on which installer you used:

* For the installers “Anaconda” and “Miniconda,” the default is 2.7.
* For the installers “Anaconda3” or “Miniconda3,” the default is 3.6.

## Conda on the IT4Innovations Clusters

On the clusters, we have the Anaconda2 and Anaconda3 software installed. How to use these modules is shown below.

!!! note
    Use the `ml av conda` command to get up-to-date versions of the modules.

```console
$ ml av conda

------------- /apps/modules/lang ---------------------------------
Anaconda2/4.4.0 Anaconda3/4.4.0
```

## Anaconda2

Default Python is 2.7.

### First Usage Module Anaconda2

```console
$ ml Anaconda2/4.4.0
$ python --version
Python 2.7.13 :: Anaconda 4.4.0 (64-bit)
$ conda install numpy
Fetching package metadata .........
Solving package specifications: .

Package plan for installation in environment /apps/all/Anaconda2/4.4.0:

The following packages will be UPDATED:

anaconda: 4.4.0-np112py27_0 --> custom-py27_0
...
...
...
CondaIOError: Missing write permissions in: /apps/all/Anaconda2/4.4.0
#
# You don't appear to have the necessary permissions to install packages
# into the install area '/apps/all/Anaconda2/4.4.0'.
# However you can clone this environment into your home directory and
# then make changes to it.
# This may be done using the command:
#
# $ conda create -n my_root --clone="/apps/all/Anaconda2/4.4.0"
$
$ conda create -n anaconda2 --clone="/apps/all/Anaconda2/4.4.0"
Source: /apps/all/Anaconda2/4.4.0
Destination: /home/svi47/.conda/envs/anaconda2
The following packages cannot be cloned out of the root environment:
- conda-4.3.21-py27_0
- conda-env-2.6.0-0
Packages: 213
...
...
...
#
# To activate this environment, use:
# > source activate anaconda2
#
# To deactivate this en
```

### Usage Module Anaconda2

```console
$ ml Anaconda2/4.4.0
$ source activate anaconda2
(anaconda2) ~]$
```

## Anaconda3

Default Python is 3.6.

### First Usage Module Anaconda3

```console
$ ml Anaconda3/4.4.0
$ python --version
Python 3.6.1 :: Anaconda 4.4.0 (64-bit)
$ conda install numpy
Fetching package metadata .........
Solving package specifications: .

Package plan for installation in environment /apps/all/Anaconda3/4.4.0:

The following packages will be UPDATED:

anaconda: 4.4.0-np112py36_0 --> custom-py36_0
...
...
...
CondaIOError: Missing write permissions in: /apps/all/Anaconda3/4.4.0
#
# You don't appear to have the necessary permissions to install packages
# into the install area '/apps/all/Anaconda3/4.4.0'.
# However you can clone this environment into your home directory and
# then make changes to it.
# This may be done using the command:
#
# $ conda create -n my_root --clone="/apps/all/Anaconda3/4.4.0"
$
$ conda create -n anaconda3 --clone="/apps/all/Anaconda3/4.4.0"
Source: /apps/all/Anaconda3/4.4.0
Destination: /home/svi47/.conda/envs/anaconda3
The following packages cannot be cloned out of the root environment:
- conda-4.3.21-py36_0
- conda-env-2.6.0-0
Packages: 200
Files: 6
...
...
...
#
# To activate this environment, use:
# > source activate anaconda3
#
# To deactivate this environment, use:
# > source deactivate anaconda3
#
$ source activate anaconda3
(anaconda3) ~]$
```

### Usage Module Anaconda3

```console
$ ml Anaconda3/4.4.0
$ source activate anaconda3
(anaconda3) ~]$
```
