---

title: Remote Access
search:
  exclude: false
---

# Remote Access

## Accessing From Linux

### Using jump host and SSH ProxyJump

To access an individual instance via a jump host/bastion server, the ProxyJump option (-J) of the SSH client can be used. This feature was introduced in [SSH 7.3](https://www.openssh.com/txt/release-7.3).

To use it, provide the username and hostname of the jump host as an argument to the `-J` parameter followed by the username and hostname of the target instance:

```shell
ssh -J user@jump.host user@target.host
```

To get more detail how a bastion is set up within a cloud project, check the [example](https://gitlab.ics.muni.cz/cloud/g2/openstack-infrastructure-as-code-automation/-/tree/master/clouds/g2/ostrava/general/terraform/modules/2tier_public_bastion_private_vm_farm) scripted in Terraform.


### Setting Up VPN Tunnel Via Encrypted SSH With [sshuttle](https://github.com/sshuttle/sshuttle)

``` sh
# terminal A
# Launch tunnel through jump-host VM

# Install sshuttle
if grep -qE 'ID_LIKE=.*debian' /etc/os-release; then
  # on debian like OS
  sudo apt-get update
  sudo apt-get -y install sshuttle
elif grep -qE 'ID_LIKE=.*rhel' /etc/os-release; then
  # on RHEL like systems
  sudo yum -y install sshuttle
fi

# Establish the SSH tunnel (and stay connected) where
# 147.251.21.72 is IP address of example jump-host
# 172.16.0.0/22 is IP subnet where example cloud resources are available
sshuttle -r centos@147.251.21.72 172.16.0.0/22
```

### Accessing (Hidden) Project VMs Through VPN Tunnel

``` sh
# terminal B
# Access all VMs allocated in the project in 172.16.0.0/22 subnet
$ ssh debian@172.16.0.158 uname -a
Linux freznicek-deb10 4.19.0-14-cloud-amd64

# Access is not limited to any protocol, you may access all services.
$ curl 172.16.1.67:8080
Hello, world, cnt=1, hostname=freznicek-ubu
```

## Accessing From Windows

[PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/faq.html#faq-what) is a client program for the SSH on Windows OS.

### PuTTY Installer

We recommend downloading [Windows Installer](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) with PuTTY utilities as:

* Pageant (SSH authentication agent) - store the private key in memory without the need to retype a passphrase on every login
* PuTTYgen (PuTTY key generator) - convert OpenSSH format of id_rsa to PuTTY ppk private key and so on

### Connect to Instance

* Run PuTTY and enter Host name in format "login@Floating IP address" where login is for example debian for Debian OS and Floating IP is [IP address](../how-to-guides/associate-floating-ips.md) to access instance from internet.
* In Category -> Connection -> SSH -> Auth:
    *  Select **Attempt authentication using Pageant**
    *  Select **Allow agent forwarding**
    *  Browse and select your private key file ([convert OpenSSH format id_rsa to Putty ppk](#convert-openssh-format-to-putty-ppk-format))
* Return to *Session page* and Save selected configuration with **Save** button
* Now you can log in using **Open** button
* Enter passphrase for selected private key file if [Pageant SSH authentication agent](#pageant-ssh-agent) is not used
    *  We recommend using Pageant SSH Agent to store the private key in memory without the need to retype a passphrase on every login

![](/compute/openstack/images/putty/putty-connect2instance.png)

### Pageant SSH Agent

* Run Pageant from Windows menu
* Locate Pageant icon in the Notification Area and double click on it
* Use **Add Key** button
* Browse files and select your PuTTY Private Key File in format `.ppk`
* Use **Open** button
* Enter the passphrase and confirm **OK** button
* Your private key is now located in the memory without the need to retype a passphrase on every login

![](/compute/openstack/images/putty/pageant-add-key.png)

### Key Generator

PuTTYgen is the PuTTY key generator. You can load in an existing private key and change your passphrase or generate a new public/private key pair or convert to/from OpenSSH/PuTTY ppk formats.

### Convert OpenSSH Format to PuTTY ppk Format

* Run PuTTYgen, in the menu Conversion -> Import key browse and load your OpenSSH format id_rsa private key using your passphrase
* Save PuTTY ppk private key using button **Save private key**, browse destination for PuTTY format id_rsa.ppk, and save file

![](/compute/openstack/images/putty/puttygen-openssh2ppk.png)

### Convert PuTTY ppk Private Key to OpenSSH Format

* Run PuTTYgen, in the menu File -> Load private key browse and open your private key in format PuTTY ppk using your passphrase
* In the menu Conversion -> Export OpenSSH key browse destination for OpenSSH format id_rsa and save file

![](/compute/openstack/images/putty/puttygen-ppk2openssh.png)

### Change Password for Existing Private Key Pair

* Load your existing private key using button **Load**, confirm opening using your passphrase
* Enter a new passphrase in the field *Key passphrase* and confirm again in the field *Confirm passphrase*
* Save changes using button **Save private key**

![](/compute/openstack/images/putty/puttygen-passphrase.png)

### Generate New Key Pair

* Start with **Generate button**
* Generate some randomness by moving your mouse over the dialog
* Wait while the key is generated
* Enter a comment for your key using "your-email@address"
* Enter a key passphrase, confirm the key passphrase
* Save your new private key in the `id_rsa.ppk` format using the **Save private key** button
* Save the public key with the **Save public key** button

![](/compute/openstack/images/putty/puttygen_new_key.png)
