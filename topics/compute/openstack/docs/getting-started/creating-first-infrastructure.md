---

title: Create First Instance
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
* [API key and CLI client](../how-to-guides/obtaining-api-key.md) (needed only if You want to use CLI)

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

=== "GUI"

    __1.__ Navigate to **Project &gt; Compute &gt; Key Pairs** and click the **Create Key Pair** button.
    
    !!! example
    
        ![](/compute/openstack/images/instance/keypair1.png)
    
    __2.__ In the **Create Key Pair** insert the **Key Pair Name**. Avoid using special characters, if possible. Next select SSH key for **Key Type** and finally confirm with **Create Key Pair**.
    
    !!! example
    
        ![](/compute/openstack/images/instance/keypair2.png)
    
    __3.__ Download the private key to your local computer and move it to the `~/.ssh/` folder. If you are using Windows, refer to [Accessing From Windows](../technical-reference/remote-access.md#accessing-from-windows).
    
    __4.__ Set access privileges on `~/.ssh/` folder:
    
    ```
    chmod 700 .ssh/
    chmod 644 .ssh/id_rsa.pub
    chmod 600 .ssh/id_rsa
    ```

=== "CLI"

    You can use the **ssh-keygen** command to create a new private key:
    ```
    ssh-keygen -b 4096
    ```

    You will be asked to specify the output file and passphrase for your key.

    Assuming your ssh public key is stored in `~/.ssh/id_rsa.pub`:
    ```
    openstack keypair create --public-key ~/.ssh/id_rsa.pub my-key1
    ```

## Update Security Group

In MetaCentrum Cloud, all incoming traffic from external networks to virtual machine instances is blocked by default.
You need to explicitly allow access to virtual machine instances and services via a security group.

You need to add at least one new rule to be able to connect to your new instance (or any instance using the given security group).
This is similar to setting up firewall rules on your router or server. If set up correctly, you will be able to access
your virtual machine via SSH from your local terminal.

=== "GUI"

    __1.__ Go to **Project &gt; Network &gt; Security Groups**. Click on **Manage Rules**, for the **default** security group.
    
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

=== "CLI"

    __1.__ Add SSH rule to the default security group:
        ```
        openstack security group rule create --description "Permit SSH" --remote-ip 0.0.0.0/0 --protocol tcp --dst-port 22 --ingress default
        ```
        
      Optionally, add ICMP rule (to allow ping):
        ```
        openstack security group rule create --description "Permit ICMP (any)" --remote-ip 0.0.0.0/0 --protocol icmp --icmp-type -1 --ingress default
        ```

    __2.__ Verify:
        ```
        openstack security group show default
        ```

## Create a Virtual Machine Instance

=== "GUI"

    __1.__ In **Compute &gt; Instances**, click the **Launch Instance** button.
    
    !!! example
    
        ![](/compute/openstack/images/instance/instance1.png)
    
    __2.__ Choose **Instance Name**, Description, and number of instances.
       If you are creating more instances, `-%i` will be automatically appended to the name of each instance. Continue via **Next**.
    
    !!! example
    
        ![](/compute/openstack/images/instance/instance2.png)
    
    __3.__ Choose an image from which to boot the instance. Choose to delete the volume after instance delete. This is not recommended for production deployment.
    
    !!! example
    
        ![](/compute/openstack/images/instance/instance3.png)
    
    __4.__ Choose the hardware resources of the instance by selecting a flavor. Additional volumes for data can be attached later on.
    
    !!! example
    
        ![](/compute/openstack/images/instance/instance4.png)
    
    __5.__ Select appropriate network based on your project type and continue to **Key Pair** in the left menu.
    
    === "Personal project"
    
        For personal project select personal-project-network-subnet from network `147-251-115-pers-proj-net`.
        Here is more information on available networks in [Brno](../technical-reference/brno-site/networking.md#ipv4-personal-floating-ips)
        and [Ostrava](../technical-reference/ostrava-site/networking.md#floating-ip-networks).
    
        !!! example
    
            ![](/compute/openstack/images/instance/instance5.png)
    
    === "Group project"
    
        For group project select group-project-network-subnet from network `group-project-network` (check if [Router gateway](../how-to-guides/create-router.md#router-creation) is set).
    
        !!! example
    
            ![](/compute/openstack/images/tutorial/instance_launch_network-group.png)
    
    __6.__ In **Key Pair** select the key that was created in section [Create Key Pair](#create-key-pair) in the Available list and finally **Launch Instance**.
    
    !!! example
    
        ![](/compute/openstack/images/instance/instance6.png)

=== "CLI"

    __1.__ **Create volume**

      Volumes are created automatically when creating an instance in GUI, but we need to create them manually in the case of CLI.
        
      Create bootable volume from image (e.g. centos):
        ```
        openstack volume create --image "centos-7-1809-x86_64" --size 40 my_vol1
        ```

      To get a list of available images:
        ```
        openstack image list
        ```
    
    __2.__ **Create instance**
        ```
        openstack server create --flavor "standard.small" --volume my_vol1 \
         --key-name my-key1 --security-group default --network 147-251-115-pers-proj-net my-server1
        ```

      To get a list of available flavors:
        ```
        openstack flavor list
        ```

      In case of a group project use `--network group-project-network`.

## Associate Floating IP

Floating IP is the OpenStack name for a public IP. It makes the instance accessible from an external network (e.g., the Internet).

At this point, you want to [Allocate IP Address](../how-to-guides/managing-floating-ips.md#allocating-ip-address)
and [Assign IP Address](../how-to-guides/managing-floating-ips.md#assigning-ip-address).
You don't have to care about the other sections unless you need them.

Possible IP address pools are described separately for [Brno](../technical-reference/brno-site/networking.md)
and [Ostrava](../technical-reference/ostrava-site/networking.md).

For group projects, always select the same network as used in
[Router gateway](../how-to-guides/create-router.md#router-creation).

## Login

Login using your SSH key as selected in Key pair above.

Connect to the instance using **ssh username@floating-ip**.

- `username` differs based on the selected image ("ubuntu", "debian", "centos", "almalinux"). The username topic is also discussed in [FAQ](../additional-information/faq.md).
- `floating-ip` is the one previously associated.

More information about login options is described on the [Accessing Instances](../how-to-guides/accessing-instances.md) page.


!!! info

    On Linux and Mac, you can use the already present SSH client. On Windows, there are other possibilities for how to connect via SSH. One of the most common is [PuTTy](https://en.wikipedia.org/wiki/PuTTY) SSH client. How to configure and use PuTTy you can visit our [tutorial](../technical-reference/remote-access.md#accessing-from-windows).

For details, refer to [the official documentation](https://docs.openstack.org/horizon/train/user/launch-instances.html).
