---

title: Obtaining API Key
search:
  exclude: false
---

# Obtaining API Key

__1.__ In **Identity &gt; Application Credentials**, click on **Create Application Credential**.

__2.__ Choose name, description, and expiration date & time.

!!! example

    ![](/compute/openstack/images/app_creds_1.png)

!!! tip

    If you decide to select specific roles, you should always include at least the **member** role.
    If you are planning to use the orchestration API, add the **heat_stack_owner** role as well and
    check **Unrestricted**.

__3.__ Download provided configuration files for the OpenStack CLI client.

!!! example

    ![](/compute/openstack/images/app_creds_2.png)

__4.__ [Install](https://pypi.org/project/python-openstackclient/) and
   [configure](https://docs.openstack.org/python-openstackclient/train/configuration/index.html)
   OpenStack CLI client or use [cloud tools](../additional-information/using-cloud-tools.md).
