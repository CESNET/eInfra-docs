---

title: Quota limits
search:
  exclude: false
---

# Quota limits

Quotas are used to specify individual resources for each project. In the following tables you can see the default resources available for each project. If you need to increase these resources, you can contact [support](/OpenStack/technical-reference/get-support/).

## Compute resources (Nova)
| resource             | quota |
|----------------------|-------|
| instances            | 5     |
| cores (vCPU)         | 10    |
| ram (GB)             | 25600 |
| key_pairs            | 10    |
| server_groups        | 10    |
| server_group_members | 10    |

## Network resources (Neutron)
| resource            | quota |
|---------------------|-------|
| network             | 1     |
| subnet              | 5     |
| floating ip         | 1     |
| port                | 15    |
| router              | 0     |
| security_group      | 10    |
| security_group_rule | 100   |

## Load balancer resources (Octavia)
| resource        | quota |
|-----------------|-------|
| loadbalancer    | 1     |
| listeners       | 10    |
| members         | 5     |
| pool            | 5     |
| health_monitors | 10    |

## Data storage (Cinder)
| resource             | quota     |
|----------------------|-----------|
| gigabytes            | 1000      |
| snapshots            | 10        |
| volumes              | 10        |
| backup_gigabytes     | 1000      |
| backups              | 10        |
| groups               | 10        |

## Image storage (Glance)
| resource      | quota |
|---------------|-------|
| properties    | 128   |
| image_storage | 2000  |

## Secret storage (Barbican)
| resource    | quota |
|-------------|-------|
| secrets     | 20    |
| orders      | 20    |
| containers  | 20    |
| consumers   | 20    |
