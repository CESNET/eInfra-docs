---

title: Managing Security Groups
search:
  exclude: false
---

# Managing Security Groups

By default, each project has a **default** security group that can be assigned to each VM. In this guide, we will show you how to enable SSH connection via the security group.

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
