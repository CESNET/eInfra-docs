---

title: Command Line Interface
search:
  exclude: false
---

# Command Line Interface

## Getting Application Credentials

In order to have access to OpenStack's API, you have to use so-called OpenStack Application Credentials. In short,
it is a form of token-based authentication providing easy and secure access without the use of passwords.

There is a comprehensive guide for [Obtaining API Key](../how-to-guides/obtaining-api-key.md).

## Create a key-pair

You can either get your private key from the dashboard or you can use **ssh-keygen** command to create a new private key:

```
ssh-keygen -b 4096
```
then you will be asked to specify the output file and passphrase for your key.


1. Assuming your ssh public key is stored in `~/.ssh/id_rsa.pub`
```
openstack keypair create --public-key ~/.ssh/id_rsa.pub my-key1
```

## Create a security group
1. Create:
```
openstack security group create my-security-group
```

2. Add rules to your security group:
```
openstack security group rule create --description "Permit SSH" --remote-ip 0.0.0.0/0 --protocol tcp --dst-port 22 --ingress my-security-group
openstack security group rule create --description "Permit ICMP (any)" --remote-ip 0.0.0.0/0 --protocol icmp --icmp-type -1 --ingress my-security-group
```

3. Verify:
```
openstack security group show my-security-group
```

## Create networking

Refer to the CLI section of [Create Networking](../how-to-guides/create-networking.md).

## Create router

Refer to the CLI section of [Create Router](../how-to-guides/create-router.md).

## Create volume

!!! caution

    Skipping this section can lead to unreversible loss of data!

Volumes are created automatically when creating an instance in GUI, but we need to create them manually in the case of CLI

1. Create bootable volume from image(e.g. centos):
```
openstack volume create --image "centos-7-1809-x86_64" --size 40 my_vol1
```

## Create server

1. Create the instance:
```
openstack server create --flavor "standard.small" --volume my_vol1 \
 --key-name my-key1 --security-group my-security-group --network my-net1 my-server1
```

## Floating IP address management

Refer to the CLI section of [Managing Floating IPs](../how-to-guides/managing-floating-ips.md).

## Cloud tools

You might want to manage resources [Using Cloud Tools](../additional-information/using-cloud-tools.md).

## Full Reference

See [OpenStack CLI Documentation](https://docs.openstack.org/python-openstackclient/train/).