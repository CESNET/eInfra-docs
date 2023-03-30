---

title: Custom Images
search:
  exclude: false
---

# Custom Images

We don't support uploading personal images by default.
e-INFRA CZ Cloud images are optimized for running in the cloud and we recommend users to customize them instead of building their own images from scratch. If you need to upload a custom image, please contact user support for appropriate permissions.

## Image Upload

Instructions for uploading a custom image:

1. Upload only images in RAW format (not qcow2, vmdk, etc.).

2. Upload is supported only through OpenStack [CLI](../how-to-guides/obtaining-api-key.md) with Application Credentials.

3. Each image needs to contain metadata:

```
hw_scsi_model=virtio-scsi
hw_disk_bus=scsi
hw_rng_model=virtio
hw_qemu_guest_agent=yes
os_require_quiesce=yes
```

Following needs to be set up correctly (consult [official documentation](https://docs.openstack.org/glance/train/admin/useful-image-properties.html#image-property-keys-and-values)) or instances won't start:

```
os_type=linux # example
os_distro=ubuntu # example
```

4. The image should contain cloud-init, qemu-guest-agent, and grow-part tools

5. OpenStack will resize an instance after the start. The image shouldn't contain any empty partitions or free space

For a more detailed explanation about CLI work with images, please refer to [official documentation](https://docs.openstack.org/python-openstackclient/pike/cli/command-objects/image.html).

## Image Visibility

In OpenStack there are 4 possible visibilities of a particular image: **public**, **private**, **shared**, **community**.

You can view these images via **CLI** or in a **dashboard**.

In the **dashboard**, visit the *Images* section and then you can search via listed image and/or set searching criteria in search bar. There is a *Visibility* parameter where you can specify visibility of image you are searching for. These visibility parameters are explained below.

![](/compute/openstack/images/image_visibility.png)

### Public Images

**Public image** is an image visible and readable to everyone. Only OpenStack admins can modify them.

### Private Images

**Private image** is an image visible only to the owner of that image. This is the default setting for all newly created images.

### Shared Images

**Shared image** is an image visible only to the owner and possibly certain groups that the owner specified. To learn how to share an image between projects, read the following [tutorial](#image-sharing-between-projects) below. Image owners are responsible for managing shared images.

### Community Images

**Community image** is an image that is accessible to everyone. Image owners are responsible for managing community images.
Community images are visible in the dashboard using a `Visibility: Community` query. These images can be listed via CLI command:

```
openstack image list --community
```

This is especially beneficial in case of a great number of users who should get access to this image or if you own an old image but some users might still require that image. In that case, you can set the old image as **Community image** and set the new one as default.

!!! info

    To create or upload this image you must have an **image_uploader** rights.


Example of creating a new **Community image**:

```
openstack image create --file test-cirros.raw --property hw_scsi_model=virtio-scsi --property hw_disk_bus=scsi --property hw_rng_model=virtio --property hw_qemu_guest_agent=yes --property os_require_quiesce=yes --property os_type=linux --community test-cirros
```

!!! note

    References to existing community images should use `<image-id>` instead of `<image-name>`. See [image visibility](https://wiki.openstack.org/wiki/Glance-v2-community-image-visibility-design) document for more details.


## Image Sharing Between Projects

There are two ways of sharing an OpenStack Glance image among projects, using `shared` or `community` image visibility.

### Shared Image Approach

Image sharing allows you to share your image between different projects and then it is possible to launch instances from that image in those projects with other collaborators, etc. As mentioned in a section about CLI, you will need to use your OpenStack credentials from the `openrc` or `cloud.yaml` file.

Then to share an image you need to know its ID, which you can find with the command:

```
openstack image show <name_of_image>
```

where `name_of_image` is the name of the image you want to share.

After that, you will also have to know the ID of the project you want to share your image with. If you do not know the ID of that project you can use the following command:

```
openstack project list | grep <name_of_other_project>
```

where `<name_of_project>` is the name of the other project. Its ID will show up in the first column.

Now with all the necessary IDs, you can share your image. First, you need to set an attribute of the image to `shared`:

```
openstack image set --shared <image_ID>
```

And now you can share it with your project:

```
openstack image add project <image_ID> <ID_of_other_project>
```

where `ID_of_other_project` is the ID of the project you want to share the image with.

Now you can check if the user of the other project accepted your image:

```
openstack image member list <image_ID>
```

If the other user did not accept your image yet, the status column will contain the value: `pending`.

**Accepting shared image**

To accept a shared image you need to know `<image_ID>` of the image that the other person wants to share with you. To accept a shared image to your project, use the following command:

```
openstack image set --accept <image_ID>
```

You can then verify that by listing your images:

```
openstack image list | grep <image_ID>
```

**Unshare shared image**

As an owner of the shared image, you can check all projects that have access to the shared image:

```
openstack image member list <image_ID>
```

When you find `<ID_project_to_unshare>` of the project, you can cancel the access of that project to the shared image:

```
openstack image remove project <image ID> <ID_project_to_unshare>
```

### Community Image Approach

This approach is very simple:

 1. Mark an image as `community` (`openstack image set --shared <image_ID>`)
 1. Now everyone can use the community image, but there are two limitations:
    * to list community images you **have to** specify visibility (in UI: `Visibility: Community`, cli: `openstack image list --community`)
    * to use any community image you **have to** use `<image_ID>` (references via `<image_name>` result in NOT FOUND)
