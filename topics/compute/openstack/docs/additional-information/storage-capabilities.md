---

title: Storage Capabilities
search:
  exclude: false
---

# Storage Capabilities

Default MetaCentrum Cloud storage is implemented via the CEPH storage cluster deployed on top of HDDs. This configuration should be sufficient for most cases.
For instances, that require high throughput and IOPS, it is possible to utilize hypervisor local SSDs. Requirements for instances on hypervisor local SSD:

* instances can be deployed only via API (CLI, Ansible, Terraform ...), instances deployed via web GUI (Horizon) will always use CEPH for its storage
* supported only by flavors with the `ssd-ephem` suffix (e.g. `hpc.4core-16ram-ssd-ephem`); if you can't locate flavors on your screen, you can request these by dropping e-mail to cloud@metacentrum.cz
* instances can be rebooted without prior notice or you can be required to delete them
