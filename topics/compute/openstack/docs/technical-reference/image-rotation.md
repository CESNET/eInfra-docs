---

title: Image Rotation
search:
  exclude: false
---

# Image Rotation

Image rotation in our cloud is done on 2 month basis. Timestamps are added to old images.

The naming convention for our images is:

=== "Convention"

    ``` convention
    system-version-instruction_set
    ```

=== "Example"

    ``` example
    centos-7-x86_64
    ```

Old images are renamed with additional timestamp:

=== "Convention"

    ``` convention
    system-version-instruction_set-timestamp
    ```

=== "Example"

    ``` example
    centos-7-x86_64-2021-12-15
    ```

Older images can be later deprecated. If you wish to use specific version of image, we
encourage you to use image ID, which can be obtained by `openstack image show`.

!!! example

    Running CLI command:

    ```
    openstack image show centos-7-x86_64 -f value -c id
    ```

    Returns the image ID:

    ```
    646273fb-7775-4179-86d2-bdbd76f50c6c
    ```
