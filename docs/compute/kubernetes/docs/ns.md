---
layout: article
title: Namespaces
permalink: /docs/ns.html
key: ns
aside:
  toc: true
sidebar:
  nav: docs
---

In Kubernetes, [namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) provides a mechanism for isolating groups of resources within a single cluster. Names of resources need to be unique within a namespace, but not across namespaces. 

Names of namespaces need to be unique within a cluster. I.e., it is usually not a good idea to create namespace called *test* and so on.

If user logs in into Ranger GUI, *Personal Project* and a *Namespace* is created in just after first login, if you do not see any, just reload the web page.

User can check his/hers Namespaces on `Rancher` site in the left tabl `Project/Namespaces` 

![kube ns](ns.jpg)

User can create additional namespaces either using kubectl or in the Rancher GUI. Creating namespaces using kubectl is not recommended way, therefore no example here, as kubectl's created namespaces are not linked to user *Project*. Instead, a user should create namespace in Rancher GUI in Namespace overview hitting `Create Namespace` button.
