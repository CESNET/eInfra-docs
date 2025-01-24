---

title: "Get Access"
search:
  exclude: false
---

# How to Get Access

[Access to e-INFRA OpenStack Cloud](https://brno.openstack.cloud.e-infra.cz/) is granted to users
with active accounts in one of the following identity federations:

* __EINFRA CESNET__,

Users from the Czech academic community should always use the `EINFRA CESNET`
identity provider, unless instructed otherwise by user support.
Identity providers marked with `*` should only be used by international
communities with explicitly negotiated resource allocations.

MetaCentrum Cloud provides the following ways for allocating resources

* __personal project__,
* __group project__.

!!! caution
	By the date 1.10.2024, it is necessary to be registered on [MetaCentrum](https://metavo.metacentrum.cz/en/), more information provided on [Necessity of being part of MetaCentrum](metacentrum.md).

## Personal Project

A personal project goal is to gain cloud environment knowledge.

!!! important
	Please note that personal projects are intended for temporary use. This means the resources allocated to these projects may be reset periodically, approximately twice a year. The primary reason for this ephemerality is to ensure effective use of cloud resources. Any virtual machines intended for long-term use must be part of group projects. This guideline is in accordance with our [terms of service](../../additional-information/terms-of-service.md).

!!! caution
	A personal project resource allocation quotas are fixed and cannot be changed.

Personal projects are available automatically to all users of the MetaCentrum.

To register, follow the instructions for
[registration in the MetaCentrum VO](https://metavo.metacentrum.cz/en/application/index.html).

Personal projects are intended as a low-barrier entry
into the infrastructure for testing and exploration of features.
Any serious resource usage requires the use of a group project, see below.

The following already established terms and conditions apply:

* [Terms and Conditions for Access to the CESNET e-infrastructure](https://www.cesnet.cz/conditions/?lang=en)
* [MetaCentrum End User Statement and Usage Rules](https://www.metacentrum.cz/en/about/rules/index.html)
* [Appreciation Formula / Acknowlegement in Publications](https://wiki.metacentrum.cz/wiki/Usage_rules/Acknowledgement)
* [Account Validity](https://wiki.metacentrum.cz/wiki/Usage_rules/Account)
* [Annual Report](https://wiki.metacentrum.cz/wiki/MetaCentrum_Annual_Report_%E2%88%92_Author_Instructions)

## Group Project

!!! notice
	Preferred way to request new <a href="https://cloud.gitlab-pages.ics.muni.cz/documentation/register/#group-project">GROUP</a> project is through this online application form: <a href="https://projects.brno.openstack.cloud.e-infra.cz/create.php">https://projects.brno.openstack.cloud.e-infra.cz/create.php</a>

Group projects are the primary resource allocation unit for MetaCentrum Cloud.
Any user or a group of users requiring a non-trivial amount of resources must
request a group project using [this form](https://projects.brno.openstack.cloud.e-infra.cz/create.php) and provide the following basic information:

* __name of the project__,
* __purpose of the project__,
* __contact information__,
* __amount and type of requested resources__,
* __impact would the service have on unavailability for 1h, 1d, 1w__,
* __estimated length of the project__,
* __project manager (project invertigator)__,
* __project organization__,
* __access control information__ _[(info)](#get-access-control-information)_.

## Increase Quotas for Existing Group Project

To request quota increase, access to particular [flavor](flavors.md) or extend project lifetime, please use [this form](https://projects.brno.openstack.cloud.e-infra.cz/update.php).
