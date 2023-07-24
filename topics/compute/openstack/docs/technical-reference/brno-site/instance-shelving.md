---

title: Instance shelving
search:
  exclude: false
---

# Instance shelving 

[OpenStack instance shelving](https://docs.openstack.org/ocata/user-guide/cli-stop-and-start-an-instance.html#shelve-and-unshelve-an-instance) allows you to stop an instance without having it consume any cloud hypervisor resources. A shelved instance will be retained as a bootable instance, as well as its resources assigned, such as an IP address in distributed storage, for a configurable amount of time, and then deleted. This is useful as part of an instance life cycle process or to conserve resources.

## What does instance shelving do ?

It creates a snapshot of the state of the **running** instance, containing instance data and resource allocations. Data in memory is **not** retained, however. The instance then goes into a **Shelved Offloaded** state and shuts itself down. Once the instance is required again, it is **unshelved** and restored to a running state with all resources and data.

## How to shelve your instance ?

There are two possible ways to shelve your instance:

1. Via GUI
2. Via command line

### GUI shelving

Go into your instance list, located at the left menu bar on the path **Project>Compute>Instances**. Then you select the **Actions** menu located on the right side of the listed instances. After that, choose the **running** instance to shelve and select from the **Actions** menu the option **Shelve Instance** and click it.

![](/compute/openstack/images/instance-shelving/shelving.png)

Once the shelving process finishes, you can check that the instance is in the status **Shelved Offloaded** and its power state is **Shut Down**.

![](/compute/openstack/images/instance-shelving/shelving_status.png)

Now the instance is offloaded from the computational host, and you can use resources from the shelved instance.

Once you are finished and wish to restore your instance to a running state, go and select the option **Unshelve Instance** from **Actions** menu and click it.
 
 ![](/compute/openstack/images/instance-shelving/unshelving_status.png)

### CLI shelving

Select an instance in **Active** status from the list of instances you wish to shelve.

```
# openstack server list --status active 

+--------------------------------------+--------------+--------+--------------------------------------+-------+---------------+
| ID                                   | Name         | Status | Networks                             | Image | Flavor        |
+--------------------------------------+--------------+--------+--------------------------------------+-------+---------------+
| 59f02d12-**************-f02d7731d13c | vm-to-shelve | ACTIVE | ********************                 |       | standard.tiny |
+--------------------------------------+--------------+--------+--------------------------------------+-------+---------------+
```

Use the following command to shelve that instance.

```
openstack server shelve {NAME_OF_INSTANCE|ID_OF_INSTANCE}
```
After that, you can check that the selected instance is no longer in **Active** status. It is in **Shelved Offloaded**. Resources were freed and are now at your disposal and ready to use.

```
# openstack server shelve vm-to-shelve

# openstack server list --status active 

# openstack server list

+--------------------------------------+--------------+-------------------+--------------------------------+-------+---------------+
| ID                                   | Name         | Status            | Networks                       | Image | Flavor        |
+--------------------------------------+--------------+-------------------+--------------------------------+-------+---------------+
| 59f02d12-**************-f02d7731d13c | vm-to-shelve | SHELVED_OFFLOADED | *******************            |       | standard.tiny |
+--------------------------------------+--------------+-------------------+--------------------------------+-------+---------------+

```

After you are finished with your work, you can easily restore the shelved instance by running this command:

```
openstack server unshelve {NAME_OF_INSTANCE|ID_OF_INSTANCE}
```

 Once the command is finished, you can check if your instance is restored and in a running state.

```
# openstack server unshelve vm-to-shelve

# openstack server list --status active 

+--------------------------------------+--------------+--------+--------------------------------------+-------+---------------+
| ID                                   | Name         | Status | Networks                             | Image | Flavor        |
+--------------------------------------+--------------+--------+--------------------------------------+-------+---------------+
| 59f02d12-**************-f02d7731d13c | vm-to-shelve | ACTIVE | ********************                 |       | standard.tiny |
+--------------------------------------+--------------+--------+--------------------------------------+-------+---------------+
```