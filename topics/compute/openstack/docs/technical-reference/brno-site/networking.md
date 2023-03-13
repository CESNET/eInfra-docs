---

title: Networking
search:
  exclude: false
---

# Networking

## IPv4 Networking

### IPv4 Personal Floating IPs

Is currently limited to the common internal networks. You can start your machine in network `147-251-115-pers-proj-net` or `78-128-250-pers-proj-net` and allocate floating IP address from pools `public-muni-147-251-115-PERSONAL` or `public-cesnet-78-128-250-PERSONAL` respectively. All VMs need to be connected to the same network. You cannot use virtual routers with personal projects. We encourage users to also use IPv6 addresses for long term use. Unassigned allocated addresses are released daily.

### IPv4 Group Floating IPs

The situation is rather different for group projects. You cannot use the same approach as for personal projects. You should create a virtual network as described on page [Create networking](../../how-to-guides/create-networking.md) instead and select one of the pools with `-GROUP` suffix as show on page [Allocating floating IPs](../../how-to-guides/allocating-floating-ips.md). Namely:

 - `public-cesnet-78-128-251-GROUP`
 - `public-cesnet-195-113-167-GROUP`
 - `public-muni-147-251-21-GROUP`
 - `public-muni-147-251-124-GROUP`
 - `public-muni-147-251-255-GROUP`

!!! warning

    Addresses that are unassigned for longer than 3 months can be released.


!!! tip

    If you use a MUNI account, you can use `private-muni-10-16-116` and log into the network via MUNI VPN or you can set up Proxy networking, which is described on page [Proxy networking](../../additional-information/proxy-networking.md).

## IPv6 Networking

### IPv6 Shared Network

We have prepared an IPv6 prefix `public-muni-v6-432`, which is available for both personal and group projects. The network is available as an attachable network for VMs with no limits. For more information please refer to page [Attaching interface](../how-to-guides/attaching-interface.md).
