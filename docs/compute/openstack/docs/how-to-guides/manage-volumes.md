---

title: Manage volumes
search:
  exclude: false
---

# Manage volumes

When storing a large amount of data in a virtual machine instance, it is advisable to use a separate volume and not the
root file system containing the operating system. It adds flexibility and often prevents data loss. Volumes can be
attached and detached from instances at any time, their creation and deletion are managed separately from instances.

## Creating volume

__1.__ In **Project &gt; Volumes &gt; Volumes**, select **Create Volume**.

!!! example

    ![](/assets/openstack/volumes/volume1.png)

__2.__ Provide name, description, and size in GBs. If not instructed otherwise, leave all other fields unchanged and click on **Create Volume**.

__3.__ __(optional)__ In **Project &gt; Compute &gt; Instances**, select **Attach Volume** from the **Actions** menu for the
   given instance.

__4.__ __(optional)__ Select **Volume ID** from the drop-down list and click **Attach Volume**.

For details, refer to [the official documentation](https://docs.openstack.org/horizon/train/user/manage-volumes.html).

## Backups

It is possible to create volume snapshots or backups. In this guide we will focus on volume backups. When creating a backup it is recommended to turn off the instance if possible to prevent data errors.

### Creating volume backup

__1.__ __(optional)__ In **Project &gt; Compute &gt; Instances** Turn off the affected instance.

!!! example

    ![](/assets/openstack/volumes/instance-shutoff.png)

__2.__ In **Project &gt; Volumes &gt; Volumes** open the **Actions** menu of selected volume an select **Create Backup**.

!!! example

    ![](/assets/openstack/volumes/backup1.png)

__3.__ Specify Backup Name and optional information and press **Create Volume Backup**

!!! example

    ![](/assets/openstack/volumes/backup2.png)

__3.__ Wait for the Backup to be created, it will be then stored in **Project &gt; Volumes &gt; Backups**.

### Restoring volume backup

__1.__ __(optional)__ In **Project &gt; Compute &gt; Instances** Turn off the affected instance.

!!! example

    ![](/assets/openstack/volumes/instance-shutoff.png)

__2.__ In **Project &gt; Volumes &gt; Backups** open the **Actions** menu of selected backup and select **Restore Backup**.

!!! example

    ![](/assets/openstack/volumes/backup3.png)

__3.__ Wait for the Backup to be restored.

## Volume resize

We can distinghuish two types of volumes, namely

- Attachable volumes: additional volumes that don't contain the system image and the VM can startup without their presence.
- System volumes: The boot image must be always present.

### Resizing attachable volume

When working with volumes, we highly recommend to always make a [volume backup](#creating-volume-backup) before any operations with the volume.

__1.__ Turn off the instance in **Project &gt; Compute &gt; Instances**.

!!! example

    ![](/assets/openstack/volumes/instance-shutoff.png)

__2.__ Detach the volume from the instance in **Project &gt; Volumes &gt; Volumes**. On selected volume open the **Actions** menu and select **Manage Attachments**

!!! example

    ![](/assets/openstack/volumes/attachment1.png)

__3.__ Select **Detach Volume** and confirm.

!!! example

    ![](/assets/openstack/volumes/attachment2.png)

__4.__ Open the **Actions** menu again an select **Extend Volume**.

!!! example

    ![](/assets/openstack/volumes/extend1.png)

__5.__ Specify new size of the volume and press **Extend Volume**.

!!! example

    ![](/assets/openstack/volumes/extend2.png)

__6.__ Attach the volume back to the instance via **Manage Attachments**.

!!! example

    ![](/assets/openstack/volumes/attachment1.png)

__7.__ Verify correct mounting of the volume in the instance.


### Resizing system volume

Resizing the system volume is not possible. It is however possible to create a backup of the system volume, make necessary changes and deploy new VM with the modified volume.

__1.__ Turn off the instance in **Project &gt; Compute &gt; Instances**.

!!! example

    ![](/assets/openstack/volumes/instance-shutoff.png)

__2.__ First [create a volume backup](#creating-volume-backup).

__3.__ Next [restore volume backup](#restoring-volume-backup), this will create a copy volume that can be attached to new instance.

__4.__ In **Project &gt; Volumes &gt; Volumes** find created backup volume, its name should begin with restore_backup and in the **Actions** menu select **Extend Volume**.

!!! example

    ![](/assets/openstack/volumes/extend1.png)

__5.__ Specify new volume size and press **Extend Volume**.

!!! example

    ![](/assets/openstack/volumes/extend2.png)

__6.__ In **Actions** menu select **Launch as Instance** and deploy a new instance with this volume, or if you need to make additional changes to the volume, you can attach it to another instance via **Manage Attachments**.

!!! example

    ![](/assets/openstack/volumes/launch1.png)
