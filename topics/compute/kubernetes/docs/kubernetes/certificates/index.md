---
layout: article
title: Certificate
permalink: /docs/certificate.html
key: certificate
aside:
  toc: true
sidebar:
  nav: docs
---

Kubernetes can issue and manage custom trusted certificates using ACME protocol. Certificates are stored as secrets.

This is especially important for enabling TLS when exposing non-web applications, therefore without ingress.

Currently, there are four issuers available:
* `letsencrypt-prod` issuer is web-only and automatically checks the web on provided domain name during issuing process. It is automatically used when exposing application through [ingress](/containers/kubernetes/expose/#web-based-applications).
* `letsencrypt-prod-dns` issuer is for other applications. The difference is checking through dns. However, the dns checking is slower, because the dns change must be propagated first.
* `letsencrypt-stage` is the same as `letsencrypt-prod` but it uses staging servers suitable for testing.
* `letsencrypt-stage-dns` is the same as `letsencrypt-prod-dns` but it uses staging servers suitable for testing.

To issue a kubernetes-managed certificate, the following configuration can be used.
```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: application-dyn-cloud-e-infra-cz-tls
spec:
  secretName: application-dyn-cloud-e-infra-cz-tls
  issuerRef:
    group: cert-manager.io
    kind: ClusterIssuer
    name: letsencrypt-prod-dns
  dnsNames:
  - "application.dyn.cloud.e-infra.cz"
  usages:
  - digital signature
  - key encipherment
```
Where `metadata.name`, `spec.secretName` refer to the name of generated certificate. The `spec.dnsNames` items are the target dns names of the certificate. Issuer is specified in the `spec.issuerRef.name` and should be set to `letsencrypt-prod-dns`.

The configuration generates an secret specified in `spec.secretName`, containing certificate and private key pair.
