---

title: Orchestration
search:
  exclude: false
---

# Orchestration

## Terraform

Terraform is the best orchestration tool for creating and managing a cloud infrastructure. It is capable of greatly simplifying cloud operations. If something goes wrong, it gives you an option to easily rebuild your cloud infrastructure.

It manages resources like virtual machines, DNS records, etc.

It is managed through configuration templates containing information about its tasks and resources. They are saved as `*.tf` files. If the configuration changes, Terraform can detect it and create additional operations to apply those changes.

Here is an example of this configuration file:

```
variable "image" {
default = "Debian 10"
}

variable "flavor" {
default = "standard.small"
}

variable "ssh_key_file" {
default = "~/.ssh/id_rsa"
}
```

 You can use OpenStack Provider, which is a tool for managing resources OpenStack supports via Terraform. Terraform has an advantage over Heat because it can be used also in other architectures, not only in OpenStack.


For more detail, please refer to [OpenStack Provider documentation](https://registry.terraform.io/providers/terraform-provider-OpenStack/OpenStack/latest/docs) and [Terraform documentation](https://www.terraform.io/intro/index.html).

Also refer to [example of Terraform project](https://gitlab.ics.muni.cz/cloud/g2/openstack-infrastructure-as-code-automation/-/tree/master/clouds/g2/ostrava/general/terraform) responsible for creation of two tier infrastructure consisting of several VMs and setting up networking, security and storage.

## Heat

Heat is an OpenStack exclusive orchestration tool used for managing cloud resources. Just like Terraform it is capable of simplifying orchestration operations in your cloud infrastructure.

It also uses configuration templates for the specification of information about resources and tasks. You can manage resources like servers, floating IPs, volumes, security groups, etc. via Heat.

Here is an example of a Heat configuration template in form of a `*.yaml` file:

```
heat_template_version: 2021-04-06

description: Test template

resources:
  my_instance:
    type: OS::Nova::Server
    properties:
      key_name: id_rsa
      image: Debian10_image
      flavor: standard.small
```

You can find more information in the [official documentation](https://wiki.openstack.org/wiki/Heat).
