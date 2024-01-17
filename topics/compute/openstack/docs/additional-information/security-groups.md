---

title: Security Groups
search:
  exclude: false
---

# Security Groups

Security groups are a collection of security rules that are applied on specific VM.

Security rules in OpenStack serve as a Firewall. They are applied directly on VM ports and therefore proper configuration is necessary. Ingress as well as egress rules can be configured using Horizon and CLI. If you can't connect via SSH or ping your instance, chances are it is because of security rules.

Every OpenStack project contains the `default` security group containing only set of egress rules (in the Horizon, refer to `Project / Network / Security Groups`). If you accidentally delete default egress rules, your virtual machine will not be able to send outgoing communication. To fix this, add a new egress rule with *any* IP protocol and port range, set Remote IP prefix to *0.0.0.0/0* (IPv4) or *::/0* (IPv6).

Example configuration is available on page [Managing security groups](../how-to-guides/managing-security-groups.md). For full CLI reference please refer to [OpenStack docs](https://docs.openstack.org/python-openstackclient/train/cli/command-objects/security-group.html).

Also refer to the [example of new Security group creation](https://gitlab.ics.muni.cz/cloud/g2/openstack-infrastructure-as-code-automation/-/blob/master/clouds/g2/ostrava/general/commandline/cmdline-demo.sh) containing custom rules within VM provisioning CLI example.
