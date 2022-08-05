---
layout: article
title: Projects, Namespaces, and Quotas
permalink: /docs/quotas.html
key: snakemake
aside:
  toc: true
sidebar:
  nav: docs
---
Our container platform uses resource quotas on *Projects* and *Namespaces*. Quota is limitation on how much resources can user or group of users utilize. Kubernetes use two kinds of resource quotas: *requests* and *limits*. See [kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) for more information about this concept. Currently applied quotas are on *CPU* and *Memory* resources. These quotas are set on both *Project* and *Namespace*.

*Default Project* and default *Namespace* has 20 CPUs *request*, 32 CPUs *limit*, 40GB Memory *requests*, and 64GB Memory *limits*. Other types of quotas are not set. User can request a new project with significantly larger quotas at <a href="mailto:k8s@ics.muni.cz">IT Service desk</a>.

## Resource Limits

If running container exceeds limits, result depends on resource type. If resource is CPU, container continues to run only the CPU is limited, i.e., it runs slower. If resource is Memory or ephemeral-storage, container is *evicted*, it can be restarted in case of *Deployment* but resource is not extended automatically, so eviction is likely to happen again.

## Consequences

* Every Pod, Job, Deployment, and any other kind that runs a container needs *resources* attribute to be set otherwise deploy is rejected with similar error:
```
Pods "master-685f855ff-gg9sr" is forbidden: failed quota: default-w2qv7: must specify limits.cpu,limits.memory,requests.cpu,requests.memory:Deployment does not have minimum availability.
```
 However, this should not happen for user as we set default container resources to 1 CPU and 512MB Memory for both *requests* and *limits*. This default is applied only in the case that user did not specify resources.

* Quotas cannot be overbooked, so sum of quotas for all namespaces within a project must not be larger than the project quota. As we set initial *namespace* quota to be equal to *Project*, there is no room for additional namespaces. Users can create additional namespace but they need to decrease quotas on initial *namespace* first or request extending *project* quotas.

* If users deploy more containers than quota allows, *Pods* are rejected immediately, *Jobs* and other types of deployment are pending until there are free resources within the quota.

* Setting quotas on GPU resource is currently not possible.
