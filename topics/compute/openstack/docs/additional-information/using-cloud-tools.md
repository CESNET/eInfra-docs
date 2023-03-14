---

title: Using Cloud Tools
search:
  exclude: false
---

# Using Cloud Tools

[Cloud tools](https://gitlab.ics.muni.cz/cloud/cloud-tools) is a docker container prepared with modules required for cloud management.

## Setup

In order to use the container, you have to [install docker](https://docs.docker.com/engine/install/centos/) and start the service.
The next step is to clone the [cloud tools](https://gitlab.ics.muni.cz/cloud/cloud-tools) repository
and start the docker container by running:

```
./toolbox.sh
```

Finally, you can source your [API credentials](OpenStack/how-to-guides/obtaining-api-key):

```
source app-cred-example.sh
```

The cloud tools contains CLI modules that can be used for cloud management.
[CLI command reference](https://docs.openstack.org/python-openstackclient/train/cli/command-list.html) is available at official OpenStack documentation.

To verify correct functionality, run:

```
openstack version show
```
