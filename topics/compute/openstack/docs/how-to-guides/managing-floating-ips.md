---

title: Managing Floating IPs
search:
  exclude: false
---

# Managing Floating IPs
In OpenStack, a floating IP address is a public IP address that can be assigned to an instance. This allows external access to the instance, even if it is behind a router or firewall. In this how-to guide, we will walk you through the process of allocating, assigning, disassociating, and releasing a floating IP address.

## Prerequisites

Before you begin, you should have the following:

- OpenStack project with access to API or GUI.
- [Networking](../how-to-guides/create-networking.md) created for your project.
- Instance that you want to assign a floating IP address to.

## Allocating IP Address

=== "Horizon"

    **1.** Go to **Project &gt; Network &gt; Floating IPs** and click on the **Allocate IP to Project** button.

    !!! example

        ![](/compute/openstack/images/networks/fip1.png)

    **2.** Select **Pool** with the same value as the network you chose in the previous step and confirm it by clicking **Allocate IP**.

    !!! example

        ![](/compute/openstack/images/networks/fip2.png)

=== "Command Line"

    To allocate a floating IP address, you can use the following command:

    !!! example
        ```
        $ openstack floating ip create <external_network_name_or_id>
        ```

        !!! info

            The `<external_network_name_or_id>` is an external IP address pool managed by OpenStack administrators. Full list of available floating IP address pools can be found in [Technical reference G1 Brno](../../technical-reference/brno-g1-site/networking/#ipv4-group-floating-ips), [Technical reference G2 Ostrava](../../technical-reference/ostrava-g2-site/networking) and [Technical reference G2 Brno](../../technical-reference/brno-g2-site/networking).

    Additional floating IP configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/floating-ip.html).

    Also, refer to [example of how floating IP allocation](https://gitlab.ics.muni.cz/cloud/g2/openstack-infrastructure-as-code-automation/-/blob/master/clouds/g2/ostrava/general/commandline/cmdline-demo.sh) is handled within creation of VM.


## Assigning IP Address

=== "Horizon"
    **1.** Now click on the **Associate** button next to the floating IP you just created.

    !!! example

        ![](/compute/openstack/images/networks/fip3.png)

    **2.** Select **Port to be associated** with the desired instance. Confirm with the **Associate** button.

    !!! example

        ![](/compute/openstack/images/networks/fip4.png)

=== "Command Line"

    To assign a floating IP address to an instance, you can use the following command:

    !!! example
        ```
        $ openstack server add floating ip <server_name_or_id> <floating_ip_address>
        ```
        !!! info

            The `<server_name_or_id>` is the Virtual Machine you wish to append your floating ip address to. To find the server_id, you can use the following command:
            ```
            $ openstack server show <server_name_or_id> -f value -c id
            ```

            The `<floating_ip_address>` is the ID of the floating IP created in step [Allocating IP address](#allocating-ip-address), you can check unassigned floating IPs using command:
            ```
            $ openstack floating ip list
            ```

    Additional floating IP configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/floating-ip.html).

    Also, refer to [example of how floating IP assignment](https://gitlab.ics.muni.cz/cloud/g2/openstack-infrastructure-as-code-automation/-/blob/master/clouds/g2/ostrava/general/commandline/cmdline-demo.sh) is handled within creation of VM.
## Disassociating Floating IP

=== "Horizon"

    Go to **Project &gt; Compute &gt;  Instances**. Click on the menu **Actions** on the instance you wish to change and **Disassociate Floating IP**.

    !!! example

        ![](/compute/openstack/images/networks/fip5.png)

=== "Command Line"

    To disassociate a floating IP address from an instance, you can use the following command:

    !!! example
        ```
        $ openstack server remove floating ip <server_name_or_id> <floating_ip_address>
        ```
        !!! info

            The `<server_name_or_id>` is the Virtual Machine you wish to append your floating ip address to. To find the server_id, you can use the following command:
            ```
            $ openstack server show <server_name_or_id> -f value -c id
            ```

            The `<floating_ip_address>` is the ID of the floating IP created in step [Allocating IP address](#allocating-ip-address), you can check unassigned floating IPs using command:
            ```
            $ openstack floating ip list
            ```
    This will remove the specified floating IP address from the specified instance.

    Additional floating IP configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/floating-ip.html).

## Releasing Floating IP

!!! caution

    After this action, your project will no longer be able to use the floating IP address you released.

=== "Horizon"

    Go to **Project &gt; Compute &gt;  Instances**. Click on the menu **Actions** on the instance you wish to change and **Disassociate Floating IP** and specify that you wish to **Release Floating IP**.

    !!! example

        ![](/compute/openstack/images/networks/fip5.png)

=== "Command Line"

    To release a floating IP address, you can use the following command:

    !!! example
        ```
        $ openstack floating ip delete <floating_ip_address>
        ```
        !!! info

            The `<floating_ip_address>` is the ID of the floating IP created in step [Allocating IP address](#allocating-ip-address), you can check unassigned floating IPs using command:
            ```
            $ openstack floating ip list
            ```

    This will delete the specified floating IP address from your OpenStack project.

    Additional floating IP configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/floating-ip.html).

## Troubleshooting
- **Check status of the floating IP address**: Make sure that the status is "ACTIVE" and that the floating IP address is associated with an instance. Use the following command:

    ```
    $ openstack floating ip show <floating_ip_address>
    ```

- **Check if the router is correctly connected**: Make sure that the router is connected to the correct external network and that it has the appropriate gateway set. Use the following command:

    ```
    $ openstack router show <router_name_or_id>
    ```

- **Verity status of the virtual machine**: Make sure that the instance you are trying to assign a floating IP address to is running and has the appropriate network interfaces attached. use the following command:

    ```
    $ openstack server show <server_name_or_id>
    ```

- **Check FAQ**: If you approach an issue when connecting to our infrastructure, make sure to first check FAQ before contacting support.
- **Contact support**: If you're unable to resolve the issue on your own, contact your OpenStack support team for further assistance. Be sure to provide as much information as possible, including error messages and steps you've already taken to troubleshoot the issue.

## Security Considerations
- **Use secure communication protocols**: When communicating with your server, use secure communication protocols like HTTPS to prevent unauthorized access and interception of data.
- **Limit the use of floating IP addresses**: Only assign floating IP addresses to instances that require external access. Avoid assigning floating IP addresses to instances that do not require external access to minimize the attack surface.
- **Use a bastion host**: Consider using a bastion host to restrict access to your OpenStack environment. A bastion host is a dedicated server that acts as a gateway between the Internet and your OpenStack environment. By limiting access to the bastion host, you can reduce the attack surface of your OpenStack environment and prevent unauthorized access. Additionally, a bastion host can be configured to provide logging and auditing capabilities, making it easier to track and investigate security incidents.
- **Review firewall rules**: Review and update firewall rules to ensure that only necessary ports and services are accessible from the Internet.
