# Phonopy

## Introduction

Phonopy is a free, open-source software for calculating phonons via harmonic and quasi-harmonic approximations, utilizing the direct force-constant method. At harmonic level, it allows calculating phonon band structure, phonon DOS and partial-DOS, phonon thermal properties, such as free energy, izochoric heat capacity, entropy, and other properties at constant volume, while the quasi-harmonic approximation can be used to obtain properties at constant pressure, such as izobaric heat capacity and thermal expansion coefficients. For details, see [Scr. Mater., 108 (2015), pp. 1-5][a], and the [Phonopy website][b].

## Installed Versions

For the current list of installed versions, use:

```console
ml av phonopy
```

## Example of the Calculation of Phonon Density of States and Thermal Properties of Aluminum Using the VASP Code

### Generating Displacements

All of the Phonopy calculations generally require a [POSCAR][1] with well relaxed forces in order for the resulting values to carry any physical meaning.

```console
cat POSCAR
```

```console
Al4
   1.00000000000000
     4.0432254711710000    0.0000000000000000    0.0000000000000000
     0.0000000000000000    4.0432254711710000    0.0000000000000000
     0.0000000000000000    0.0000000000000000    4.0432254711710000
   Al
     4
Direct
  0.0000000000000000  0.0000000000000000  0.0000000000000000
  0.0000000000000000  0.5000000000000000  0.5000000000000000
  0.5000000000000000  0.0000000000000000  0.5000000000000000
  0.5000000000000000  0.5000000000000000  0.0000000000000000
```

After obtaining a POSCAR with relaxed forces, we can either generate the displacements directly

```console
phonopy -d --dim 2 2 2 --pa auto -c POSCAR
```

or we can specify a config file [mesh.conf][2], which will contain all of our required attributes

```console
# contents of mesh.conf
ATOM_NAME = Al
DIM = 2 2 2
PRIMITIVE_AXES = Auto
```

and pass the file to phonopy as an argument

```console
phonopy -d mesh.conf -c POSCAR
```

For the list of all the possible phonopy tags, see [official documentation][d].

### Running the Jobs

Each unique displacement is named `POSCAR-XXX`, in our case we have only one, which is named `POSCAR-001`. If you are calculating plus and minus displacements, the minus displacement immediately follows the plus displacement.
Each unique displacement should then be moved to a separate folder, with every displacement file renamed to POSCAR, and POTCAR, [KPOINTS][3] and [INCAR][4] should be added.
If one doesn't use the automatic settings for the KPOINTS generation, it is important to lower the amount of generated k-points accordingly (for example, with k-points grid `8 8 8` for the unit cell, the `2 2 2` supercell should have a `4 4 4` k-points grid; it's always good to verify the number of generated k-points stays the same).
During the calculation, we need to move one of the atoms specified in POSCAR and calculate the forces (`ISIF = 0`, `ISMEAR` according to the type of the material at question).
After this, we can submit the VASP calculation using the `qsub` command.

### Calculating the Force Constants

After the calculations finish, we can generate the FORCE_SETS file using the following command:

```console
phonopy -f POSCAR-???.dir/vasprun.xml
```

### Calculating the DOS and Thermal Properties

Assuming we wrote all of our required parameters (such as the q-point mesh) to the mesh.conf file, we can then derive the phonon density of states (DOS)

```console
phonopy -p mesh.conf
```

with the DOS written in total_dos.dat file.

The thermal properties can then be calculated with

```console
phonopy -t -p mesh.conf
```

which outputs the thermal properties in the thermal_properties.yaml file.

## Example of Calculating the Thermal Expansion Coeffiecients of Aluminum Using the VASP Code

To calculate the thermal expansion coefficients, we need to obtain the volume dependence, which means we need to repeat the previous example for several different volumes of our POSCAR. All the rules mentioned in the previous example (i. e. the initial POSCARs have to be relaxed) still apply. We are also going to need a file containing the energy-volume dependence. Assuming we have calculated, we can either parse the data ourselves, or use the vasprun.xml files from the static calculations and running a command

```console
phonopy-vasp-efe vasprun.xml-{095..105}
```

Where the vasprun.xml-??? are the vaspruns for the static calculations for different (ionically relaxed) volumes of the unit cell (here, for example, `095` denotes that the initial POSCAR for the `095` calculation was at 95 % of the equilibrium volume etc.). The output file, `e-v.dat`, contains the extracted energy-volume curve.
Next we compile the thermal_properties.yaml files which we calculated for our selected (supercell) volumes into a single directory under unique names and run command

```console
phonopy-qha -p e-v.dat thermal_properties.yaml-{095..105}
```

## Useful Notes

* Always remember to check the FORCE_SETS file and verify that the displaced atoms are the ones with the largest forces acting on them, and that forces on other atoms are one or more orders lower; this can prevent your phonons from becoming imaginary. The forces can be adjusted by increasing (or lowering) the amplitude (`DISPLACEMENT_DISTANCE` tag).
* Never mix energy-volume curve of conventional unit cell and the supercell calculation of the primitive unit cell (and vice versa). This can be adjusted by the `PM` (primitive axes) tag. To verify whether your POSCAR contains conventional or primitive unit cell, you can run `phonopy --symmetry` on it. This outputs two files: BPOSCAR, which contains the conventional unit cell, and PPOSCAR, which will be the smallest possible cell.
  * If you used the `Auto` settings for the primitive axes, and aren't sure which cell has been used, you can check the calculated izochoric heat capacity, whose limit should be approaching at most 25 (3\*R) per mole (in our case per atom).
* Phonopy is a lightweight tool, and as such can be conveniently [run on your local machine][c].

[1]: ./files-phonopy/POSCAR.txt
[2]: ./files-phonopy/mesh.conf
[3]: ./files-phonopy/KPOINTS.txt
[4]: ./files-phonopy/INCAR.txt

[a]: https://doi.org/10.1016/j.scriptamat.2015.07.021
[b]: https://phonopy.github.io/phonopy/
[c]: https://phonopy.github.io/phonopy/install.html
[d]: https://phonopy.github.io/phonopy/setting-tags.html
