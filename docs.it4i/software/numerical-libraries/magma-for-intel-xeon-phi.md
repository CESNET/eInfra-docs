# MAGMA for Intel Xeon Phi

A next generation dense algebra library for heterogeneous systems with accelerators.

## Compiling and Linking With MAGMA

To compile and link code with the MAGMA library, load the following module:

```console
$ ml magma/1.3.0-mic
```

To make compilation more user-friendly, the module also sets these two environment variables:

* `MAGMA_INC` - contains paths to the MAGMA header files (to be used for compilation step).
* `MAGMA_LIBS` - contains paths to the MAGMA libraries (to be used for linking step).

Compilation example:

```console
$ icc -mkl -O3 -DHAVE_MIC -DADD_ -Wall $MAGMA_INC -c testing_dgetrf_mic.cpp -o testing_dgetrf_mic.o
$ icc -mkl -O3 -DHAVE_MIC -DADD_ -Wall -fPIC -Xlinker -zmuldefs -Wall -DNOCHANGE -DHOST testing_dgetrf_mic.o  -o testing_dgetrf_mic $MAGMA_LIBS
```

### Running MAGMA Code

MAGMA implementation for Intel MIC requires a MAGMA server running on accelerator prior to executing the user application. To start or stop the server, use the following scripts:

To start MAGMA server use:

```console
$MAGMAROOT/start_magma_server
```

To stop the server use:

```console
$MAGMAROOT/stop_magma_server
```

For more information about how the MAGMA server is started, see the following script:

```console
$MAGMAROOT/launch_anselm_from_mic.sh
```

To test if the MAGMA server runs properly, we can run one of the examples that are part of the MAGMA installation:

```console
[user@cn204 ~]$ $MAGMAROOT/testing/testing_dgetrf_mic
[user@cn204 ~]$ export OMP_NUM_THREADS=16
[lriha@cn204 ~]$ $MAGMAROOT/testing/testing_dgetrf_mic
    Usage: /apps/libs/magma-mic/magmamic-1.3.0/testing/testing_dgetrf_mic [options] [-h|--help]

      M     N     CPU GFlop/s (sec)   MAGMA GFlop/s (sec)   ||PA-LU||/(||A||*N)
    =========================================================================
     1088 1088     ---   (  ---  )     13.93 (   0.06)     ---
     2112 2112     ---   (  ---  )     77.85 (   0.08)     ---
     3136 3136     ---   (  ---  )    183.21 (   0.11)     ---
     4160 4160     ---   (  ---  )    227.52 (   0.21)     ---
     5184 5184     ---   (  ---  )    258.61 (   0.36)     ---
     6208 6208     ---   (  ---  )    333.12 (   0.48)     ---
     7232 7232     ---   (  ---  )    416.52 (   0.61)     ---
     8256 8256     ---   (  ---  )    446.97 (   0.84)     ---
     9280 9280     ---   (  ---  )    461.15 (   1.16)     ---
    10304 10304     ---   (  ---  )    500.70 (   1.46)     ---
```

!!! hint
    MAGMA contains several benchmarks and examples in `$MAGMAROOT/testing/`.

!!! note
    MAGMA relies on the performance of all CPU cores as well as on the performance of the accelerator. Therefore on Anselm, the number of CPU OpenMP threads has to be set to 16 with `export OMP_NUM_THREADS=16`.

See more details at [MAGMA home page][a].

## References

[1] [MAGMA MIC: Linear Algebra Library for Intel Xeon Phi Coprocessors][1], Jack Dongarra et. al

[1]: http://icl.utk.edu/projectsfiles/magma/pubs/24-MAGMA_MIC_03.pdf

[a]: http://icl.cs.utk.edu/magma/
