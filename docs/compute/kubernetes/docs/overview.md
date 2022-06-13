---
layout: article
title: Container Platform Overview
permalink: /docs/overview.html
key: overview
aside:
  toc: true
sidebar:
  nav: docs
---

Our container platform is based on [Kubernetes orchestrator](https://kubernetes.io/) and [docker](https://hub.docker.com/) container images. We addopted [rancher](https://rancher.com) Kubernetes distribution so our platform UI is available through [Rancher Dashboard](https://rancher.cloud.e-infra.cz). Currently, the platform is built on Linux and x86\_64 binary architecture (no Arm or Microsoft Windows is possible), we provide GPU accelerators (currently NVIDIA only), and SSD storage. Soon, we will provide also InfiniBand 100Gbps interconnect fabrics.

In general, this platform can be used for almost anything starting with a simple web application, see [hello world](/docs/kubectl-helloworld.html) example, continuing to running whole remote desktop, see e.g., [ansys](ansys.md) application, or running complex workflow pipeline, see e.g., [nextflow](/docs/nextflow.html). 

This platform offers users to focus solely on their applications, so that required knowledge comprises of using the application or containerizing the application only. In the latter case, knowledge of creating dockerfiles is required (see [dockerfile](/docs/dockerfile.html) section). However, almost no knowledge of infrastructure is needed such as mounting `NFS` and so on.

To be able to use this platform, academic affiliation or sponsored account is required. User can login via CESNET AAI, Elixir AAI or EGI AAI. No additional membership is required for *default* project with limited resources.

End user can use this platform in the following three ways:

1. Utilize prepared applications by infrastructure, see [Rancher Applications](/docs/rancher-applications.html) in navigation on the left. 

2. Utilize existing docker images from all over the world hosted at a *registry* such as [hub.docker.com](https://hub.docker.com), in this case, see [limitations](/docs/limitations.html). 

3. Skilled users can also prepare their own application by themselves, see [dockerfile](/docs/dockerfile.html) section.
