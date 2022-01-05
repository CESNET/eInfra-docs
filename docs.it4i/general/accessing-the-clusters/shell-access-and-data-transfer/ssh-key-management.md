# SSH

Secure Shell (SSH) is a cryptographic network protocol for operating network services securely over an unsecured network.
SSH uses public-private key pair for authentication, allowing users to log in without having to specify a password. The public key is placed on all computers that must allow access to the owner of the matching private key (the private key must be kept **secret**).

## Private Key

!!! note
    The path to a private key is usually /home/username/.ssh/

A private key file in the `id_rsa` or `*.ppk` format is present locally on local side and used for example in the Pageant SSH agent (for Windows users). The private key should always be kept in a safe place.

An example of private key format:

```console
    -----BEGIN RSA PRIVATE KEY-----
    MIIEpAIBAAKCAQEAqbo7jokygnBpG2wYa5NB45ns6+UKTNLMLHF0BO3zmRtKEElE
    aGqXfbYwvXlcuRb2d9/Y5dVpCZHV0kbY3NhtVOcEIe+1ROaiU9BEsUAhMNEvgiLV
    gSql4QvRO4BWPlM8+WAWXDp3oeoBh8glXyuh9teb8yq98fv1r1peYGRrW3/s4V+q
    O1SQ0XY2T7rWCYRLIP6rTMXArTI35v3WU513mn7nm1fJ7oN0QgVH5b0W9V1Kyc4l
    9vILHeMXxvz+i/5jTEfLOJpiRGYZYcaYrE4dIiHPl3IlbV7hlkK23Xb1US8QJr5G
    ADxp1VTkHjY+mKagEfxl1hQIb42JLHhKMEGqNQIDAQABAoIBAQCkypPuxZjL+vai
    UGa5dAWiRZ46P2yrwHPKpvEdpCdDPbLAc1K/CtdBkHZsUPxNHVV6eFWweW99giIY
    Av+mFWC58X8asBHQ7xkmxW0cqAZRzpkRAl9IBS9/fKjO28Fgy/p+suOi8oWbKIgJ
    3LMkX0nnT9oz1AkOfTNC6Tv+3SE7eTj1RPcMjur4W1Cd1N3EljLszdVk4tLxlXBS
    yl9NzVnJJbJR4t01l45VfFECgYEAno1WJSB/SwdZvS9GkfhvmZd3r4vyV9Bmo3dn
    XZAh8HRW13imOnpklDR4FRe98D9A7V3yh9h60Co4oAUd6N+Oc68/qnv/8O9efA+M
    /neI9ANYFo8F0+yFCp4Duj7zPV3aWlN/pd8TNzLqecqh10uZNMy8rAjCxybeZjWd
    DyhgywXhAoGBAN3BCazNefYpLbpBQzwes+f2oStvwOYKDqySWsYVXeVgUI+OWTVZ
    eZ26Y86E8MQO+q0TIxpwou+TEaUgOSqCX40Q37rGSl9K+rjnboJBYNCmwVp9bfyj
    kCLL/3g57nTSqhgHNa1xwemePvgNdn6FZteA8sXiCg5ZzaISqWAffek5AoGBAMPw
    V/vwQ96C8E3l1cH5cUbmBCCcfXM2GLv74bb1V3SvCiAKgOrZ8gEgUiQ0+TfcbAbe
    7MM20vRNQjaLTBpai/BTbmqM1Q+r1KNjq8k5bfTdAoGANgzlNM9omM10rd9WagL5
    yuJcal/03p048mtB4OI4Xr5ZJISHze8fK4jQ5veUT9Vu2Fy/w6QMsuRf+qWeCXR5
    RPC2H0JzkS+2uZp8BOHk1iDPqbxWXJE9I57CxBV9C/tfzo2IhtOOcuJ4LY+sw+y/
    ocKpJbdLTWrTLdqLHwicdn8OxeWot1mOukyK2l0UeDkY6H5pYPtHTpAZvRBd7ETL
    Zs2RP3KFFvho6aIDGrY0wee740/jWotx7fbxxKwPyDRsbH3+1Wx/eX2RND4OGdkH
    gejJEzpk/7y/P/hCad7bSDdHZwO+Z03HIRC0E8yQz+JYatrqckaRCtd7cXryTmTR
    FbvLJmECgYBDpfno2CzcFJCTdNBZFi34oJRiDb+HdESXepk58PcNcgK3R8PXf+au
    OqDBtZIuFv9U1WAg0gzGwt/0Y9u2c8m0nXziUS6AePxy5sBHs7g9C9WeZRz/nCWK
    +cHIm7XOwBEzDKz5f9eBqRGipm0skDZNKl8X/5QMTT5K3Eci2n+lTw==
    -----END RSA PRIVATE KEY-----
```

## Public Key

A public key file in the `*.pub` format is present on the remote side and allows an access to the owner of the matching private key.

An example of public key format:

```console
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpujuOiTKCcGkbbBhrk0Hjmezr5QpM0swscXQE7fOZG0oQSURoapd9tjC9eVy5FvZ339jl1WkJkdXSRtjc2G1U5wQh77VE5qJT0ESxQCEw0S+CItWBKqXhC9E7gFY+UyP5YBZcOneh6gGHyCVfK6H215vzKr3x+/WvWl5gZGtbf+zhX6o4RJDRdjZPutYJhEsg/qtMxcCtMjfm/dZTnXeafuebV8nug3RCBUflvRb1XUrJuiX28gsd4xfG/P6L/mNMR8s4kmJEZhlhxpj8Th0iIc+XciVtXuGWQrbddcVRLxAmvkYAPGnVVOQeNj69pqAR/GXaFAhvjYkseEowQao1 username@organization.example.com
```

## SSH Key Management

You can manage your own SSH key for authentication to clusters.

## Managing Your Own Key

1. Generate your SSH key (see the [OpenSSH Keys (UNIX)][1] or [PuTTY (Windows)][2] section).

1. Go to [https://extranet.it4i.cz/ssp/index.php?action=changesshkey][a]

1. Enter your username, password and public SSH key.

1. Changes will take effect immediately.

[1]: ./ssh-keys.md
[2]: ./putty.md

[a]: https://extranet.it4i.cz/ssp/index.php?action=changesshkey
