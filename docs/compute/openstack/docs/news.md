---
title: "MetaCentrum Openstack Cloud"
---

**2022-04-04** OpenStack loadbalancer Octavia reconfigured to increase stability and add support for [loadbalancer HA (amphorae active/standby) mode](https://docs.openstack.org/octavia/latest/contributor/specs/version0.8/active_passive_loadbalancer.html). Remaining issues with LBaaS component were addressed.

_____

**2022-03-14** New public networks added to OpenStack:

* IPv4 group network: `public-cesnet-195-113-167-GROUP`
* IPv4 personal network: `public-muni-147-251-115-PERSONAL`
* IPv6 network: `public-muni-v6-432`

Additional information is available on [Networking](/cloud/network/) page.

_____

**2022-03-07**
1. OpenStack cloud security review and related improvements
2. [Centos 8 cloud images are going to be deprecated in comming weeks](https://www.centos.org/centos-linux-eol/) in favor of Almalinux 8

_____

**2022-02-21** Openstack cloud internal Monasca monitoring services were replaced by Prometheus, Thanos & Alertmanager.

_____

**2021-12-13**
1. Coref cluster was handed over, it is not ready for use yet
2. Automatic image rotation mechanism was added.

_____

**2021-12-06** Monasca software update.

_____

**2021-10-27** Upgrade cloud infrastructure proxy to Traefik 2.5, related issues resolved. (Openstack VM instance console not available)

_____

**2021-09-07** New cloud infrastructure monitoring based on prometheus.io technologies added.

_____

**2021-06-19** Flavors *hpc.xlarge*, *hpc.18core-48ram* and *hpc.16core-128ram* have parameters *IOPS*, *net throughput* and *disk throughput* set as **Unlimited**.

_____

**2021-05-21** Flavor list was created and published. Also parameters of following flavors were changed:

* hpc.8core-64ram
* hpc.8core-16ram
* hpc.16core-32ram
* hpc.18core-48ram
* hpc.small
* hpc.medium
* hpc.large
* hpc.xlarge
* hpc.xlarge-memory
* hpc.16core-128ram
* hpc.30core-64ram
* hpc.30core-256ram
* hpc.ics-gladosag-full
* csirtmu.tiny1x2

None of the parameters were decreased but increased. Updated parameters were net throughput, IOPS, and disk throughput. Existing instances will have the previous parameters so if you want to get new parameters, **make a data backup** and rebuild your instance  You can checklist of flavors [here](/cloud/flavors).

_____

**2021-04-13** OpenStack image `centos-8-1-1911-x86_64_gpu` deprecation in favor of `centos-8-x86_64_gpu`. The deprecated image will be still available for existing VM instances but will be moved from public to community images in about 2 months.

**2021-04-05** OpenStack images renamed

_____

**2021-03-31** User documentation update

_____

**2020-07-24** Octavia service (LBaaS) released

_____

**2020-06-11** [Public repository](https://gitlab.ics.muni.cz/cloud/cloud-tools) where Openstack users can find usefull tools

_____

**2020-05-27** Openstack was updated from `stein` to `train` version

_____

**2020-05-13** Ubuntu 20.04 LTS (Focal Fossa) available in image catalog

_____

**2020-05-01** Released [Web page](https://projects.cloud.muni.cz/) for requesting Openstack projects

