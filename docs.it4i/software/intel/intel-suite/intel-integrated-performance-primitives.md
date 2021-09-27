# Intel IPP

## Introduction

Intel Integrated Performance Primitives is a very rich library of highly optimized algorithmic building blocks for media and data applications. This includes signal, image, and frame processing algorithms, such as FFT, FIR, Convolution, Optical Flow, Hough transform, Sum, MinMax, as well as cryptographic functions, linear algebra functions, and many more.

## Installed Versions

For the current list of installed versions, use:

```console
$ ml av ipp
```

## IPP Example

```cpp
#include "ipp.h"
#include <stdio.h>
int main(int argc, char* argv[])
{
    const IppLibraryVersion *lib;
    Ipp64u fm;
    IppStatus status;

    status= ippInit();            //IPP initialization with the best optimization layer
    if( status != ippStsNoErr ) {
            printf("IppInit() Error:n");
            printf("%sn", ippGetStatusString(status) );
            return -1;
    }

    //Get version info
    lib = ippiGetLibVersion();
    printf("%s %sn", lib->Name, lib->Version);

    //Get CPU features enabled with selected library level
    fm=ippGetEnabledCpuFeatures();
    printf("SSE    :%cn",(fm>1)&1?'Y':'N');
    printf("SSE2   :%cn",(fm>2)&1?'Y':'N');
    printf("SSE3   :%cn",(fm>3)&1?'Y':'N');
    printf("SSSE3  :%cn",(fm>4)&1?'Y':'N');
    printf("SSE41  :%cn",(fm>6)&1?'Y':'N');
    printf("SSE42  :%cn",(fm>7)&1?'Y':'N');
    printf("AVX    :%cn",(fm>8)&1 ?'Y':'N');
    printf("AVX2   :%cn", (fm>15)&1 ?'Y':'N' );
    printf("----------n");
    printf("OS Enabled AVX :%cn", (fm>9)&1 ?'Y':'N');
    printf("AES            :%cn", (fm>10)&1?'Y':'N');
    printf("CLMUL          :%cn", (fm>11)&1?'Y':'N');
    printf("RDRAND         :%cn", (fm>13)&1?'Y':'N');
    printf("F16C           :%cn", (fm>14)&1?'Y':'N');

    return 0;
}
```

Compile the example above, using any compiler and the `ipp` module:

```console
$ ml intel/2020b ipp/2020.3.304
$ icc testipp.c -o testipp.x -lippi -lipps -lippcore
```

You will need the `ipp` module loaded to run an IPP-enabled executable. This may be avoided, by compiling library search paths into the executable:

```console
$ ml intel/2020b ipp/2020.3.304
$ icc testipp.c -o testipp.x -Wl,-rpath=$LIBRARY_PATH -lippi -lipps -lippcore
```

## Code Samples and Documentation

Intel provides a number of [Code Samples for IPP][a], illustrating use of IPP.

Read the full documentation on IPP on the [Intel website][b], in particular the [IPP Reference manual][c].

[a]: https://software.intel.com/en-us/articles/code-samples-for-intel-integrated-performance-primitives-library
[b]: http://software.intel.com/sites/products/search/search.php?q=&x=15&y=6&product=ipp&version=7.1&docos=lin
[c]: http://software.intel.com/sites/products/documentation/doclib/ipp_sa/71/ipp_manual/index.htm
