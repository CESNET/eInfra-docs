# CSharp

C# is available on the cluster.

```console
$ ml av mono

-------------------- /apps/modules/lang ---------------
   Mono/6.12.0.122
```

!!! note
    Use the `ml av mono` command to get up-to-date versions of the modules.

Activate C# by loading the Mono module:

```console
$ ml Mono/6.12.0.122
```

## Examples

### Hello World

Copy this code to a new file hello.cs:

```csc
using System;

class HelloWorld {
  static void Main() {
    Console.WriteLine("Hello world!!!");
  }
}
```

Compile the program and make *Windows executable*.

```console
$ mcs -out:hello.exe hello.cs
```

Now run the program:

```console
$ mono hello.exe
Hello world!!!
```

### Interactive Console

Type:

```console
$ csharp
Mono C# Shell, type "help;" for help

Enter statements below.
csharp>
```

Now you are in the interactive mode. You can try the following example:

```csc
csharp> using System;
csharp> int a = 5;
csharp> double b = 1.5;
csharp> Console.WriteLine("{0}*{1} is equal to {2}", a,b,a*b);
5*1.5 is equal to 7.5
csharp> a == b
false
```

Show all files modified in last 5 days:

```csc
csharp> using System.IO;
csharp> from f in Directory.GetFiles ("mydirectory")
      > let fi = new FileInfo (f)
      > where fi.LastWriteTime > DateTime.Now-TimeSpan.FromDays(5) select f;
{ "mydirectory/mynewfile.cs", "mydirectory/script.sh" }
```

## MPI.NET

MPI is available for mono:

```csc
using System;
using MPI;

class MPIHello
{
    static void Main(string[] args)
    {
        using (new MPI.Environment(ref args))
        {
           Console.WriteLine("Greetings from node {0} of {1} running on {2}",
           Communicator.world.Rank, Communicator.world.Size,
           MPI.Environment.ProcessorName);
        }
    }
}
```

Compile and run the program:

```console
$ qsub -I -A PROJECT_ID -q qexp -l select=2:ncpus=128,walltime=00:30:00

$ ml n.net

$ mcs -out:csc.exe -reference:/apps/tools/mpi.net/1.0.0-mono-3.12.1/lib/MPI.dll csc.cs

$ mpirun -n 4 mono csc.exe
Greetings from node 2 of 4 running on cn204
Greetings from node 0 of 4 running on cn204
Greetings from node 3 of 4 running on cn199
Greetings from node 1 of 4 running on cn199
```

For more information, see the [Mono documentation page][a].

[a]: http://www.mono-project.com/docs/
