---

title: Overview
search:
  exclude: false
hide:
  - toc
---

# About e-INFRA CZ IaaS Cloud

e-INFRA CZ Cloud consists of 3 cloud instances ([G1 Brno](./technical-reference/brno-g1-site/index.md), [G2 Brno](./technical-reference/brno-g2-site/index.md), [G2 Ostrava](./technical-reference/ostrava-g2-site/index.md)), 17 computational clusters containing 277 hypervisors with a sum of 8968 cores, 96 GPU cards, and 178 TB RAM in two geographical locations –⁠⁠⁠ Brno and Ostrava. Special demand applications can utilize our clusters with local SSDs and GPU cards. OpenStack instances, object storage, and image storage can leverage more than 1.5 PTB of highly available data storage provided by the CEPH storage system.

There are over 1500 unique Cloud platform users working in more than 1200 projects.

Read more about [new generation (G2) of e-INFRA CZ OpenStack IaaS clouds](./technical-reference/why-g2-cloud.md) and [related services][readmore].

# How to Read the Documentation

OpenStack Cloud documentation is structured into four logical parts, namely *Getting started*, *How-to Guides*, *Technical Reference* and *Additional Information*. In each section, you can find information based on a specific perspective.

**Getting Started**   
This section focuses on tutorials and aims to show step by step how-tos for using the infrastructure.

**How-to Guides**   
Guides aim to show how to solve specific problems.

**Technical Reference**   
This section contains mainly operational information about the e-INFRA CZ Openstack Cloud (definition of flavors, networking policy, OpenStack internals) that could be necessary when deploying an infrastructure in Brno or Ostrava site.

  * [Technical details of **Brno G1** cloud site][tech-g1-brno]   
  * [Technical details of **Ostrava G2** cloud site][tech-g2-ost]   
  * [Technical details of **Brno G2** cloud site][tech-g2-brno]

**Additional Information**   
This section describes further information and problems that users can approach when using e-INFRA CZ Openstack Cloud.

[readmore]: https://www.cerit-sc.cz/infrastructure-services/data-processing/cloud-service
[tech-g1-brno]: ./technical-reference/brno-g1-site/
[tech-g2-ost]: ./technical-reference/ostrava-g2-site/
[tech-g2-brno]: ./technical-reference/brno-g2-site/
