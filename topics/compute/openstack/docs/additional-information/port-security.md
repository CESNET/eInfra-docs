---

title: Port Security
search:
  exclude: false
---

# Port Security

OpenStack Port Security offers fine-grained security controls at the virtual port level, complementing the higher-level security mechanisms provided by security groups. Security settings defined by security groups can be further refined at the level of individual network interfaces using port security features. Enabling security groups on a VM results in the same security groups being applied to the VM's underlying network interfaces (ports). If we need to adjust the security group settings of a specific port, we can use the 'Edit Port' or 'Edit Security Groups' action (In Horizon select **VM instance > Interfaces > Actions: "Edit Security Groups"** or **Actions: "Edit Port"**). Changing the security rules for a specific port is an isolated change and does not affect the security settings of other ports on the same VM.

In addition to the option to override Security Groups at the port level, the 'Edit Port' action allows you to suppress Port Security: In Horizon select **VM instance > Interfaces > Actions: "Edit Port" > Port security** by unchecking the 'Port Security' option. This action effectively removes all Security Groups currently set on the port including default set of Security Groups provided by Openstack by default. Disabling Port Security can help you overcome limitations associated with security hardening, but it can lead to security breach if not used cautiously.

Port Security features also provide option to set up IP Address Filtering, so we can preciously control the allowed IP addresses that can communicate through the port. This prevents IP address spoofing by ensuring only specified IP addresses can send and receive traffic on the port. However, this feature is not available via Horizon UI and openstack client is needed to take use of this feature. The feature is explained bellow in examples - Case 2.

Let us explain the usage of Port Security with an infrastructure scenario where we want to create two servers. On this setup, VM A exposes an HTTP service, while VM B hosts a database that VM A needs to access within a separate subnet (10.10.10.0/24) dedicated to database traffic . In the most straightforward scenario, both VMs can be created within a default group project network (e.g. 192.168.1.0/24) and associated with public FIPs, making the machines manageable via direct SSH connections from devices outside the cloud.


## Examples including IP Address Filtering


### Case 1 - each VM has a single port, Port Security disabled.
* Each VM has a single port (i.e. VM A - portA, VM B - portB) while OpenStack has assigned IPs 192.168.1.11 and 192.168.1.12 to the underlying interfaces.
* Each VM is assigned a public FIP and assigned "ssh" Security Groups.
* In this scenario, a second IP (10.10.10.0/24) is assigned to the default interface on every VM (`ip addr add ...`), so the interface has IPs from both 192.168.1.0/24 and 10.10.10.0/24. Routing is handled (`ip route del ... && ip route add 10... via ...`).
    * `VM A (FIP A): portA::eno1 - 192.168.1.11, 10.10.10.11`
    * `VM B (FIP B): portB::eno1 - 192.168.1.12, 10.10.10.12`
* As we try to communicate (ping, ssh, jdbc) from VM A to VM B (10.10.10.12), traffic hangs as it is blocked by the OpenStack firewall driven by the current setup of security groups.
* Once we disable Port Security on VM B - portB:
    * The communication from the previous step starts working.
    * We expose VM B to the outside world with a risk of security breach due to the FIP and the empty set of Security Groups: all open ports are reachable, and all protocols are enabled.


### Case 2 - each VM has two ports, Port Security is set up with "IP Address Filtering"
This is a similar setup as in Case 1. However, instead of disabling Port Security on VM B, we set up PortB with "IP Address Filtering" by specifying an additional IP address that is allowed to pass traffic through portB. Unless "IP Address Filtering" is enabled, traffic from VM A to VM B is not passing.
* `openstack port set <PORT-B-ID> --allowed-address ip-address=10.10.10.11/24`
* Any traffic from VM A to VM B is working now.


### Case 3 - each VM has two ports, Port Security disabled on the db port
This setup leverages OpenStack networking features properly, achieving correct subnet composition while IP assignment and routing work out-of-the-box, so no additional actions (like `ip addr add` or `ip route add`) are necessary at the operating system level.

* Each VM has two ports (i.e., VM A - portA1 + portA2, VM B - portB1 + portB2) with IPs assigned by OpenStack, and each VM is assigned a public Floating IP (FIP) and "ssh" Security Groups.
    * VM A (FIP A):
        * PortA1 - 192.168.1.11
        * PortA2 - 10.10.10.11
    * VM B (FIP B):
        * PortB1 - 192.168.1.12
        * PortB2 - 10.10.10.12
* In addition, "IP Address Filtering" is configured as in Case 2.
