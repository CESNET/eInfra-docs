---

title: Networking
search:
  exclude: false
---

# Networking

Currently in Brno G2 site you can use following floating IP networks:

- `external-ipv4-general-public-147-251-255-0` (147.251.255.0/24)
- `external-ipv4-general-public-2001-718-801-43b` (2001:718:801:43b::/64)

## Security groups

Apart from the `default` [security group](../../../docs/additional-information/security-groups.md), every project in OpenStack cloud contains also pre-generated security group `ssh`. Rules of the `ssh` groups enables access to virtual servers via SSH protocol.
