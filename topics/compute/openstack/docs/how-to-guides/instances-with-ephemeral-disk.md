---

title: Instances with epehemral disks
search:
  exclude: false
---

# Instances with epehemeral disks
All three cloud instaces allows user to create instaces with ephemeral disks. Ephemeral disks are saved directly in hypervisor storage. In G2 clouds we have dedicated 2 types of flavors with prefix p3 and r3. In G1 cloud it is typically specified in name of the flavor.

Intended use for p3 flavors is as virutal machine with one ceph disk (as root) and one ephemeral disk. Flavor r3 is dedicated to have only one ephemeral disk and no ceph disk at all. However by misconfiguration it is possible to create virtual machine with flavor r3 with only ceph disk instead of epehemeral disk (as root). 

On G1 this cannot be done from horizon (GUI) and only possible way is from cli. On G2 both ways are possible. 

## How to create instance with epehemral disks.
Creation o instance with epehemral disk from cli is similar as one described in [Create First Instance page](https://docs.e-infra.cz/compute/openstack/getting-started/creating-first-infrastructure/#__tabbed_3_2) with skip of first step "Create volume". 

On horizon GUI is needed in "Create New Volume" mark "No" as you see on screen below (default value is "Yes"). The rest is same as described in [Create First Instance page](https://docs.e-infra.cz/compute/openstack/getting-started/creating-first-infrastructure/#create-a-virtual-machine-instance).

![](/compute/openstack/images/ephemeral_creation.png)
