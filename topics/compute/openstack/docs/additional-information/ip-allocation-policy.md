---

title: IP Allocation Policy
search:
  exclude: false
---

# IP Allocation Policy

In MetaCentrum Cloud (MCC) we support both IPv4 and IPv6. IPv4 allocation policies are based on Floating IPs (FIP). This type of networking requires the user to first connect virtual network containing specific VM to the public network before allocating a FIP for specific VM. Further information is available in the [Virtual networking](../additional-information/virtual-networking.md) section. IPv6 allocation policy is based on a common IPv6 public network, which can be directly attached to VMs.

If you decide to attach a second interface to your VM, you should verify that the interface is correctly set. Older VM images have secondary interfaces down by default and some images need further configuration to enable IPv6 SLAAC.

!!! info

    Don't forget to setup security groups accordingly.

### Floating IP Conversion

One floating IP per project should generally suffice. All OpenStack instances are deployed on top of internal OpenStack networks. These internal networks are not by default accessible from outside of OpenStack, but instances on top of the same internal network can communicate with each other.

To access the internet from an instance, or access an instance from the internet, you could allocate floating public IP per instance. Since there are not many public IP addresses available and assigning public IP to every instance is not a security best practice, both in public and private clouds these two concepts are used:

- __Internet access is provided by virtual router__ - all new OpenStack projects are created with a group-project-network internal network connected to a virtual router with a public IP as a gateway. Every instance created with group-project-network can access the internet through NAT provided by its router by default.
- __I need to access instances by myself__ - best practice for accessing your instances is creating one server with a floating IP called [jump host](https://en.wikipedia.org/wiki/Jump_server) and then access all other instances through this host. Simple setup:
    1. Create an instance with any Linux.
    2. Associate a floating IP with this instance.
    3. Install [`sshuttle`](https://github.com/sshuttle/sshuttle) on your client.
    4. `sshuttle -r root@jump_host_fip 192.168.0.1/24`. All your traffic to the internal OpenStack network `192.168.0.1/24` is now tunneled through the jump host.
- __I need to serve content (e.g. web service) to other users__ - public and private clouds provide LBaaS (Load-Balancer-as-a-Service) service, which proxies users traffic to instances. MetaCentrum Cloud provides this service in experimental mode.

If these options are not suitable for your use case, you can still request multiple floating IPs.
