---
layout: article
title: Kubectl
permalink: /docs/kubectl.html
key: kubectl
aside:
  toc: true
sidebar:
  nav: docs
---

## Kubectl

`Kubectl` is a powerful tool for interacting with Kubernetes clusters. For installation, see [official documentation](https://kubernetes.io/docs/tasks/tools/#kubectl). After installation, a `kube config` file is required to function. The file is located in cluster overview dashboard (click on the cluster name in the upper left dropdown menu).

![kube config](config.jpg)

Copy contents of this file into `$HOME/.kube/config` and change permissions to 700 (`chmod 700 $HOME/.kube/config`). 

It is possible to have multiple cluster configurations in one config file. More about working with `kubectl` with access to multiple clusters [here](/docs/rancher-multiple.html).
