---

title: Managing Network Interface
search:
  exclude: false
---

# Managing Network Interface

In OpenStack, you can attach a network interface to an instance to provide additional network connectivity. This allows the instance to communicate with other resources on the network, including other instances, services, and external networks. In this how-to guide, we will walk you through the process of attaching and detaching a network interface using the OpenStack command-line interface (CLI).

## Prerequisites

Before you begin, you should have the following:

- An [instance](../getting-started/creating-first-infrastructure.md) that you want to attach a network interface to
- A pre-existing OpenStack [network](../how-to-guides/create-networking.md) that you want to attach to the instance

## Attaching Interface

!!! info

    If you approach a problem with your IPv6 deployment, please refer to [IPv6 troubleshooting](../additional-information/ipv6-troubleshooting.md).

=== "Horizon"

    Go to **Project &gt; Compute &gt;  Instances**. Click on the menu **Actions** on the instance you wish to change and click on **Attach interface**.

    !!! example

        ![](/compute/openstack/images/networks/attach_interface.png)

    In the **Network** dropdown menu select available network.

    !!! example

        ![](/compute/openstack/images/networks/ipv6_attach.png)

=== "Command Line"
    To attach a network interface to an OpenStack instance, you will need to create a port that is attached to the desired network and host. You can create a new port using the following:

    !!! example
        ```
        openstack port create --network <network_id> --security-group <security_group_name_or_id> --host <virtual_machine_name_or_id> <port_name>
        ```

        !!! info

            The `<network_name_or_id>` represents the network you wish to attach the new interface to. By specifying `--security-group` you can select specific security group for the port and by specifying `--host` you can directly attach the interface to the host upon creation.

    Additional port configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/port.html).

## Detaching Interface

=== "Horizon"

    Go to **Project &gt; Compute &gt;  Instances**. Click on the menu **Actions** on the instance you wish to change and click on **Detach interface**.

    !!! example

        ![](/compute/openstack/images/networks/attach_interface.png)

    In the **Port** dropdown menu select port on what you want to detach interface.

    !!! example

        ![](/compute/openstack/images/networks/detach_interface.png)        


=== "Command Line"

    To detach a network interface from an OpenStack instance, you can use the following command:

    !!! example
        ```
        $ openstack server remove port <server_id> <port_id>
        ```

        !!! info
            This will detach the OpenStack port specified by `<port_id>` from the instance specified by `<server_id>`.

    To delete the port after it has been detached from the instance, use the following command:

    !!! example
        ```
        $ openstack port delete <port_id>
        ```

        !!! info
            This will delete the specified port `<port_id>` from your OpenStack environment.

## Troubleshooting

If you encounter any issues while attaching or detaching a network interface, you can use the following commands to troubleshoot:

- **Check the status of an OpenStack port**: Make sure that the status is "ACTIVE" and that the port is attached to the correct network. Use the following command:

```
openstack port show <port_id>
```

- **Check the instance and its associated network interfaces**: Make sure that the instance is running and has the appropriate network interfaces attached. Use the following command:

```
$ openstack server show <server_id>
```

- **Check FAQ**: If you approach an issue, make sure to first check FAQ before contacting support.

- **Contact support**: If you're unable to resolve the issue on your own, contact your OpenStack support team for further assistance. Be sure to provide as much information as possible, including error messages and steps you've already taken to troubleshoot the issue.

## Security Considerations

- **Limit the use of network interfaces**: Only attach network interfaces to instances that require them. Avoid attaching network interfaces to instances that do not require them to minimize the attack surface.
- **Review firewall rules**: Review and update firewall rules to ensure that only necessary ports and services are accessible from the network interface.
- **Use security groups**: Use security groups to define the network traffic that is allowed to or from the instance.
