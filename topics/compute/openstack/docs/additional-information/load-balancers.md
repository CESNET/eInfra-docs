---

title: Load Balancers
search:
  exclude: false
---

# Load Balancers

Load balancers serve as a proxy between a virtualized infrastructure and clients in the outside network. This is essential in OpenStack since it can be used in a scenario where the infrastructure dynamically starts new VMs and adds them into the load balancing pool in order to mitigate inaccessibility of services.

When modifying a load balancer, each operation changes the database into immutable state. It is therefore recommended to use the `--wait` switch when creating, editing, or removing resources from load balancers.

!!! info

    We are currently observing inaccessibility of some load balancers on floating IP after creation. If this happens, please try to rebuild the load balancer before contacting support.

## Provisioning Status

This status represents the overall state of the load balancer backend.

- `ACTIVE`: the load balancer backend is working as intended.
- `PENDING`: statuses starting with `PENDING` usually reflect modification of the load balancer, during which the database is in immutable state and thus any additional operations will fail.
- `ERROR`: the provisioning has failed. This load balancer can't be modified and usually is not working. Therefore we encourage our users to remove these load balancers. If this happens more often, please report this problem at `cloud@metacentrum.cz`.
- `DELETED`: entity has been deleted.

## Operating Status

Operating status is managed by a health monitor service of the load balancer and reflects the availibility of endpoint service.

- `ONLINE`: all endpoint services are available.
- `DEGRADED`: some endpoint services are not available.
- `ERROR`: all endpoint services are unavailable.
- `DRAINING`: not accepting new connections.
- `OFFLINE`: entity is administratively disabled.
- `NO_MONITOR`: health monitor is not configured.
