# MATLAB

!!!note ""

    MATLAB is a high-level language and interactive environment that enables you to perform computationally intensive tasks faster than with traditional programming languages such as C, C++, and Fortran.

## Availability

=== "MetaCentrum"
    ## Licences
    
    There is a permanent licence type `College` (for UNIX and MS Windows) available
    to all the national grid infrastructure MetaCentrum users as well as to all students and employees of:

    * Masaryk university in Brno
    * University of West Bohemia in Pilsen
    * Czech Technical University in Prague
    
    MATLAB can be installed freely on any computer at these universities
    and once running it takes licences from a pool of available licences.
    The licences are currently maintained by three licence servers:
    
    * ZČU in Plzeň,
    * ÚVT UK in Praha,
    * ÚVT MU in Brno.

    !!!important
        The purchased licenses permit just an academic use of the program!

    ### List of Licences

    | Name                       | Number |
    | -------------------------- | ------ |
    | MATLAB                     | 450    |
    | Aerospace_Toolbox          | 1      |
    | Antenna_Toolbox            | 1      |
    | Bioinformatics_Toolbox     | 15     |
    | Communication_Toolbox      | 25     |
    | Compiler                   | 7      |
    | Control_Toolbox            | 50     |
    | Curve_Fitting_Toolbox      | 52     |
    | Data_Acq_Toolbox           | 2      |
    | Database_Toolbox           | 12     |
    | Datafeed_Toolbox           | 1      |
    | Distrib_Computing_Toolbox  | 53     |
    | Econometrics_Toolbox       | 6      |
    | Embedded_IDE_Link          | 1      |
    | Excel_Link                 | 1      |
    | Financial_Toolbox          | 2      |
    | Fin_Instruments_Toolbox    | 2      |
    | Fixed_Point_Toolbox        | 3      |
    | Fuzzy_Toolbox              | 51     |
    | GADS_Toolbox               | 4      |
    | Identification_Toolbox     | 51     |
    | Image_Acquisition_Toolbox  | 5      |
    | Image_Toolbox              | 94     |
    | Instr_Control_Toolbox      | 1      |
    | MAP_Toolbox                | 4      |
    | MATLAB_Builder_for_Java    | 7      |
    | MATLAB_Coder               | 8      |
    | MATLAB_Distrib_Comp_Engine | 384    |
    | MPC_Toolbox                | 1      |
    | Neural_Network_Toolbox     | 153    |
    | Optimization_Toolbox       | 153    |
    | PDE_Toolbox                | 50     |
    | Power_System_Blocks        | 2      |
    | Real-Time_Win_Target       | 51     |
    | Real-Time_Workshop         | 3      |
    | Robotics_System_Toolbox    | 7      |
    | Robust_Toolbox             | 1      |
    | RTW_Embedded_Coder         | 2      |
    | Signal_Blocks              | 50     |
    | Signal_Toolbox             | 87     |
    | SimBiology                 | 5      |
    | SimDriveline               | 1      |
    | SimHydraulics              | 3      |
    | SimMechanics               | 5      |
    | Simscape                   | 7      |
    | Simulink_Control_Design    | 50     |
    | Simulink_HDL_Coder         | 3      |
    | Simulink_PLC_Coder         | 1      |
    | SIMULINK                   | 150    |
    | Stateflow                  | 25     |
    | Statistics_Toolbox         | 87     |
    | Symbolic_Toolbox           | 153    |
    | Target_Support_Package     | 1      |
    | Vehicle_Network_Toolbox    | 1      |
    | Video_and_Image_Blockset   | 12     |
    | Virtual_Reality_Toolbox    | 6      |
    | Wavelet_Toolbox            | 8      |

    Together with the permanent licence, a complete maintenance
    (including new version updates of all mentioned products) is also available and it is annually renewed.

    A list of licenses and its usage can be obtained by

    ```console
    $ /software/matlab-9.8/etc/lmstat -a | grep "in use"
    ```

    ### Licences and Scheduler

    You need to tell the PBS scheduler that the job will require a licence.
    Each MATLAB package has its own licence.
    For exasmple, if you need to use `Statistics_Toolbox`, submit your job like this:

    ```console
    qsub ... -l matlab=1 -l matlab_Statistics_Toolbox=1 ...
    ```

    Names of toolboxes with the `matlab_` prefix are required by PBS scheduling system for the purpose of license reservation.
    During MATLAB usage, don't use these prefixes and use only the base name of the selected toolbox.

=== "IT4Innovations"
    ## Versions

    For the list of versions, run `ml av matlab`.

    ## Licenses

    There are always two variants of the release:

    * Non-commercial or so-called EDU variant, which can be used for common research and educational purposes.
    * Commercial or so-called COM variant, which can used also for commercial activities. Commercial licenses are much more expensive, so usually the commercial license has only a subset of features compared to the available EDU license.

    !!! info
        Version 2021a is an e-INFRA CZ license, without cluster licenses - only basic functionality.

## Documentation

From the MATLAB command window one can use the command help to get help with a a particular command, e.g.

```console
>> help rand
```

in the desktop environment one can use also the command doc

```console
>> doc rand
```

## Resources

[MATLAB official page][1]<br>
[MATLAB documentation][2]

[1]: https://www.mathworks.com/products/matlab.html
[2]: https://www.mathworks.com/help/matlab/
