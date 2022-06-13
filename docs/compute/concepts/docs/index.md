
## Which MetaCentrum cloud do I need?

There are multiple MetaCentrum cloud environments:

- MetaCentrum OpenStack
- MetaCentrum Kubernetes
- MetaCentrum Sensitive

Each of them is targetting different use-cases. General rules of thumb are:

1. You need to use MetaCentrum Sensitive if your application deals with sensitive data.
1. You want to consider MetaCentrum Kubernetes if your application is already containerized and does not require any special environment (such as VM isolation, networking separation or specific networking configuration, ...).
1. Otherwise look into MetaCentrum OpenStack.
