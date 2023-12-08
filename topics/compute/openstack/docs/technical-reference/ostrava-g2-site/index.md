---
title: About e-INFRA CZ Openstack G2 Cloud Ostrava Site
search:
  exclude: false
---

# [G2 e-INFRA CZ Openstack Cloud Ostrava Site (g2-prod-ostrava)](https://ostrava.openstack.cloud.e-infra.cz/)

[IaaS OpenStack cloud](https://ostrava.openstack.cloud.e-infra.cz/) providing cloud services for following organizations:

 - [e-INFRA CZ](https://www.e-infra.cz/en) / [IT4Innovation](https://www.it4i.cz/en)


## Hardware

Ostrava cloud site consists of 22 nodes from [Karolina supercomputer](../../../supercomputing/karolina/compute-nodes/#cloud-compute-node).

## Software, cloud versions and components

E-INFRA CZ Ostrava cloud site is built on top of [OpenStack](https://www.openstack.org/), which is a free open standard IaaS cloud computing platform
and one of the top 3 most active open source projects in the world. New OpenStack major versions are
released twice a year. OpenStack functionality is separated into more than 50 services.


[OpenStack Yoga](https://www.openstack.org/software/yoga/) and [Kubernetes 1.24.14](https://kubernetes.io/blog/2022/05/03/kubernetes-1-24-release-announcement/) underneath are used.


[Following OpenStack components are available](./openstack-components.md).

Cloud architecture strictly follows [IaC](https://en.wikipedia.org/wiki/Infrastructure_as_code), [GitOps](https://opengitops.dev/) approaches to minimize [cloud maintenance toil](https://sre.google/workbook/eliminating-toil/).

## Cloud workload


## Other Techical Info Specific for This Site

 * [List of flavors](./flavors.md)
 * [How to get access](./get-access.md)
 * [Info on networking](./networking.md)
 * [Support](./get-support.md)
 * [Info on quotas](./quota-limits.md)
 * [Specific FAQ](./faq.md)
