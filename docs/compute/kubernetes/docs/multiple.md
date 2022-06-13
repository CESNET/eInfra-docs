---
layout: article
title: Multiple Clusters
permalink: /docs/rancher-multiple.html
key: rancher-multiple
aside:
  toc: true
sidebar:
  nav: docs
---

One person can posses access rights to multiple clusters. To work with them, every cluster's `config` must be available in either:
- `$HOME/.kube/config`
- in separate file but then `-f [filename]` must be specified when using `kubectl`

It's much more convenient to squash multiple cluster configs into one because you don't have to worry where your namespace lies. 

## Merging configs
If your `config` already has some content, it looks similar to:

```yaml
apiVersion: v1
kind: Config
clusters:
- name: "hdha-cluster"
  cluster:
    server: "https://rancher.cerit-sc.cz/k8s/clusters/c-qgxlf"

users:
- name: "hdha-cluster"
  user:
    token: [token]


contexts:
- name: "hdha-cluster"
  context:
    user: "hdha-cluster"
    cluster: "hdha-cluster"

current-context: "hdha-cluster"
```

To add another cluster, go to its `config` file in Rancher and do not copy whole file, only necessary parts, namely:
- item under `clusters` section which will be placed as new item under `clusters` in existing config
- item under `contexts` section which will be placed as new item under `contexts` in existing config
- item under `users` section which will be placed as new item under `users` in existing config
 
This is config you want to add. Copy only parts labeled with *.

```yaml
apiVersion: v1
kind: Config
clusters:
*- name: "hdhu-cluster"
  cluster:
    server: "https://rancher.cerit-sc.cz/k8s/clusters/c-sprdw"*

users:
*- name: "hdhu-cluster"
  user:
    token: [token]*


contexts:
*- name: "hdhu-cluster"
  context:
    user: "hdhu-cluster"
    cluster: "hdhu-cluster"*

current-context: "hdhu-cluster"
```

and place them in existing `config` file. The `token` value is unique but always the same across all clusters for every logged in person .
Therefore you could have only item under `users` section and change to this value in each `user` occurrence in `contexts`. Nevertheless, it is simpler and not so prone to errors when the value is copied and used as is.
Final file looks similar to this:

```yaml
apiVersion: v1
kind: Config
clusters:
- name: "hdha-cluster"
  cluster:
    server: "https://rancher.cerit-sc.cz/k8s/clusters/c-qgxlf"
- name: "hdhu-cluster"
  cluster:
    server: "https://rancher.cerit-sc.cz/k8s/clusters/c-sprdw"

users:
- name: "hdha-cluster"
  user:
    token: [token]
- name: "hdhu-cluster"
  user:
    token: [token]


contexts:
- name: "hdha-cluster"
  context:
    user: "hdha-cluster"
    cluster: "hdha-cluster"
- name: "hdhu-cluster"
  context:
    user: "hdhu-cluster"
    cluster: "hdhu-cluster"

current-context: "hdha-cluster"
```
