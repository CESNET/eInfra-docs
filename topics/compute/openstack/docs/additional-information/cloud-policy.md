---

title: Cloud Policy
search:
  exclude: false
---

# Cloud Policy

This document describes operational rules imposed by CESNET on its cloud facilities. It documents technical measures developed to achieve a reasonable level of operational security of the cloud service. The main goal of this document is to define measures and rules to limit security risks posed by cloud applications and users, and to provide feasible mechanisms to ease resolution of security incidents that might happen in the cloud facilities.

The document was built with the existing [EGI security policies](https://confluence.egi.eu/display/EGIPP/EGI+Federation+Policies+and+Procedures+Home) in mind. Whenever applicable, we refer to existing policies to define the scope needed. For example, whenever 'image endorsement' is mentioned, we refer to the [Security Policy for the Endorsement and Operation of Virtual Machine Images](https://documents.egi.eu/document/771). Other policies, however, deal with "classic" sites, and the cloud technology presents some additional facts that are not taken into account. For instance, the cloud provider (site) cannot guarantee proper patch management of the systems (since the machines might not be operated directly by the site people). We are aware of the new class of problems, though, and we realise the problems may lead to security incidents that may differ from what we face with classic grid sites. We expect some new policies will be formed. For example, from the user's point point we are missing a policy similar to the [Policy on Grid Pilot Jobs](https://documents.egi.eu/document/84), which would define e.g. the responsibilities of VM owners. As an interim step however, we decided to specify measures defined to facilitate efficient security operations and streamline the incident response and users' traceability to a level which is feasible in our cloud environment. 

## Workload migration

The OpenStack cloud service administrators reserve the right to migrate the project to another instance of the OpenStack cloud. The user will be notified of this in advance. User collaboration with the service administrator will be required during the migration. More details will be available at [https://docs.e-infra.cz/compute/openstack/migration-to-g2-openstack-cloud](https://docs.e-infra.cz/compute/openstack/migration-to-g2-openstack-cloud).

## Cloud resource life-cycle (deallocation rules)

The OpenStack cloud service administrators follow below listed rules in order to grant available cloud resources responsibly.

### General project resources life-cycle rules (both personal and group projects)

- Virtual machines which are unused turned off for consecutive 30 days are automatically shelved. This means that data will be kept, but all other resources (like RAM and CPU) will be deallocated. The machine can be started again by [unshelving the VM instance](https://creodias.eu/-/a-9-32). Users are notified in advance.

### The personal project resources life-cycle rules

- The personal project as a low-barrier entry into the cloud infrastructure for testing and exploration of features is permanently granted to anyone with valid e-INFRA CZ membership. Although the personal project itself is permanent, the cloud resources associated with that project are ephemeral (temporary). Cloud resources associated there are watched and if AT LEAST ONE cloud resource is older than 6 months (based on creation timestamp metadata) then ALL resources in the personal project may be deallocated (deleted) according to the administrator's decision.
- The OpenStack cloud service administrators inform (via email) the cloud user in advance before the personal project resource deallocation. At the end the cloud resources are permanently deleted or migrated to the longer-term group project.
- MetaCentrum Cloud administrators are authorised to deallocate resources occupied by the personal project once the e-INFRA CZ / MetaVO membership expires following way:
    - Deactivation of the active resources after 7 days from expiration.
    - Transfer of all project data from hypervisors to disk storage after 30 days from expiration.
    - Blocking access to resource management 30 days from expiration.
    - Deletion of project data will take place no earlier than 3 months from expiration.

### The group project resources life-cycle rules

Following rules are applied to various unused group project resources in order to maximise the amount of available cloud resources.

- Public IPv4 addresses which are allocated but not used (i.e. not attached to a virtual machine and/or not having an active Neutron port) are automatically returned to the shared pool of public addresses. Users are notified in advance.
- After the expiration of the group project, the MetaCentrum Cloud administrator is authorised to deallocate resources occupied by the project as follows:
    - Deactivation of active resources after 60 days from expiration.
    - Transfer of all project data from hypervisors to disk storage after 90 days from expiration.
    - Blocking access to resource management 90 days from expiration.
    - Deletion of project data will occur after 3 years from expiration.

## Security measures

### Pre-runtime measures
#### Endorsed images

- endorsements for virtual machine images implemented
    - directly, as cryptographically signed hashes
    - indirectly, based on verbal agreements
- only virtual machine instances based on endorsed images are allowed to have public IP addresses
- modified and subsequently saved images are no longer considered to be endorsed by the original endorser

#### Trusted users

- trusted users defined as users with
    - high-level identity verification
    - explicit endorsement from other trusted users or site managers
- only trusted users have access to pools of public IP addresses

#### Restricted remote access to running virtual machines

- only the following combinations of access methods and authentication methods are allowed
    - SSH with public key authentication
    - SSH with GSS API authentication
    - Encrypted RDP/VNC
- password-based remote authentication methods are not allowed (e.g. SSH with a plain password)

#### Automated pre-runtime compliance testing

- all virtual machine images and virtual machine instances based on said images must be tested for explicit compliance with the defined security profile
- only compliant images and virtual machine instances based on said images can
    - be published (made available to other users)
    - be assigned public IP addresses
    - be launched outside isolated private networks

### Runtime measures
#### Networking insolation for L2

- running virtual machine instance will be isolated in a VLAN if
    - image the instance is based on is not endorsed by a trusted user
    - it does not belong to a trusted user
    - it is running OS Windows
    - its owner chooses to isolate it

#### Networking isolation for L3

- running virtual machine instance will be isolated using firewall if
    - it has a public IP address
    - its owner chooses to isolate it in a private network

#### IP logging

- every IP address given to a virtual machine instance will be tied to its owner for the duration of its lifetime (i.e. until shutdown)
- owner of the virtual machine instance is responsible for any illegal activity during its lifetime

#### Anti-spoofing rules for networking

- network addresses assigned to a virtual machine instance by the cloud platform are mandatory and cannot be changed by the owner at runtime
- anti-spoofing rules are enforced by the hypervisor or local network infrastructure
- an attempt to change the assigned network addresses will immediately cut off the virtual machine instance from any subsequent network communication

#### Automated runtime compliance testing

- all running virtual machine instances are periodically tested for compliance with the defined security profile
- repeated or long-running non-compliance will result in an immediate forced shutdown of the given instance

#### Automated configuration changes in virtual machines

- all virtual machine images must support contextualization to the following extent
    - boot-time injection of a public key for the root user (where applicable)
    - boot-time change of the RDP/VNC credentials (where applicable)

### Post-runtime measures
#### Extraction of virtual machine logs

- at the end of its lifetime (i.e. after shutdown), the contents of /var/log from the root file system of every virtual machine instance will be archived

#### Extraction of timestamps

- at the end of its lifetime (i.e. after shutdown), timestamps from the root file system of every virtual machine instance will be archived

## Incident Response

- In case of a security incident happening on a virtual machine, its owner has to provide assistance and cooperate with the Metacentrum Cloud Team and/or Metacentrum Security team if necessary. Users which are not helping to resolve such incidents may permanently lose access to the MetaCentrum OpenStack cloud.
- During an active security incident, Metacentrum Cloud Team and security teams are authorised to create a copy of virtual disks (volumes) of the affected machine(s) and inspect its content to find the source of the security incident.
