# Vesta

## Introduction

VESTA (Visualization for Electronic and Structural Analysis) is a 3D visualization program for structural models, volumetric data such as electron/nuclear densities, and crystal morphologies. Some of the novel features of VESTA include:

* Deal with multiple structural models, volumetric data, and crystal morphologies in the same window;
* Support multiple tabs corresponding to files;
* Support multiple windows with more than two tabs in the same process;
* Deal with virtually unlimited number of objects such as atoms, bonds polyhedra, and polygons on isosurfaces (theoretical limit on 32bit operating  system is 1,073,741,823);
* Support lattice transformation from conventional to non-conventional lattice by using matrix. The transformation matrix is also used to create superlattice and sublattice;
* Visualize interatomic distances and bond angles that are restrained in Rietveld analysis with RIETAN-FP;
* Transparent isosurfaces can be overlap with structural models;
* Isosurface can be colored on the basis of another physical quantity;
* Arithmetic operations among multiple volumetric data files;
* High quality smooth rendering of isosurfaces and sections;
* Export high-resolution graphic images exceeding Video card limitation.

For the full list of features and supported file formats, see the [official page][1].

## Manual

The VESTA manual can be found [here][2].

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av vesta
```

!!!note Module Availability
    This module is currently availble on the Barbora cluster only.

[1]: https://jp-minerals.org/vesta/en/
[2]: https://jp-minerals.org/vesta/archives/VESTA_Manual.pdf
