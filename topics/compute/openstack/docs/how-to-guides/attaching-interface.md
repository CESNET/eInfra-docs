---

title: Attaching Network Interface
search:
  exclude: false
---

# Attaching Network Interface

## Prerequisites

- Created [instance](../getting-started/creating-first-infrastructure.md).

## Attaching Interface

This guide shows how to attach additional interfaces to running instances. This approach can be used for both IPv4 and IPv6 networks.

!!! info

    If you approach a problem with your IPv6 deployment, please refer to [IPv6 troubleshooting](../additional-information/ipv6-troubleshooting.md).

=== "GUI"

    Go to **Project &gt; Compute &gt;  Instances**. Click on the menu **Actions** on the instance you wish to change and click on **Attach interface**.

    !!! example

        ![](/compute/openstack/images/networks/attach_interface.png)

    In the **Network** dropdown menu select available IPv6 network.

    !!! example

        ![](/compute/openstack/images/networks/ipv6_attach.png)

=== "CLI"

    **Get ID of your VM, in this instance named my-vm**

    ```
    VM_ID=$(openstack server list --name my-vm -f value -c ID)
    ```

    **Create port for the network and add it to your VM**

    ```
    openstack port create --network <my-network> --security-group default --host ${VM_ID} <my-port-name>

    openstack server add port <VM_ID> <my-network>

    ```

    Additional port configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/port.html).
