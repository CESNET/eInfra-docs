---

title: OpenStack Components
search:
  exclude: false
---

# OpenStack Components

The following table contains a list of deployed OpenStack services. Services are separated
into two groups based on their stability and the level of support we are able to provide. All services in the production
group are well tested by our team and are covered by the support of cloud@metacentrum.cz. To be able to support
a variety of experimental cases, we are planning to deploy several services as experimental, which can be useful
for testing purposes, but its functionality won't be covered by the support of cloud@metacentrum.cz.

| Service   | Description            | Type         |
|-----------|------------------------|--------------|
| Cinder    | Block Storage service  | production   |
| Glance    | Image service          | production   |
| Heat      | Orchestration service  | production   |
| Horizon   | Dashboard              | production   |
| Keystone  | Identity service       | production   |
| Neutron   | Networking service     | production   |
| Nova      | Compute service        | production   |
| Octavia   | Load Balancing Service | experimental |
| Placement | Placement service      | production   |
| Swift/S3  | Object Storage service | production   |
