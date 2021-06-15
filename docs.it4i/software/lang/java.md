# Java

Java is available on the cluster. Activate Java by loading the Java module:

```console
$ ml Java
```

Note that the Java module must be loaded on the compute nodes as well, in order to run Java on compute nodes.

Check for Java version and path:

```console
$ java -version
$ which java
```

With the module loaded, not only the runtime environment (JRE), but also the development environment (JDK) with the compiler is available.

```console
$ javac -version
$ which javac
```

Java applications may use MPI for inter-process communication, in conjunction with OpenMPI. Read more [here][a]. This functionality is currently not supported. In case you require the Java interface to MPI, contact [support][b].

## Java With OpenMPI

Because there is an increasing interest in using Java for HPC. In addition, MPI can benefit from Java because its widespread use makes it likely to find new uses beyond traditional HPC applications.

Java bindings are integrated into OpenMPI starting from the v1.7 series. Beginning with the v2.0 series, Java bindings include coverage of MPI-3.1.

### Example (Hello.java)

```java
import mpi.*;

class Hello {
    static public void main(String[] args) throws MPIException {


        MPI.Init(args);

        int myrank = MPI.COMM_WORLD.getRank();
        int size = MPI.COMM_WORLD.getSize() ;
        System.out.println("Hello world from rank " + myrank + " of " + size);

        MPI.Finalize();
    }
}
```

```console
$ ml Java/1.8.0_144
$ ml OpenMPI/1.8.0_144
$ mpijavac Hello.java
$ mpirun java Hello
Hello world from rank 23 of 28
Hello world from rank 25 of 28
Hello world from rank 0 of 28
Hello world from rank 4 of 28
Hello world from rank 7 of 28
Hello world from rank 8 of 28
Hello world from rank 11 of 28
Hello world from rank 12 of 28
Hello world from rank 13 of 28
Hello world from rank 18 of 28
Hello world from rank 17 of 28
Hello world from rank 24 of 28
Hello world from rank 27 of 28
Hello world from rank 2 of 28
Hello world from rank 3 of 28
Hello world from rank 1 of 28
Hello world from rank 10 of 28
Hello world from rank 14 of 28
Hello world from rank 16 of 28
Hello world from rank 19 of 28
Hello world from rank 26 of 28
Hello world from rank 6 of 28
Hello world from rank 9 of 28
Hello world from rank 15 of 28
Hello world from rank 20 of 28
Hello world from rank 5 of 28
Hello world from rank 21 of 28
Hello world from rank 22 of 28
```

[a]: http://www.open-mpi.org/faq/?category=java
[b]: https://support.it4i.cz/rt/
