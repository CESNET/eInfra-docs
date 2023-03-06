---

title: Allocating Floating IPs
search:
  exclude: false
---

# Allocating Floating IPs

## Prerequisites

- Created [networking](../how-to-guides/create-networking.md)

## Allocation and Assignment of FIP

Floating IPs are used to assign public IP address to VMs.

=== "GUI"

    **1.** Go to **Project &gt; Network &gt; Floating IPs** and click on the **Allocate IP to Project** button.

    !!! example

        ![](/compute/openstack/images/networks/fip1.png)

    **2.** Select **Pool** with the same value as the network you chose in the previous step and confirm it by clicking **Allocate IP**.

    !!! example

        ![](/compute/openstack/images/networks/fip2.png)

    **3.** Now click on the **Associate** button next to the Floating IP you just created.

    !!! example

        ![](/compute/openstack/images/networks/fip3.png)

    **4.** Select **Port to be associated** with the desired instance. Confirm with the **Associate** button.

    !!! example

        ![](/compute/openstack/images/networks/fip4.png)

=== "CLI"

    **Allocate new Floating IP**
    ```
    openstack floating ip create public-muni-147-251-255-GROUP
    ```

    **Assign Floating IP to server**
    ```
    openstack server add floating ip project_vm 147.251.255.254
    ```

    Additional floating IP configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/floating-ip.html).


## Release of Floating IP

!!! caution

    After this action, your project will no longer be able to use the floating IP address you released.

=== "GUI"

    Go to **Project &gt; Compute &gt;  Instances**. Click on the menu **Actions** on the instance you wish to change and **Disassociate Floating IP** and specify that you wish to **Release Floating IP**.

    !!! example

        ![](/compute/openstack/images/networks/fip5.png)


=== "CLI"

    **Get interfaces attached to your VM**

    ```
    $ openstack server show project_vm -f value -c addresses
    {'dvasek-net': ['192.168.200.200', '147.251.255.254']}
    ```

    **Remove floating IPs**

    ```
    $ openstack server remove floating ip project_vm 147.251.255.254
    $ openstack floating ip delete 147.251.255.254
    ```

    Additional floating IP configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/floating-ip.html).
