---

title: Orchestration
search:
  exclude: false
---

# Orchestration

## Terraform

Terraform is the best orchestration tool for creating and managing cloud infrastructure. It is capable of greatly simplifying cloud operations. It gives you an option if something goes wrong you can easily rebuild your cloud infrastructure.

It manages resources like virtual machines, DNS records, etc.

It is managed through configuration templates containing info about its tasks and resources. They are saved as *.tf files. If configuration changes, Terraform can detect it and create additional operations to apply those changes.

Here is an example how this configuration file can look like:

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

 You can use OpenStack Provider which is a tool for managing resources OpenStack supports via Terraform. Terraform has an advantage over Heat because it can be used also in other architectures, not only in OpenStack


For more detail please refer to [https://registry.terraform.io/providers/terraform-provider-OpenStack/OpenStack/latest/docs](https://registry.terraform.io/providers/terraform-provider-OpenStack/OpenStack/latest/docs) and [https://www.terraform.io/intro/index.html](https://www.terraform.io/intro/index.html).


## Heat
Heat is another orchestration tool used for managing cloud resources. This one is OpenStack exclusive so you can't use it anywhere else. Just like Terraform it is capable of simplifying orchestration operations in your cloud infrastructure.

It also uses configuration templates for the specification of information about resources and tasks. You can manage resources like servers, floating IPs, volumes, security groups, etc. via Heat.

Here is an example of a Heat configuration template in form of a *.yaml file:


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
