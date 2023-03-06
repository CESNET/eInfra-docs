---
permalink: /docs/accessing-instances.html
title: Accessing instances
search:
  exclude: false
---

# Accessing Instances

## Prerequisites

- Created [networking](../how-to-guides/create-networking.md)
- Configured [Security groups](../getting-started/creating-first-infrastructure.md#update-security-group)
- Imported [SSH key](../getting-started/creating-first-infrastructure.md#create-key-pair)
- Created [Virtual machine](../getting-started/creating-first-infrastructure.md#create-virtual-machine-instance)
- Associated [Floating IP](../how-to-guides/allocating-floating-ips.md)

## Connecting to VM

After the creation of the virtual machine, it is usually immediately possible to
connect to the VM via SSH.

=== "Linux"

    Make sure to add your private ssh key in `$HOME/.ssh/id_rsa` or refer to
    [Technical reference](../technical-reference/remote-access.md)
    for additional possibilities as the first connection must be always done via SSH key.

    Now you should be able to connect to the VM via SSH:

    ``` example
    ssh centos@147.251.255.254
    ```

=== "Windows"

    Windows users need to use third party program [PuTTY](https://www.putty.org/).
    Before the connection via putty is possible it is first necessary to import
    private ssh key as is explained in [Technical reference](../technical-reference/remote-access.md).

## Default Users

| OS     | Login for SSH command |
|--------|-----------------------|
| Debian | debian                |
| Ubuntu | ubuntu                |
| Centos | centos                |

## Problems

If you have problems connecting to the VM, verify correct configuration of
[Security groups](../how-to-guides/managing-security-groups.md).

If you receive an error after connecting to the VM, verify your SSH key.
