# Network

All compute and login nodes of Salomon are interconnected by the 7D Enhanced hypercube [InfiniBand][a] network and by the Gigabit [Ethernet][b] network. Only the [InfiniBand][c] network may be used to transfer user data.

## InfiniBand Network

All compute and login nodes of Salomon are interconnected by the 7D Enhanced hypercube [Infiniband][a] network (56 Gbps). The network topology is a [7D Enhanced hypercube][1].

Read more about schematic representation of the Salomon cluster [IB single-plain topology][2] ([hypercube dimension][1]).

The compute nodes may be accessed via the Infiniband network using the ib0 network interface, in the address range 10.17.0.0 (mask 255.255.224.0). The MPI may be used to establish a native Infiniband connection among the nodes.

The network provides **2170MB/s** transfer rates via the TCP connection (single stream) and up to **3600MB/s** via the native Infiniband protocol.

## Example

```console
$ qsub -q qexp -l select=4:ncpus=16 -N Name0 ./myjob
$ qstat -n -u username
                                                            Req'd Req'd   Elap
Job ID          Username Queue    Jobname    SessID NDS TSK Memory Time S Time
--------------- -------- --  |---|---| ------ --- --- ------ ----- - -----
15209.isrv5     username qexp     Name0        5530   4 96    --  01:00 R 00:00
   r4i1n0/0*24+r4i1n1/0*24+r4i1n2/0*24+r4i1n3/0*24
```

In this example, we access the node r4i1n0 by Infiniband network via the ib0 interface.

```console
$ ssh 10.17.35.19
```

In this example, we get
information of the Infiniband network.

```console
$ ifconfig
....
inet addr:10.17.35.19....
....

$ ip addr show ib0

....
inet 10.17.35.19....
....
```

[1]: 7d-enhanced-hypercube.md
[2]: ib-single-plane-topology.md

[a]: http://en.wikipedia.org/wiki/InfiniBand
[b]: http://en.wikipedia.org/wiki/Ethernet
[c]: http://en.wikipedia.org/wiki/InfiniBand
