---

title: Quota limits
search:
  exclude: false
---

# Quota Limits

Quotas are used to specify individual resources for each project. In the following tables you can see the default resources available for each project. If you need to increase these resources, you can contact [support](./get-support.md).

## Compute Resources (Nova)

| resource             | quota |
|----------------------|-------|
| instances            | 5     |
| cores                | 10    |
| ram                  | 25600 |
| metadata_items       | 128   |
| key_pairs            | 10    |
| server_groups        | 10    |
| server_group_members | 10    |

## Network Resources (Neutron)

| resource             | quota |
|----------------------|-------|
| network              | 0     |
| subnet               | 0     |
| floatingip           | 1     |
| port                 | 15    |
| router               | 0     |
| security_group       | 10    |
| security_group_rule  | 100   |

## Data Storage (Cinder)

| resource             | quota |
|----------------------|-------|
| gigabytes            | 1000  |
| snapshots            | 10    |
| volumes              | 10    |
| per_volume_gigabytes | -1    |
| backup_gigabytes     | 1000  |
| backups              | 10    |
| groups               | 10    |
| consistencygroups    | 10    |

## Image Storage (Glance)

| resource             | quota |
|----------------------|-------|
| properties           | 128   |
| image_storage        | 2000  |

## Secret Storage (Barbican)

| resource             | quota |
|----------------------|-------|
| secrets              | 20    |
| orders               | 20    |
| containers           | 20    |
| consumers            | 20    |
| cas                  | 20    |
