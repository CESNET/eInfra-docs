# OpenSSH Keys (UNIX)

## Creating Your Own Key

To generate a new keypair of your public and private key, use the `ssh-keygen` tool:

```console
local $ ssh-keygen -C 'username@organization.example.com' -f additional_key
```

!!! note
    Enter a **strong** **passphrase** for securing your private key.

By default, your private key is saved to the `id_rsa` file in the `.ssh` directory
and your public key is saved to the `id_rsa.pub` file.

## Managing Your SSH Key

To manage your SSH key for authentication to clusters, see the [SSH Key Management][1] section.

[1]: ./ssh-key-management.md
