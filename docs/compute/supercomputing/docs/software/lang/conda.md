# Conda (Anaconda)

Conda is an open source package management system and environment management system that runs on Windows, macOS, and Linux. Conda quickly installs, runs, and updates packages and their dependencies. Conda easily creates, saves, loads, and switches between environments on your local computer. It was created for Python programs, but it can package and distribute software for any language.

Conda as a package manager helps you find and install packages. If you need a package that requires a different version of Python, you do not need to switch to a different environment manager, because Conda is also an environment manager. With just a few commands, you can set up a completely separate environment to run that different version of Python, while continuing to run your usual version of Python in your normal environment.

Conda treats Python the same as any other package, so it is easy to manage and update multiple installations.
Anaconda supports Python 3.X. Default Python is 3.8, depending on which installer you used.

## Conda on the IT4Innovations Clusters

On the clusters, we have the Anaconda3 software installed. How to use these modules is shown below.

!!! note
    Use the `ml av conda` command to get up-to-date versions of the modules.

```console
$ ml av conda

------------- /apps/modules/lang ---------------------------------
Anaconda3/2021.05
```

## Anaconda3

Default Python is 3.8.8.

### First Usage Module Anaconda3

```console
$ ml Anaconda3/2021.05
$ python --version
Python 3.8.8
$ conda install numpy
Fetching package metadata .........
Solving package specifications: .

Package plan for installation in environment /apps/all/Anaconda3/2021.05:

The following packages will be UPDATED:

conda                               4.10.1-py38h06a4308_1 --> 4.10.3-py38h06a4308_0
...
...
...
CondaIOError: Missing write permissions in: /apps/all/Anaconda3/2021.05
#
# You don't appear to have the necessary permissions to install packages
# into the install area '/apps/all/Anaconda3/2021.05'.
# However you can clone this environment into your home directory and
# then make changes to it.
# This may be done using the command:
#
# $ conda create -n my_root --clone="/apps/all/Anaconda3/2021.05"
$
$ conda create -n anaconda3 --clone="/apps/all/Anaconda3/2021.05"
Source: /apps/all/Anaconda3/2021.05
Destination: /home/user/.conda/envs/anaconda3
The following packages cannot be cloned out of the root environment:
 - defaults/linux-64::conda-env-2.6.0-1
 - defaults/linux-64::conda-4.10.3-py38h06a4308_0
 - defaults/noarch::conda-token-0.3.0-pyhd3eb1b0_0
 - defaults/linux-64::anaconda-navigator-2.0.3-py38_0
 - defaults/linux-64::conda-build-3.21.4-py38h06a4308_0
Packages: 339
Files: 50986
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
$ ml Anaconda3/2021.05
$ source activate anaconda3
(anaconda3) ~]$
```
