---

title: Changing VM resources
search:
  exclude: false
---

# Changing VM resources

## Prerequisites

- Created [instance](/OpenStack/getting-started/creating-first-infrastructure/).

## Resizing image

In this guide we will shoud you how to change the VM resources by changing [flavor](/OpenStack/technical-reference/flavors/).

Before resizing you should save all your unsaved work and you should also consider making data backup in case if something goes wrong.

**1.** In Horizon go to **Project &gt; Compute &gt; Instances** and select **Resize Instance** on your instance

!!! example

    ![](/assets/openstack/tutorial/resize.png)

**2.** Select new flavor and confirm your choice

!!! example

    ![](/assets/openstack/tutorial/select.png)

**3.** Confirm selected changes in the instance menu

!!! example

    ![](/assets/openstack/tutorial/resize_confirm.png)