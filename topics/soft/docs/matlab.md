# MATLAB

!!!note ""

    MATLAB is a high-level language and interactive environment that enables you to perform computationally intensive tasks faster than with traditional programming languages such as C, C++, and Fortran.

## Availability

=== "IT4I"
    [Available][1]; for the list of versions, run `ml av matlab`.

=== "Source 2"
    Available here, as well.

=== "Source 3"
    Not available here :(

## License

There are always two variants of the release:

* Non-commercial or so-called EDU variant, which can be used for common research and educational purposes.
* Commercial or so-called COM variant, which can used also for commercial activities. Commercial licenses are much more expensive, so usually the commercial license has only a subset of features compared to the available EDU license.

!!! info
    Version 2021a is e-infra license, without cluster licenses - only basic functionality.

## Usage

If you need to use the MATLAB GUI to prepare your MATLAB programs, you can use MATLAB directly on the login nodes. However, for all computations, use MATLAB on the compute nodes via PBS Pro scheduler.

If you require the MATLAB GUI, follow the general information about running graphical applications.

MATLAB GUI is quite slow using the X forwarding built in the PBS (`qsub -X`), so using X11 display redirection either via SSH or directly by `xauth` (see the GUI Applications on Compute Nodes over VNC section) is recommended.

To run MATLAB with GUI, use:

```console
$ matlab
```

To run MATLAB in text mode, without the MATLAB Desktop GUI environment, use:

```console
$ matlab -nodesktop -nosplash
```

plots, images, etc. will be still available.

### Examples

### Parallel MATLAB Batch Job in Local Mode

To run MATLAB in a batch mode, write a MATLAB script, then write a bash jobscript and execute via the `qsub` command. By default, MATLAB will execute one MATLAB worker instance per allocated core.

```bash
#!/bin/bash
#PBS -A PROJECT ID
#PBS -q qprod
#PBS -l select=1:ncpus=128:mpiprocs=128:ompthreads=1

# change to shared scratch directory
DIR=/scratch/project/PROJECT_ID/$PBS_JOBID
mkdir -p "$DIR"
cd "$DIR" || exit

# copy input file to scratch
cp $PBS_O_WORKDIR/matlabcode.m .

# load modules
ml MATLAB/R2015b

# execute the calculation
matlab -nodisplay -r matlabcode > output.out

# copy output file to home
cp output.out $PBS_O_WORKDIR/.

# remove scratch folder
rm -rf $SCR

# exit
exit
```

This script may be submitted directly to the PBS workload manager via the `qsub` command.  The inputs and the MATLAB script are in the matlabcode.m file, outputs in the output.out file. Note the missing .m extension in the `matlab -r matlabcodefile` call, **the .m must not be included**.  Note that the **shared /scratch must be used**. Further, it is **important to include the `quit`** statement at the end of the matlabcode.m script.

Submit the jobscript using `qsub`:

```console
$ qsub ./jobscript
```

## Resources

[MATLAB official page][1]

[MATLAB documentation][2]

[1]: https://www.mathworks.com/products/matlab.html
[2]: https://www.mathworks.com/help/matlab/
