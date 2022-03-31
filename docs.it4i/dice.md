# What Is DICE Project?

DICE (Developing Innovation and Creativity in Education) is an international project co-funded by the Erasmus+ Programme of the European Union.

Its main goals are related to fostering innovation and creativity in education.

This project attempts to be a leading initiative that supports educational community to make progress in the field of innovation and creativity through effective, authentic, practical, sustainable actions.
This project has been funded with support from the European Commission.
For more information, see [http://www.diceproject.eu/][b].

**IT4Innovations participates in DICE. DICE uses the iRods software**

The integrated Rule-Oriented Data System (iRODS) is an open source data management software used by research organizations and government agencies worldwide. iRODS is released as a production-level distribution aimed at deployment in mission critical environments. It virtualizes data storage resources, so users can take control of their data, regardless of where and on what device the data is stored. As data volumes grow and data services become more complex, iRODS is serving an increasingly important role in data management, see [https://irods.org/][c].

## iRods Client

The iRods client is what you - the user - need to install on your system.

**Prerequisities:**

- MyAccessId > B2Access identity [https://b2access.eudat.eu/][d]
- we tested client installation on Centos 7
- it runs in terminal, basic knowledge is essential

### Installation of Client to Your Local or VM

```console
wget https://packages.irods.org/irods-signing-key.asc
wget -qO - https://packages.irods.org/renci-irods.yum.repo | sudo tee /etc/yum.repos.d/renci-irods.yum.repo
yum install epel-release -y
yum install irods-icommands-4.2.10* -y
mkdir /root/.irods/
wget https://github.com/Cotagge/irods_addons_rpms/raw/main/irods-auth-plugin-openid-2.2.1-1.x86_64.rpm
yum install irods-auth-plugin-openid-2.2.1-1.x86_64.rpm
```

Copy&paste + edit irods_user_name

```console
[root@icommands ~]# cat .irods/irods_environment.json
{
    "irods_host": "irods.it4i.cz",
    "irods_port": 1247,
    "irods_zone_name": "IT4I",
    "irods_user_name": "b2access_username",
    "irods_authentication_scheme": "openid",
    "openid_provider": "keycloak_openid",
    "irods_ssl_verify_server": "cert"
}
```

```console
[root@icommand .irods]# pwd
/root/.irods
[root@icommand .irods]# ls -la
total 16
drwx------. 2 root root 136 Sep 29 08:53 .
dr-xr-x---. 6 root root 206 Sep 29 08:53 ..
-rw-r--r--. 1 root root 253 Sep 29 08:14 irods_environment.json
```

### How to Start:

**step 1:**

```console
[root@icommand .irods]# iinit
```

**step 2:**

Copy the link (second one) which you got from the terminal to the browser or just ctrl+left_mousebutton

example:

```
https://authserver...:8443/auth/realms/IT4i_AAI/protocol/openid-connect/auth?nonce=1cc259e35a0043fb871abb79185d6d838d2b99060baa5bf635515181df9c942b&state=701842d9867655918ca165f6d7635a155723afb4d37afff0cf550e77114bc519&redirect_uri=https://irods-api.it4i.cz:8443/authcallback&client_id=IT4I_IRODS_AUTH&&scope=openid&response_type=code&access_type=offline&prompt=login%20consent
```

Click the `Log in with B2ACCESS` authorization and continue authentication flow.

You have to see this output `Successfully authenticated user. The browser tab can be safely closed.` in the browser.

Current problem: after validating the authorization token, it becomes passed and any new command, such as `ils` creates new authorization at keycloak.

[b]: http://www.diceproject.eu/
[c]: https://irods.org/
[d]: https://b2access.eudat.eu/