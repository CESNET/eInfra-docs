---

title: IPv6 Troubleshooting
search:
  exclude: false
---

# IPv6 Troubleshooting

Public IPv6 addresses are assigned via SLAAC. After assigning an interface in OpenStack to your instance, verify correct configuration of your VM. You can assign interface by directly connecting your VM to the network upon creation or by assigning a secondary interface.

## Metadata Service

There is an issue with metadata service in IPv6-only environment in our OpenStack Cloud. If you decide to use IPv6 for public access, we recommend to add a local IPv4 network to your VM for deployment of initial configuration via metadata service. This problem can be usually linked to missing SSH keys in your VM in IPv6-only deployment.

## IPv6 Address Not Obtained

This problem should occur only when assigning additional interfaces to your existing VM. First, verify the interface is enabled in the system via `ip addr` and if the interface is down, run `ifconfig ETH_NAME up`.

Some Linux images have SLAAC disabled by default. In this case, you can either assign the address allocated by OpenStack manually, or setup SLAAC configuration on your VM.

## Security Groups

If you have been using your VM with IPv4, make sure to update your [Security groups](../additional-information/security-groups.md) to also allow IPv6 traffic, otherwise it will be inaccessible. For configuration, refer to the [Creating first infrastructure](../getting-started/creating-first-infrastructure.md#update-security-group) tutorial.

## DNS Records

By default, OpenStack injects DNS records to new VMs upon creation. If you are missing IPv6 DNS records on your VM and you decide to completely remove IPv4, you should setup IPv6 records in the `/etc/resolv.conf` folder.

New VMs should obtain both IPv4 and IPv6 DNS records.
