# ISV Licenses

## Guide to Managing Independent Software Vendor Licenses

On IT4I clusters, there are also installed commercial software applications, also known as ISV (Independent Software Vendor), which are subjects to licensing. The licenses are limited and their usage may be restricted only to some users or user groups.

Currently, Flex License Manager based licensing is supported on the cluster for products ANSYS, Comsol, and MATLAB. More information about the applications can be found in the general software section.

If an ISV application was purchased for educational (research) purposes and also for commercial purposes, then there are always two separate versions maintained and suffix "edu" is used in the name of the non-commercial version.

## Overview of the Licenses Usage

!!! note
    The overview is generated every minute and is accessible from the web or command line interface.

### Web Interface

For each license, there is a [table][a] providing the information about the name, number of available (purchased/licensed), number of used and number of free license features.

### Command Line

To check license usage via command line, use the `LicenseChecker` module with the `lmstat` utility:

```console
ml LicenseChecker/1.0
```

For example, to check usage of Ansys licenses, use:

```console
lmstat -a -c 1055@license.it4i.cz
```

or for a specific module (e.g. HPC):

```console
lmstat -f aa_r_hpc -c 1055@license.it4i.cz
```

To list all Ansys modules, use:

```console
lmstat -i -c 1055@license.it4i.cz
```

For other applications' licenses, change the port number in the command according to the **Port** column in [this list][b].

## License Aware Job Scheduling

Barbora provides license aware job scheduling.

Selected licenses are accounted and checked by the scheduler of PBS Pro. If you ask for certain licenses, the scheduler won't start the job until the asked licenses are free (available). This prevents batch jobs crashes due to unavailability of the needed licenses.

The general format of the name is `license__APP__FEATURE`.

Supported application license features:

| Application | Feature                    | PBS Pro resource name                           |
| ----------- | -------------------------- | ----------------------------------------------- |
| ansys       | aa_r_hpc                   | license__ansys__aa_r_hpc                        |
| matlab-edu  | MATLAB                     | license__matlab-edu__MATLAB                     |
| matlab-com  | MATLAB                     | license__matlab-com__MATLAB                     |

Do not hesitate to ask IT4I support for support of additional license features you want to use in your jobs.

!!! warning
    Resource names in PBS Pro are case sensitive.

### Example of qsub Statement

Run an interactive PBS job with 1 Matlab EDU license:

```console
$ qsub -I -q qprod -A PROJECT_ID -l select=2 -l license__matlab-edu__MATLAB=1
```

The license is used and accounted only with the real usage of the product. So in this example, the general Matlab is used after Matlab is run by the user and not at the time, when the shell of the interactive job is started. In addition, the Distributed Computing licenses are used at the time, when the user uses the distributed parallel computation in Matlab (e. g. issues pmode start, matlabpool, etc.).

[1]: #Licence

[a]: https://extranet.it4i.cz/rsweb/barbora/licenses
[b]: http://licelin.it4i.cz/list/
