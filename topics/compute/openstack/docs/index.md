---

title: Overview
search:
  exclude: false
hide:
  - toc
---

# About e-INFRA CZ IaaS cloud
e-INFRA CZ Cloud consists of 2 sites, 17 computational clusters containing 277 hypervisors with a sum of 8968 cores, 96 GPU cards, and 178 TB RAM in two geographical locations Brno and Ostrava. Special demand applications can utilize our clusters with local SSDs and GPU cards. OpenStack instances, object storage and image storage can leverage more than 1.5 PTB of highly available data storage provided by the CEPH storage system.

More than 400 users are using the MetaCentrum Cloud platform and more than 130k VMs were started last year.

[Read more about e-INFRA CZ Infrastructure as a Service][readmore]

# How to read the documentation
OpenStack Cloud documentation is structured into four logical parts, namely Getting started, How-to guides, Technical reference and Additional information. In each section you can find information based on specific perspective.

**Getting started**   
This section focuses on tutorials and aims to show step by step how to how to use the infrastructure.

**How-to guides**   
Guides aim to show how to solve specific problems.

**Technical reference**   
This section contains mainly operational information about the e-INFRA CZ Openstack Cloud (definition of flavors, networking policy, OpenStack internals) that could be necessary when deploying an infrastructure in Brno or Ostrava site.

  * [Technical details of **Brno** cloud site][tech-brno]   
  * [Technical details of **Ostrava** cloud site][tech-ost]   

**Additional information**   
This section desribes further information and problems that users can approach when using e-INFRA CZ  Openstack Cloud.

[readmore]: https://www.cerit-sc.cz/infrastructure-services/data-processing/cloud-service
[tech-brno]: ./technical-reference/brno-site/
[tech-ost]: ./technical-reference/ostrava-site/