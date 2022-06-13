---

title: Create networking
search:
  exclude: false
---

# Create networking

We can create a virtual network in OpenStack for the project, which can be used by multiple VMs and divides the logical topology for each user.

## Network and subnet creation

=== "GUI"

    Navigate yourself towards **Project &gt; Network &gt; Networks** in the left menu and click on the **Create Network** on the right side of the window. This will start an interactive dialog for network creation.

    !!! example

        ![](/assets/openstack/networks/net1.png)


    **1.** Type in the network name

    !!! example

        ![](/assets/openstack/networks/net2.png)

    **2.** Move to the **Subnet** section either by clicking next or by clicking on the **Subnet** tab. You may choose to enter the network range manually (recommended for advanced users to not interfere with the public IP address ranges), or select **Allocate Network Address from a pool**. In the **Address pool** section select a `private-192-168`. Select Network mask which suits your needs (`27` as default can hold up to 29 machines).

    !!! example

        ![](/assets/openstack/networks/net3.png)

    **3.** For the last tab **Subnet Details** just check that a DNS is present and the DHCP box is checked, alternatively you can create the allocation pool or specify static routes.

    !!! example

        ![](/assets/openstack/networks/net4.png)

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


## Router creation

=== "GUI"

    Navigate yourself towards **Project &gt; Network &gt; Routers** in the left menu and click on the **Create Router** on the right side of the window.

    !!! example

        ![](/assets/openstack/networks/router1.png)

    Enter router name and select external gateway with the `-GROUP` suffix.

    !!! example

        ![](/assets/openstack/networks/router2.png)

    Now you need to attach your internal network to the router.

    **1.** Click on the router you just created.

    !!! example

        ![](/assets/openstack/networks/router3.png)

    **2.** Move to the **Interfaces** tab and click on the **Add interface**.

    !!! example

        ![](/assets/openstack/networks/router4.png)
        ![](/assets/openstack/networks/router5.png)

    **3.** Select a previously created subnet and submit.

    !!! example

        ![](/assets/openstack/networks/router6.png)

=== "CLI"

    **1.** **Create router**
    ```
    openstack router create project_router
    ```

    The current router has no ports. We need to create at least 2 interfaces: external and internal).

    **2.** **Set external network for the router (select one with `-GROUP`)**
    ```
    openstack router set --external-gateway public-muni-147-251-255-GROUP project_router
    ```

    **3.** **Assign router as a gateway for internal network**
    ```
    openstack router add subnet project_subnet project_router
    ```

    Additional router configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/router.html).
