---
permalink: /docs/accessing-instances.html
title: Accessing instances
search:
  exclude: false
---

# Accessing instances

## Prerequisites

- Created [networking](/OpenStack/how-to-guides/create-networking/)
- Configured [Security groups](/OpenStack/how-to-guides/configuring-security-groups/)
- Imported [SSH key](/OpenStack/getting-started/creating-first-infrastructure/)
- Created [Virtual machine](/OpenStack/getting-started/creating-first-infrastructure/)
- Associated [Floating IP](/OpenStack/how-to-guides/allocating-floating-ips/)

## Connecting to VM

After the creation of the virtual machine, it is usually immediately possible to
connect to the VM via SSH.

=== "Linux"

    Make sure to add your private ssh key in `$HOME/.ssh/id_rsa` or refer to
    [Technical reference](/OpenStack/technical-reference/remote-access/)
    for additional possibilities as the first connection must be always done via SSH key.

    Now you should be able to connect to the VM via SSH:

    ``` example
    ssh centos@147.251.255.254
    ```

=== "Windows"

    Windows users need to use third party program [PuTTY](https://www.putty.org/).
    Before the connection via putty is possible it is first necessary to import
    private ssh key as is explained in [Technical reference](/OpenStack/technical-reference/remote-access/).

## Default users

| OS     | login for ssh command |
|--------|-----------------------|
| Debian | debian                |
| Ubuntu | ubuntu                |
| Centos | centos                |

## Problems

If you have problems connecting to the VM, verify correct configuration of
[Security groups](/OpenStack/how-to-guides/configuring-security-groups/).

If you receive an error after connecting to the VM, verify your SSH key.
