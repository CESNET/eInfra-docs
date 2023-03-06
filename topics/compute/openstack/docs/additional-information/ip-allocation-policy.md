---

title: IP allocation policy
search:
  exclude: false
---

# IP Allocation Policy

In MetaCentrum Cloud (MCC) we support both IPv4 and IPv6. IPv4 allocation policies are based on Floating IPs (FIP). This type of networking requires the user to first connect virtual network containing specific VM to the public network before allocating a FIP for specific VM. Further information is available on page [Virtual networking](../additional-information/virtual-networking.md). IPv6 allocation policy is based on common IPv6 public network, which can be directly attached to VMs.

If you decide to attach second interface to your VM, you should verify the interface is correctly set. Older VM images have secondary interfaces down by default and some images need further configuration to enable IPv6 SLAAC.

!!! info

    Don't forget to setup security groups accordingly.

## IPv4 Networking

### IPv4 Personal Floating IPs

Is currently limited to the common internal networks. You can start your machine in network `147-251-115-pers-proj-net` or `78-128-250-pers-proj-net` and allocate floating IP address from pools `public-muni-147-251-115-PERSONAL` or `public-cesnet-78-128-250-PERSONAL` respectively. All VMs need to be connected to the same network. You cannot use virtual routers with personal projects. We encourage users to also use IPv6 addresses for long term use. Unassigned allocated addresses are released daily.

### IPv4 Group Floating IPs

The situation is rather different for group projects. You cannot use the same approach as for personal projects. You should create a virtual network as described on page [Create networking](../how-to-guides/create-networking.md) instead and select one of the pools with `-GROUP` suffix as show on page [Allocating floating IPs](../how-to-guides/allocating-floating-ips.md). Namely:

- `public-cesnet-78-128-251-GROUP`
- `public-cesnet-195-113-167-GROUP`
- `public-muni-147-251-21-GROUP`
- `public-muni-147-251-124-GROUP`
- `public-muni-147-251-255-GROUP`

!!! warning

    Addresses that are unassigned for longer than 3 months can be released.


!!! tip

    If you use a MUNI account, you can use `private-muni-10-16-116` and log into the network via MUNI VPN or you can set up Proxy networking, which is described on page [Proxy networking](../additional-information/proxy-networking.md).

### Floating IP Conversion

One floating IP per project should generally suffice. All OpenStack instances are deployed on top of internal OpenStack networks. These internal networks are not by default accessible from outside of OpenStack, but instances on top of the same internal network can communicate with each other.

To access the internet from an instance, or access an instance from the internet, you could allocate floating public IP per instance. Since there are not many public IP addresses available and assigning public IP to every instance is not a security best practice, both in public and private clouds these two concepts are used:

- __Internet access is provided by virtual router__ - all new OpenStack projects are created with group-project-network internal network connected to a virtual router with public IP as a gateway. Every instance created with group-project-network can access the internet through NAT provided by its router by default.
- __I need to access instances by myself__ - best practice for accessing your instances is creating one server with floating IP called [jump host](https://en.wikipedia.org/wiki/Jump_server) and then access all other instances through this host. Simple setup:
    1. Create an instance with any Linux.
    2. Associate floating IP with this instance.
    3. Install [`sshuttle`](https://github.com/sshuttle/sshuttle) on your client.
    4. `sshuttle -r root@jump_host_fip 192.168.0.1/24`. All your traffic to the internal OpenStack network `192.168.0.1/24` is now tunneled through the jump host.
- __I need to serve content (e.g. web service) to other users__ - public and private clouds provide LBaaS (Load-Balancer-as-a-Service) service, which proxies users traffic to instances. MetaCentrum Cloud provides this service in experimental mode.

In case, that these options are not suitable for your use case, you can still request multiple floating IPs.

## IPv6 Networking

### IPv6 Shared Network

We have prepared an IPv6 prefix `public-muni-v6-432`, which is available for both personal and group projects. The network is available as an attachable network for VMs with no limits. For more information please refer to page [Attaching interface](../how-to-guides/attaching-interface.md).
