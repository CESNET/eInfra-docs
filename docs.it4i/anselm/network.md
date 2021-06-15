# Network

All of the compute and login nodes of Anselm are interconnected through an [InfiniBand][a] QDR network and a Gigabit [Ethernet][b] network. Both networks may be used to transfer user data.

## InfiniBand Network

All of the compute and login nodes of Anselm are interconnected through a high-bandwidth, low-latency [InfiniBand][a] QDR network (IB 4 x QDR, 40 Gbps). The network topology is a fully non-blocking fat-tree.

The compute nodes may be accessed via the InfiniBand network using the ib0 network interface, in address range 10.2.1.1-209. The MPI may be used to establish native InfiniBand connection among the nodes.

!!! note
    The network provides **2170 MB/s** transfer rates via the TCP connection (single stream) and up to **3600 MB/s** via the native InfiniBand protocol.

The Fat tree topology ensures that peak transfer rates are achieved between any two nodes, independent of network traffic exchanged among other nodes concurrently.

## Ethernet Network

The compute nodes may be accessed via the regular Gigabit Ethernet network interface eth0, in the address range 10.1.1.1-209, or by using aliases cn1-cn209. The network provides **114 MB/s** transfer rates via the TCP connection.

## Example

In this example, we access the node cn110 through the InfiniBand network via the ib0 interface, then from cn110 to cn108 through the Ethernet network.

```console
$ qsub -q qexp -l select=4:ncpus=16 -N Name0 ./myjob
$ qstat -n -u username
                                                            Req'd Req'd   Elap
Job ID          Username Queue    Jobname    SessID NDS TSK Memory Time S Time
--------------- -------- --  |---|---| ------ --- --- ------ ----- - -----
15209.srv11     username qexp     Name0        5530   4 64    --  01:00 R 00:00
   cn17/0*16+cn108/0*16+cn109/0*16+cn110/0*16

$ ssh 10.2.1.110
$ ssh 10.1.1.108
```

[a]: http://en.wikipedia.org/wiki/InfiniBand
[b]: http://en.wikipedia.org/wiki/Ethernet
