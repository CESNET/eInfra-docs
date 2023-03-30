---

title: Object Storage
search:
  exclude: false
---

## Object Storage

OpenStack supports object storage based on [OpenStack Swift](https://docs.openstack.org/swift/latest/api/object_api_v1_overview.html). Creation of an object storage container (database) is done by clicking on `+Container` on [Object storage containers page](https://dashboard.cloud.muni.cz/project/containers).

Every object typically contains data along with metadata and a unique global identifier to access it. OpenStack allows you to upload your files via an HTTPS protocol. There are two ways of managing a created object storage container:

1. Use OpenStack component [Swift](https://docs.openstack.org/swift/train/admin/index.html)

2. Use [S3 API](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)

In both cases, you will need application credentials to be able to manage your data.

### Swift Credentials

The easiest way to generate **Swift** storage credentials is through [MetaCentrum cloud dashboard](https://dashboard.cloud.muni.cz). You can generate application credentials as described in the [Obtaining API Key](../how-to-guides/obtaining-api-key.md) section.
You must have the **heat_stack_owner** role.

### S3 Credentials

If you want to use **S3 API** you will need to generate ec2 credentials for access. Note that to generate ec2 credentials you will also need credentials containing the role of **heat_stack_owner**. Once you sourced your credentials for CLI, you can generate ec2 credentials:

```
$ openstack ec2 credentials create          
+------------+------------------------------------------------------------------+
| Field      | Value                                                            |
+------------+------------------------------------------------------------------+
| access     | 896**************************651                                 |
| project_id | f0c**************************508                                 |
| secret     | 336**************************49c                                 |
...
| user_id    | e65***********************************************************6a |
+------------+------------------------------------------------------------------+
```

Then you may use one of the s3 clients (minio client mc, s3cmd, ...)
Running minio client against created object storage container is very easy:

```
$ MC config host add swift-s3 https://object-store.cloud.muni.cz  896**************************651 336**************************49c --api S3v2
Added `swift-s3` successfully.

$ MC ls swift-s3
[2021-04-19 15:13:45 CEST]     0B freznicek-test/
```

s3cmd client requires a configuration file that looks like this:
In this case please open your file with credentials that will look like this:

```
[default]
access_key = 896**************************651
secret_key = 336**************************49c
host_base = object-store.cloud.muni.cz
host_bucket = object-store.cloud.muni.cz
use_https = True
```

For more information, please refer to [https://docs.openstack.org/swift/latest/s3_compat.html](https://docs.openstack.org/swift/latest/s3_compat.html) and [https://docs.openstack.org/mitaka/config-reference/object-storage/configure-s3.html](https://docs.openstack.org/mitaka/config-reference/object-storage/configure-s3.html).
