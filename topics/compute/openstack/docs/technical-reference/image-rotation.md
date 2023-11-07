---

title: Image Rotation
search:
  exclude: false
---

# Image Rotation


## What is it ?
Image rotation in our cloud is a mechanism that keeps all official images up-to-date
with their upstream versions.

## Why is it done?
The latest image versions have up-to-date security patches.

## How does it work ?

Every 2 months, the mechanism checks all official images and compares them with their upstream version.

If any image is not up-to-date, it is "rotated", i.e., its latest version takes its place under the **same** name.

The older image is renamed. Its name is in the format: `{OFFICIAL_IMAGE_NAME}-{ROTATION_DATE}`

=== "Example"

The official image is named:

    ``` 
    centos-7-x86_64
    ```

Mechanism swapped this image and saved its latest version under the same name `centos-7-x86_64`. The older version was renamed to :

    ``` 
    centos-7-x86_64-2021-12-15
    ```
where a suffix `2021-12-15` represents the date image was rotated.

Older images are later still available under **new** name or its original ID.

You can find image ID by using command:

    ```
    openstack image show <IMAGE_NAME | IMAGE_ID>
    ```
    
or 

you can find it in Horizon dashboard by clicking at specific image.

 ![](/compute/openstack/images/image-rotation/select_image_horizon.png)

Older images are kept for another 2 months as **public**. After that their visibility is changed to **community**.

Community images are still available in OpenStack. You can list all community images via command:

    ```
    openstack image list --community
    ```

They will **not** appear in your dashboard however. To use them you have to use CLI command:

    ```
    openstack server create --image <IMAGE_NAME | IMAGE_ID> [ADDITIONAL_PARAMS] <SERVER_NAME>
    ```

After 1 year community images are **deleted** if they are not used anymore.