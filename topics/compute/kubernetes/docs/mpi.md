---
layout: article
title: MPI Job
permalink: /docs/mpi.html
key: mpi
aside:
  toc: true
sidebar:
  nav: docs
---

While [MPI](https://www.open-mpi.org/) jobs are traditional domain if High Performance Computing, our platform is capable of running MPI Jobs easily using mpi-operator from [kubeflow](https://www.kubeflow.org/).

To be able to run MPI job, there are two steps required: prepare specific Docker image and create MPIJob manifest.

## MPI Job Docker Image

MPIJob expects specific Docker Image, the image must contain openssh server and this server needs to be configured. Also creating some user in docker image is required. However, user needs to add the following fragment for Debian family distributions ([download here](/docs/deployments/Dockerfile-mpi)):

```dockerfile
RUN apt-get update && \
    apt-get -y --no-install-recommends install openmpi-bin openssh-server openssh-client bind9-host && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd

RUN useradd -m -u 1000 user

RUN sed -i 's/[ #]\(.*StrictHostKeyChecking \).*/ \1no/g' /etc/ssh/ssh_config && \
    echo "    UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config && \
    echo "StrictModes no" > /etc/ssh/sshd_config && \
    echo "PidFile /tmp/sshd.pid" >> /etc/ssh/sshd_config && \
    echo "HostKey ~/.ssh/id_rsa" >> /etc/ssh/sshd_config && \
    echo "Port 2222" >> /etc/ssh/sshd_config && \
    echo "ListenAddress 0.0.0.0" >> /etc/ssh/sshd_config && \
    sed -i 's/.*Port 22.*/   Port 2222/g' /etc/ssh/ssh_config

WORKDIR /data

RUN chown 1000:1000 /etc/ssh/ssh_config

CMD /usr/sbin/sshd -De
```

Of course, you need to add your application and base proper image like `tensorflow` or `pytorch`. The same image should be used for both `Launcher` and `Worker` Pods.

## MPI Job Manifest

You can [download](/docs/deployments/mpijob.yaml) example of MPI Job manifest. This example is **not working** as is. You need to specify `IMAGE` and `COMMAND`. User in the attribute `sshAuthMountPath` must match user name created in the docker image. The attribute `Worker.replicas` denotes how many workers to spawn, i.e., how many paralel jobs will run. Also the parameter `-n "2"` for `Launcher` needs to match `Worker.replicas`. Note, the number `2` must always be quoted `"2"`.

## Running the MPI Job

Once you have the docker image and the manifest ready, you run the MPI Job using:
```
kubectl create -f mpijob.yaml -n namespace
```
replacing `namespace` with your namespace. The *Launcher* jobs might be failing for a while, this is expected and normal. 
