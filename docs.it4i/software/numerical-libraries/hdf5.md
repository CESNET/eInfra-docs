# HDF5

Hierarchical Data Format library. Serial and MPI parallel version.

[HDF5 (Hierarchical Data Format)][a] is a general purpose library and file format for storing scientific data. HDF5 can store two primary objects: datasets and groups. A dataset is essentially a multidimensional array of data elements, and a group is a structure for organizing objects in an HDF5 file. Using these two basic objects, one can create and store almost any kind of scientific data structure, such as images, arrays of vectors, and structured and unstructured grids. You can also mix and match them in HDF5 files according to your needs.

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av HDF
```

To load the module, use the `ml` command.

The module sets up environment variables required for linking and running HDF5 enabled applications. Make sure that the choice of the HDF5 module is consistent with your choice of the MPI library. Mixing MPI of different implementations may cause unexpected results.

## Example

```cpp
    #include "hdf5.h"
    #define FILE "dset.h5"

    int main() {

       hid_t       file_id, dataset_id, dataspace_id;  /* identifiers */
       hsize_t     dims[2];
       herr_t      status;
       int         i, j, dset_data[4][6];

       /* Create a new file using default properties. */
       file_id = H5Fcreate(FILE, H5F_ACC_TRUNC, H5P_DEFAULT, H5P_DEFAULT);

       /* Create the data space for the dataset. */
       dims[0] = 4;
       dims[1] = 6;
       dataspace_id = H5Screate_simple(2, dims, NULL);

       /* Initialize the dataset. */
       for (i = 0; i < 4; i++)
          for (j = 0; j < 6; j++)
             dset_data[i][j] = i * 6 + j + 1;

       /* Create the dataset. */
       dataset_id = H5Dcreate2(file_id, "/dset", H5T_STD_I32BE, dataspace_id,
                              H5P_DEFAULT, H5P_DEFAULT, H5P_DEFAULT);

       /* Write the dataset. */
       status = H5Dwrite(dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT,
                         dset_data);

       status = H5Dread(dataset_id, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT,
                        dset_data);

       /* End access to the dataset and release resources used by it. */
       status = H5Dclose(dataset_id);

       /* Terminate access to the data space. */
       status = H5Sclose(dataspace_id);

       /* Close the file. */
       status = H5Fclose(file_id);
    }
```

Load modules and compile:

```console
$ ml intel
$ ml hdf5-parallel
$ mpicc hdf5test.c -o hdf5test.x -Wl,-rpath=$LIBRARY_PATH $HDF5_INC $HDF5_SHLIB
```

Run the example as [Intel MPI program][1].

For further information, see the [website][a].

[1]: ../mpi/running-mpich2.md

[a]: http://www.hdfgroup.org/HDF5/
