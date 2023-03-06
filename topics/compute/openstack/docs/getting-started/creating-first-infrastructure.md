---

title: Create first instance
search:
  exclude: false
---

<style>
  img[alt=login] { height: 300px; }
</style>

# Create First Instance

The following guide will take you through the steps necessary to start your first virtual machine instance.

Prerequisites:

* Up-to-date web browser
* Active account in [MetaCentrum](https://metavo.metacentrum.cz/en/application/index.html)
* Basic knowledge of SSH (for remote connections)

## Sign In

The dashboard is available at [https://dashboard.cloud.muni.cz](https://dashboard.cloud.muni.cz).

!!! note

    International users may choose <strong>EGI Check-in</strong>, <strong>DEEP AAI</strong> or <strong>LIFESCIENCE AAI</strong>, depending on their membership in these projects.


__1.__ Select `EINFRA CESNET`.

__2.__ Click on **Sign In**.

!!! example

    ![login](/compute/openstack/images/instance/login.png)


__3.__ Select your institution from the drop-down list.

__4.__ Provide your institution-specific sign-in credentials.

__5.__ Wait to be redirected back to our dashboard.



!!! tip

    When searching for your institution you can use the search box at the top.

## Create Key Pair

All virtual machine instances running in the cloud have to be accessed remotely. The most common way of accessing
an instance remotely is SSH. Using SSH requires a pair of keys - a public key and a private key.

__1.__ Navigate to **Project &gt; Compute &gt; Key Pairs** and click the **Create Key Pair** button.

!!! example

    ![](/compute/openstack/images/instance/keypair1.png)

__2.__ In the **Create key Pair** insert the **Key Pair Name**. Avoid using special characters, if possible. Next select SSH key for **Key Type** and finally confirm with **Done**.

!!! example

    ![](/compute/openstack/images/instance/keypair2.png)

__3.__ Download the private key to your local computer and move it to the `~/.ssh/` folder. If you are using windows, refer to [accessing from windows](../technical-reference/remote-access.md#accessing-from-windows).

__4.__ Set access privileges on `~/.ssh/` folder:

```
chmod 700 .ssh/
chmod 644 .ssh/id_rsa.pub
chmod 600 .ssh/id_rsa
```

## Update Security Group

In MetaCentrum Cloud, all incoming traffic from external networks to virtual machine instances is blocked by default.
You need to explicitly allow access to virtual machine instances and services via a security group.

You need to add at least one new rule to be able to connect to your new instance (or any instance using the given security group).
This is similar to setting up firewall rules on your router or server. If set up correctly, you will be able to access
your virtual machine via SSH from your local terminal.

__1.__ Go to **Project &gt;  Network &gt; Security Groups**. Click on **Manage Rules**, for the **default** security group.

!!! example

    ![](/compute/openstack/images/instance/sec_group1.png)

__2.__ Click on **Add rule**, choose **SSH**, and leave the remaining fields unchanged.
   This will allow you to access your instance via IPv4.

!!! example

    ![](/compute/openstack/images/instance/sec_group2.png)

!!! caution

    You have 2 possibilities for how to configure security groups policy.

    - One is through CIDR which specifies rules for concrete network range.
    - The second one specifies rules for members of a specified security group,
    i.e. policy will be applied on instances that belong to the selected security group.

For details, refer to [the official documentation](https://docs.openstack.org/horizon/train/user/configure-access-and-security-for-instances.html).

## Create Virtual Machine Instance

__1.__ In **Compute &gt; Instances**, click the **Launch Instance** button.

!!! example

    ![](/compute/openstack/images/instance/instance1.png)

__2.__ Choose **Instance Name**, Description, and number of instances.
   If you are creating more instances, `-%i` will be automatically appended to the name of each instance. Continue via **Next**

!!! example

    ![](/compute/openstack/images/instance/instance2.png)

__3.__ Choose an image from which to boot the instance. Choose to delete the volume after instance delete. This is not recommended for production deployment.

!!! example

    ![](/compute/openstack/images/instance/instance3.png)

__4.__ Choose the hardware resources of the instance by selecting a flavor. Additional volumes for data can be attached later on.

!!! example

    ![](/compute/openstack/images/instance/instance4.png)

__5.__ Select appropriate network based on your project type. and continue to **Key Pair** in the left menu.

=== "Personal project"

    For personal project select personal-project-network-subnet from network `147-251-115-pers-proj-net`

    !!! example

        ![](/compute/openstack/images/instance/instance5.png)

=== "Group project"

    For group project select group-project-network-subnet from network group-project-network (check if [Router gateway](../how-to-guides/create-networking.md#router-creation) is set)

    !!! example

        ![](/compute/openstack/images/tutorial/instance_launch_network-group.png)

__6.__ In **Key Pair** select the key that was created in section [Create Key Pair](#create-key-pair) in the Available list and finally **Launch Instance**.

!!! example

    ![](/compute/openstack/images/instance/instance6.png)

__9.__ Wait until instance initialization finishes and
[Associate Floating IP](../how-to-guides/allocating-floating-ips.md#allocation-and-assignment-of-fip).
For group project always select the same network as used in
[Router gateway](../how-to-guides/create-networking.md#router-creation).

!!! example

    ![](/compute/openstack/images/tutorial/instance_associate_ip.png)

__10.__ Login using your SSH key as selected in Key pair above

Connect to the instance using **ssh system@floating-ip**, as described on page [Accessing instances](../how-to-guides/accessing-instances.md).


!!! info

    On Linux and Mac, you can use the already present SSH client. On Windows, there are other possibilities for how to connect via SSH. One of the most common is [PuTTy](https://en.wikipedia.org/wiki/PuTTY) SSH client. How to configure and use PuTTy you can visit our [tutorial](../technical-reference/remote-access.md#accessing-from-windows).

For details, refer to [the official documentation](https://docs.openstack.org/horizon/train/user/launch-instances.html).
