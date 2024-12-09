---

title: Networking
search:
  exclude: false
---

# Networking

## IPv4

There are 2 generally available external networks, which you can allocate floating IP addresses (FIPs) from:

- `external-ipv4-general-public` (recommended)
    - This network has 2 address pools:
        - `147.251.245.0/24`
        - `147.251.255.0/24`
    - FIPs from this network are publicly accessible.
- `external-ipv4-general-muni`
    - This network has 1 address pool:
        - `10.16.176.0/20`
    - FIPs from this network are NOT publicly accessible, they can only be reached from within the Masaryk University (internal Masaryk University network).
    - Please be aware that your instances in personal and group projects will typically be connected to internal networks which do not provide
      a route to this external network.
      In case of group projects, you can bypass this limitation by creating a new router with a gateway to the external network `external-ipv4-general-muni`
      and interface in your internal network.
      See [Create Router How-to Guide](../../../how-to-guides/create-router).


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
This is especially true if you want to use the `external-ipv4-general-muni` external network ([see above](#ipv4)).


## IPv6

Currently in Brno G2 site, you can use following IPv6 network:

- ~~`external-ipv6-general-public` (2001:718:801:43b::/64)~~ (not GA yet, in testing as of 2024-12-06)


## Security groups

Apart from the `default` [security group](../../../additional-information/security-groups), every project in the OpenStack cloud also contains pre-generated security group `ssh`. Rules of the `ssh` groups enable access to virtual servers via SSH protocol (IPv4+IPv6).
