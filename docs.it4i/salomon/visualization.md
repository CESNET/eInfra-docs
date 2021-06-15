# Visualization Servers

Remote visualization with [NICE DCV software][3] or [VirtualGL][4] is availabe on two nodes.

| Node          | Count | Processor                         | Cores | Memory | GPU Accelerator              |
|---------------|-------|-----------------------------------|-------|--------|------------------------------|
| visualization | 2     | 2 x Intel Xeon E5-2695v3, 2.3 GHz | 28    | 512 GB | NVIDIA QUADRO K5000 4 GB     |

## Resource Allocation Policy

| queue | active project | project resources | nodes | min ncpus | priority | authorization | walltime |
|-------|----------------|-------------------|-------|-----------|----------|---------------|----------|
| qviz Visualization queue | yes | none required | 2 (with NVIDIA Quadro K5000) | 4 | 150 | no | 1h/8h |

## References

* [Graphical User Interface][1]
* [VPN Access][2]

[1]: ../general/shell-and-data-access.md#graphical-user-interface
[2]: ../general/shell-and-data-access.md#vpn-access
[3]: ../software/viz/NICEDCVsoftware.md
[4]: ../software/viz/vgl.md