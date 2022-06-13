---
layout: article
title: Security and Network Policy
permalink: /docs/security.html
key: vmd
aside:
  toc: true
sidebar:
  nav: docs
---
## Ingress Authentication

If user wants to utilize basic auth or oauth at ingress, it can be done as described in [official documentation](https://kubernetes.github.io/ingress-nginx/examples/auth/basic/) or in [our documentation](/docs/kubectl-expose.html).

This approach has one big security flaw. Authentication is required when connecting via ingress only, e.g., from outside of Kubernetes cluster. However, user of the platform can also connect from inside cluster directly to the corresponding service (they need to guess it IP though) and in such a case, there is no authentication required.

This flaw can be mitigated using [Network Policy](https://kubernetes.io/docs/concepts/services-networking/network-policies/) that can limit origin of network traffic. In this case, it is useful to allow ingress traffic to server from *kube-system* namespace only. The *kube-system* namespace hosts Ingress Nginx instance, therefore, connection from this and only this namespace is required.

Example of network policy can be [downloaded here](deployments/netpolicy/yaml). This policy allows ingress traffic from *kube-system* to Pod named `myapp`. This policy is applied to the *namespace* where the Pod `myapp` is.
