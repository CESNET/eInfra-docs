---

title: Instances with epehemral disks
search:
  exclude: false
---

# Instances with epehemeral disks
All three cloud instances allows users to create instances with ephemeral disks. Ephemeral disks are saved directly in the hypervisor storage. In G2 clouds we have dedicated 2 types of flavors with prefix p3 and r3. In G1 cloud it is typically specified in the name of the flavor.

Intended use for p3 flavors is as a virtual machine with one Ceph disk (as root) and one ephemeral disk. Flavor r3 is dedicated to having only one ephemeral disk and no ceph disk at all. However by misconfiguration it is possible to create a virtual machine with flavor r3 with only ceph disk instead of an epehemeral disk (as root). 

On G1 this cannot be done from horizon (GUI) and the only possible way is from CLI. On G2 both ways are possible. 

## How to create an instance with epehemral disks.
Creation of an instance with epehemral disk from CLI is similar as one described in [Create First Instance page](https://docs.e-infra.cz/compute/openstack/getting-started/creating-first-infrastructure/#__tabbed_3_2) by skipping the first step "Create volume". 

On horizon GUI, select "No" in "Create New Volume" as you see on screen below (default value is "Yes"). The rest is the same as described in [Create First Instance page](https://docs.e-infra.cz/compute/openstack/getting-started/creating-first-infrastructure/#create-a-virtual-machine-instance).

![](/compute/openstack/images/ephemeral_creation.png)
