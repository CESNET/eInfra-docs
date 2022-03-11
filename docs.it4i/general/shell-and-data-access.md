# Accessing the Clusters

## Shell Access

All IT4Innovations clusters are accessed by the SSH protocol via login nodes at the address **cluster-name.it4i.cz**. The login nodes may be addressed specifically, by prepending the loginX node name to the address.

!!! note "Workgroups Access Limitation"
    Projects from the **PRACE** workgroup can only access the **Barbora** cluster.<br>Projects from the **EUROHPC** workgroup can only access the **Karolina** cluster.

!!! important "Karolina and Barbora updated security requirements"
    Due to updated security requirements on Karolina and Barbora,
    only clients based on OpenSSH 7.4p1 and later can connect (including other SSH clients with compatible security algorithms).
    This means that starting with RHEL/Centos 7, Debian 9 or Ubuntu 18.04, you are good to go.
    Some users who still have DSA keys will be also unable to connect and are urged to update their keypairs, preferably to the Ed25519 format.

### Karolina Cluster

| Login address           | Port | Protocol | Login node                            |
| ----------------------- | ---- | -------- | ------------------------------------- |
| karolina.it4i.cz        | 22   | SSH      | round-robin DNS record for login[1-4] |
| login1.karolina.it4i.cz | 22   | SSH      | login1                                |
| login2.karolina.it4i.cz | 22   | SSH      | login2                                |
| login3.karolina.it4i.cz | 22   | SSH      | login3                                |
| login4.karolina.it4i.cz | 22   | SSH      | login4                                |

### Barbora Cluster

| Login address             | Port | Protocol | Login node                            |
| ------------------------- | ---- | -------- | ------------------------------------- |
| barbora.it4i.cz           | 22   | SSH      | round-robin DNS record for login[1-2] |
| login1.barbora.it4i.cz    | 22   | SSH      | login1                                |
| login2.barbora.it4i.cz    | 22   | SSH      | login2                                |

## Authentication

Authentication is available by [private key][1] only. Verify SSH fingerprints during the first logon:

### Karolina

**Fingerprints**

```console
# login1:22 SSH-2.0-OpenSSH_7.4
256 SHA256:zKEtQMi2KRsxzzgo/sHcog+NFZqQ9tIyvJ7BVxOfzgI login1 (ED25519)
2048 SHA256:Ip37d/bE6XwtWf3KnWA+sqA+zRGSFlf5vXai0v3MBmo login1 (RSA)

# login2:22 SSH-2.0-OpenSSH_7.4
2048 SHA256:Ip37d/bE6XwtWf3KnWA+sqA+zRGSFlf5vXai0v3MBmo login2 (RSA)
256 SHA256:zKEtQMi2KRsxzzgo/sHcog+NFZqQ9tIyvJ7BVxOfzgI login2 (ED25519)

# login3:22 SSH-2.0-OpenSSH_7.4
2048 SHA256:Ip37d/bE6XwtWf3KnWA+sqA+zRGSFlf5vXai0v3MBmo login3.karolina.it4i.cz (RSA)
256 SHA256:zKEtQMi2KRsxzzgo/sHcog+NFZqQ9tIyvJ7BVxOfzgI login3.karolina.it4i.cz (ED25519)

# login4:22 SSH-2.0-OpenSSH_7.4
256 SHA256:zKEtQMi2KRsxzzgo/sHcog+NFZqQ9tIyvJ7BVxOfzgI login4 (ED25519)
2048 SHA256:Ip37d/bE6XwtWf3KnWA+sqA+zRGSFlf5vXai0v3MBmo login4 (RSA)
```

**Public Keys \ Known Hosts**

```console
login1,login1.karolina.it4i.cz,login1.karolina,karolina.it4i.cz ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9Cp8/a3F7eOPQvH4+HjC778XvYgRXWmCEOQnE3clPcKw15iIat3bvKc8ckYLudAzomipWy4VYdDI2OnEXay5ba8HqdREJO31qNBtW1AXgydCfPnkeuUZS4WVlAWM+HDlK6caB8KlvHoarCnNj2jvuYsMbARgGEq3vrk3xW4uiGpS6Y/uGVBBwMFWFaINbmXUrU1ysv/ZD1VpH4eHykkD9+8xivhhZtcz5Z2T7ZnIib4/m9zZZvjKs4ejOo58cKXGYVl27kLkfyOzU3cirYNQOrGqllN/52fATfrXKMcQor9onsbTkNNjMgPFZkddufxTrUaS7EM6xYsj8xrPJ2RaN
login1,login1.karolina.it4i.cz,login1.karolina,karolina.it4i.cz ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDkIdDODkUYRgMy1h6g/UtH34RnDCQkwwiJZFB0eEu1c
login2,login2.karolina.it4i.cz,login2.karolina,karolina.it4i.cz ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDkIdDODkUYRgMy1h6g/UtH34RnDCQkwwiJZFB0eEu1c
login2,login2.karolina.it4i.cz,login2.karolina,karolina.it4i.cz ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9Cp8/a3F7eOPQvH4+HjC778XvYgRXWmCEOQnE3clPcKw15iIat3bvKc8ckYLudAzomipWy4VYdDI2OnEXay5ba8HqdREJO31qNBtW1AXgydCfPnkeuUZS4WVlAWM+HDlK6caB8KlvHoarCnNj2jvuYsMbARgGEq3vrk3xW4uiGpS6Y/uGVBBwMFWFaINbmXUrU1ysv/ZD1VpH4eHykkD9+8xivhhZtcz5Z2T7ZnIib4/m9zZZvjKs4ejOo58cKXGYVl27kLkfyOzU3cirYNQOrGqllN/52fATfrXKMcQor9onsbTkNNjMgPFZkddufxTrUaS7EM6xYsj8xrPJ2RaN
login3,login3.karolina.it4i.cz,login3.karolina,karolina.it4i.cz ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDkIdDODkUYRgMy1h6g/UtH34RnDCQkwwiJZFB0eEu1c
login3,login3.karolina.it4i.cz,login3.karolina,karolina.it4i.cz ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9Cp8/a3F7eOPQvH4+HjC778XvYgRXWmCEOQnE3clPcKw15iIat3bvKc8ckYLudAzomipWy4VYdDI2OnEXay5ba8HqdREJO31qNBtW1AXgydCfPnkeuUZS4WVlAWM+HDlK6caB8KlvHoarCnNj2jvuYsMbARgGEq3vrk3xW4uiGpS6Y/uGVBBwMFWFaINbmXUrU1ysv/ZD1VpH4eHykkD9+8xivhhZtcz5Z2T7ZnIib4/m9zZZvjKs4ejOo58cKXGYVl27kLkfyOzU3cirYNQOrGqllN/52fATfrXKMcQor9onsbTkNNjMgPFZkddufxTrUaS7EM6xYsj8xrPJ2RaN
login4,login4.karolina.it4i.cz,login4.karolina,karolina.it4i.cz ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9Cp8/a3F7eOPQvH4+HjC778XvYgRXWmCEOQnE3clPcKw15iIat3bvKc8ckYLudAzomipWy4VYdDI2OnEXay5ba8HqdREJO31qNBtW1AXgydCfPnkeuUZS4WVlAWM+HDlK6caB8KlvHoarCnNj2jvuYsMbARgGEq3vrk3xW4uiGpS6Y/uGVBBwMFWFaINbmXUrU1ysv/ZD1VpH4eHykkD9+8xivhhZtcz5Z2T7ZnIib4/m9zZZvjKs4ejOo58cKXGYVl27kLkfyOzU3cirYNQOrGqllN/52fATfrXKMcQor9onsbTkNNjMgPFZkddufxTrUaS7EM6xYsj8xrPJ2RaN
login4,login4.karolina.it4i.cz,login4.karolina,karolina.it4i.cz ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDkIdDODkUYRgMy1h6g/UtH34RnDCQkwwiJZFB0eEu1c
```

### Barbora

**Fingerprints**

```console
md5:
39:55:e2:b9:2a:a2:c4:9e:b1:8e:f0:f7:b1:66:a8:73 (RSA)
40:67:03:26:d3:6c:a0:7f:0a:df:0e:e7:a0:52:cc:4e (ED25519)

sha256:
TO5szOJf0bG7TWVLO3WABUpGKkP7nBm/RLyHmpoNpro (RSA)
ZQzFTJVDdZa3I0ics9ME2qz4v5a3QzXugvyVioaH6tI (ED25519)
```

**Public Keys \ Known Hosts**

```console
barbora.it4i.cz, ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHUHvIrv7VUcGIcfsrcBjYfHpFBst8uhtJqfiYckfbeMRIdaodfjTO0pIXvd5wx+61a0C14zy1pdhvx6ykT5lwYkkn8l2tf+LRd6qN0alq/s+NGDJKpWGvdAGD3mM9AO1RmUPt+Vfg4VePQUZMu2PXZQu2C4TFFbaH2yiyCFlKz/Md9q+7NM+9U86uf3uLFbBu8mzkk2z3jyDGR6pjmpYTAiV/goUGpHgsW8Qx4GUdCreObQ6GUfPVOPvYaTlfXfteD9HluB7gwCWaUi5hevHhc+kK4xj61v64mGBOPmCobnAlr2RYQv6cDn7PHgI2mE7ZwRsZkNyMXqGr1S2JK2M64K53ZfF70aGrW/muHlFrYVFaJg6s1f7K/Xqu21wjwwvnJ8CcP7lUjASqhfSn9OBzEI38KMMo5Qon9p108wvqSKP2QnEdrdv1QOsBPtOZMNRMfEVpw6xVvyPka0X6gxzGfEc9nn3nOok35Fbvoo3G0P8RmOeDJLqDjUOggOs0Gwk=
barbora.it4i.cz, ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOmUm4btn7OC0QLIT3xekKTTdg5ziby8WdxccEczEeE1
```

!!! note
    Barbora has identical SSH fingerprints on all login nodes.

### Private Key Authentication:

On **Linux** or **Mac**, use:

```console
local $ ssh -i /path/to/id_rsa username@cluster-name.it4i.cz
```

If you see a warning message **UNPROTECTED PRIVATE KEY FILE!**, use this command to set lower permissions to the private key file:

```console
local $ chmod 600 /path/to/id_rsa
```

On **Windows**, use the [PuTTY SSH client][2].

After logging in, you will see the command prompt with the name of the cluster and the message of the day.

!!! note
    The environment is **not** shared between login nodes, except for shared filesystems.

## Data Transfer

Data in and out of the system may be transferred by SCP and SFTP protocols.

| Cluster  | Port | Protocol  |
| -------- | ---- | --------- |
| Karolina | 22   | SCP, SFTP |
| Barbora  | 22   | SCP       |

Authentication is by [private key][1] only.

On Linux or Mac, use an SCP or SFTP client to transfer data to the cluster:

```console
local $ scp -i /path/to/id_rsa my-local-file username@cluster-name.it4i.cz:directory/file
```

```console
local $ scp -i /path/to/id_rsa -r my-local-dir username@cluster-name.it4i.cz:directory
```

or

```console
local $ sftp -o IdentityFile=/path/to/id_rsa username@cluster-name.it4i.cz
```

A very convenient way to transfer files in and out of the cluster is via the fuse filesystem [SSHFS][b].

```console
local $ sshfs -o IdentityFile=/path/to/id_rsa username@cluster-name.it4i.cz:. mountpoint
```

Using SSHFS, the user's home directory will be mounted on your local computer, just like an external disk.

Learn more about SSH, SCP, and SSHFS by reading the manpages:

```console
local $ man ssh
local $ man scp
local $ man sshfs
```

On Windows, use the [WinSCP client][c] to transfer data. The [win-sshfs client][d] provides a way to mount the cluster filesystems directly as an external disc.

## Connection Restrictions

Outgoing connections from cluster login nodes to the outside world are restricted to the following ports:

| Port | Protocol |
| ---- | -------- |
| 22   | SSH      |
| 80   | HTTP     |
| 443  | HTTPS    |
| 873  | Rsync    |

!!! note
    Use **SSH port forwarding** and proxy servers to connect from cluster to all other remote ports.

Outgoing connections from cluster compute nodes are restricted to the internal network. Direct connections from compute nodes to the outside world are cut.

## Port Forwarding

### Port Forwarding From Login Nodes

!!! note
    Port forwarding allows an application running on cluster to connect to arbitrary remote hosts and ports.

It works by tunneling the connection from cluster back to the user's workstations and forwarding from the workstation to the remote host.

Select an unused port on the cluster login node (for example 6000) and establish the port forwarding:

```console
$ ssh -R 6000:remote.host.com:1234 cluster-name.it4i.cz
```

In this example, we establish port forwarding between port 6000 on the cluster and port 1234 on the `remote.host.com`. By accessing `localhost:6000` on the cluster, an application will see the response of `remote.host.com:1234`. The traffic will run via the user's local workstation.

Port forwarding may be done **using PuTTY** as well. On the PuTTY Configuration screen, load your cluster configuration first. Then go to *Connection > SSH > Tunnels* to set up the port forwarding. Click the _Remote_ radio button. Insert 6000 to the _Source port_ textbox. Insert `remote.host.com:1234`. Click _Add_, then _Open_.

Port forwarding may be established directly to the remote host. However, this requires that the user has an SSH access to `remote.host.com`.

```console
$ ssh -L 6000:localhost:1234 remote.host.com
```

!!! note
    Port number 6000 is chosen as an example only. Pick any free port.

### Port Forwarding From Compute Nodes

Remote port forwarding from compute nodes allows applications running on the compute nodes to access hosts outside the cluster.

First, establish the remote port forwarding from the login node, as [described above][5].

Second, invoke port forwarding from the compute node to the login node. Insert the following line into your jobscript or interactive shell:

```console
$ ssh  -TN -f -L 6000:localhost:6000 login1
```

In this example, we assume that port forwarding from `login1:6000` to `remote.host.com:1234` has been established beforehand. By accessing `localhost:6000`, an application running on a compute node will see the response of `remote.host.com:1234`.

### Using Proxy Servers

Port forwarding is static; each single port is mapped to a particular port on a remote host. Connection to another remote host requires a new forward.

!!! note
    Applications with inbuilt proxy support experience unlimited access to remote hosts via a single proxy server.

To establish a local proxy server on your workstation, install and run the SOCKS proxy server software. On Linux, SSHD demon provides the functionality. To establish the SOCKS proxy server listening on port 1080 run:

```console
local $ ssh -D 1080 localhost
```

On Windows, install and run the free, open source Sock Puppet server.

Once the proxy server is running, establish the SSH port forwarding from cluster to the proxy server, port 1080, exactly as [described above][5]:

```console
local $ ssh -R 6000:localhost:1080 cluster-name.it4i.cz
```

Now, configure the applications proxy settings to `localhost:6000`. Use port forwarding to access the [proxy server from compute nodes][9], as well.

[1]: ../general/accessing-the-clusters/shell-access-and-data-transfer/ssh-key-management.md
[2]: ../general/accessing-the-clusters/shell-access-and-data-transfer/putty.md
[5]: #port-forwarding-from-login-nodes
[6]: ../general/accessing-the-clusters/graphical-user-interface/x-window-system.md
[7]: ../general/accessing-the-clusters/graphical-user-interface/vnc.md
[8]: ../general/accessing-the-clusters/vpn-access.md
[9]: #port-forwarding-from-compute-nodes

[b]: http://linux.die.net/man/1/sshfs
[c]: http://winscp.net/eng/download.php
[d]: http://code.google.com/p/win-sshfs/
