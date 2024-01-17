---

title: Create Router
search:
  exclude: false
---

# Create Router

## Router Creation

=== "GUI"

    Navigate yourself towards **Project &gt; Network &gt; Routers** in the left menu and click on the **Create Router** on the right side of the window.

    !!! example

        ![](/compute/openstack/images/networks/router1.png)

    Enter router name and select external gateway with the `-GROUP` suffix.

    !!! example

        ![](/compute/openstack/images/networks/router2.png)

    Now you need to attach your internal network to the router.

    **1.** Click on the router you just created.

    !!! example

        ![](/compute/openstack/images/networks/router3.png)

    **2.** Move to the **Interfaces** tab and click on the **Add interface**.

    !!! example

        ![](/compute/openstack/images/networks/router4.png)
        ![](/compute/openstack/images/networks/router5.png)

    **3.** Select a previously created subnet and submit.

    !!! example

        ![](/compute/openstack/images/networks/router6.png)

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

    Also, refer to the [example of a router creation](https://gitlab.ics.muni.cz/cloud/g2/openstack-infrastructure-as-code-automation/-/blob/master/clouds/g2/ostrava/general/commandline/cmdline-demo.sh) is handled within creation of VM. 

## Router External Gateway Assign

If you have no gateway on you router, you can assign a new one.

=== "GUI"

    **1.** You can set your gateway by clicking **Set Gateway**.

    !!! example

        ![](/compute/openstack/images/networks/set-router1.png)

    **2.** Choose the network you desire to use (e.g. **public-cesnet-78-128-251**) and confirm.

    !!! example

        ![](/compute/openstack/images/networks/set-router2.png)

=== "CLI"

    **Set external network for the router (let us say public-muni-147-251-255-GROUP), and the external port will be created automatically**

    ```
    openstack router set --external-gateway public-muni-147-251-255-GROUP my-router1
    ```

    Additional router configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/router.html).

    Also, refer to [example of a gateway creation](https://gitlab.ics.muni.cz/cloud/g2/openstack-infrastructure-as-code-automation/-/blob/master/clouds/g2/ostrava/general/commandline/cmdline-demo.sh) is handled within router setup.

## Router External Gateway Release

=== "GUI"

    Navigate to the **Project &gt; Network &gt; Routers**. Click on the action **Clear Gateway** of your router. This action will disassociate the external network from your router, so your machines will no longer be able to access the Internet. If you get an error you need to first **Disassociate Floating IPs**.

    !!! example

        ![](/compute/openstack/images/networks/clear-router1.png)

=== "CLI"

    **Release external gateway from router**

    ```
    openstack router unset --external-gateway my-router1
    ```

    Make sure to first [release FIPs](../how-to-guides/managing-floating-ips.md#releasing-floating-ip) from the network.

    Additional router configuration is available in [official CLI documentation](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/router.html).
