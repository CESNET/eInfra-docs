---

title: Networking
search:
  exclude: false
---

# Networking

## IPv4

There are 2 generally available external networks, which you can allocate floating IP addresses (FIPs) from:

- `external-ipv4-general-public` (recommended)
    - This network has address pool `195.113.243.0/24`.
    - FIPs from this network are publicly accessible.


### Personal Projects

Due to limited resources available in personal projects, the easiest way is to connect your instances to the shared internal network:

- `internal-ipv4-general-private`

From this network, you will be able to allocate a floating IP address from the external network:

- `external-ipv4-general-public`


### Group Projects

By default, group projects are provided with a default internal network:

- `group-project-network` (192.168.0.0/24)

This network already has a route to the recommended external network `external-ipv4-general-public`, which means you can associate FIPs from this
external network to instances connected to the default internal network.

You may also use the `internal-ipv4-general-private` internal network with the same effect.

In case you create your own internal network (see [Create Networking How-to Guide](../../../how-to-guides/create-networking)), you need to handle the routing
yourself, i.e. create a new router (see [Create Router How-to Guide](../../../how-to-guides/create-router)), if you want to assign FIPs from an external network
to your instances.


## Security groups

Apart from the `default` [security group](../../../additional-information/security-groups), every project in the OpenStack cloud also contains pre-generated security group `ssh`. Rules of the `ssh` groups enable access to virtual servers via SSH protocol (IPv4+IPv6).
