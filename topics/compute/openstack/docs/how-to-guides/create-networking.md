---

title: Create Networking
search:
  exclude: false
---

# Create Networking

We can create a virtual network in OpenStack for the project, which can be used by multiple VMs and divides the logical topology for each user.

## Network and Subnet Creation

=== "GUI"

    Navigate yourself towards **Project &gt; Network &gt; Networks** in the left menu and click on the **Create Network** on the right side of the window. This will start an interactive dialog for network creation.

    !!! example

        ![](/compute/openstack/images/networks/net1.png)


    **1.** Type in the network name

    !!! example

        ![](/compute/openstack/images/networks/net2.png)

    **2.** Move to the **Subnet** section either by clicking next or by clicking on the **Subnet** tab. You may choose to enter the network range manually (recommended for advanced users to not interfere with the public IP address ranges), or select **Allocate Network Address from a pool**. In the **Address pool** section select a `private-192-168`. Select Network mask which suits your needs (`27` as default can hold up to 29 machines).

    !!! example

        ![](/compute/openstack/images/networks/net3.png)

    **3.** For the last tab **Subnet Details** just check that a DNS is present and the DHCP box is checked, alternatively you can create the allocation pool or specify static routes.

    !!! example

        ![](/compute/openstack/images/networks/net4.png)

=== "CLI"

    **1.** **Create network**

    ```
    openstack network create project_network
    ```

    Additional network configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/network.html).


    **2.** **Create subnet for the network**

    ```
    openstack subnet create --network project_network --subnet-range 192.168.200.0/24 project_subnet
    ```

    Additional subnet configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/subnet.html).

    Refer to complete [example of creation VM including networking](https://gitlab.ics.muni.cz/cloud/g2/openstack-infrastructure-as-code-automation/-/blob/master/clouds/g2/ostrava/general/commandline/cmdline-demo.sh).
