---
layout: article
title: Limitations of Running Docker Images 
permalink: /docs/limitations.html
key: desktop
aside:
  toc: true
sidebar:
  nav: docs
---
## No Root

While it is not common feature, in our container platform, user cannot run docker image with escalated privileges, i.e., as `root` user or using risen `capability`. Privilege escalation is not possible even when running the docker image, so `sudo` or `su` commands cannot be used. It is also not possible to use more than one user in the container, there is no mechanism left how to switch between two users. 

To meet his requirement, either docker image has to specify user that to image run as, or specifying `runAsUser: UID` in corresponding YAML file. E.g., `USER 1000` in the Dockerfile. Specifying `UID` and **not a name** is hard requirement. If you try to run image that does not have numeric `UID`, you receive the following error replacing `taskmaster` with actually used name.
```
Error: container has runAsNonRoot and image has non-numeric user (taskmaster), cannot verify user is non-root 
```

If `USER` in Dockerfile or `runAsUser` in YAML is not specified, you receive the following error:
```
Error: container has runAsNonRoot and image will run as root 
```
To fix it, you need to specify either `USER`, e.g., `USER 1000`, or `runAsUser`, e.g., `runAsUser: 1000` in YAML.

On the other hand, you have full root capability during docker image building.

## Consequences

* You cannot install any package into running container unless you prepare the container in advance using:

  1. Install `fakeroot` package
  2. Run `chown -R uid /etc /lib* /usr /var /bin` during docker build process. Replace `uid` with real user id, e.g., 1000.
 
  However, this is anti-pattern of using docker images, you should avoid this approach mainly because if running container is restarted which can happen sometimes, all installed packages and other modifications are lost.

* You cannot bind port below 1024. It means that services needs to listen on higher ports, e.g., 8080 and so on. This does not mean you cannot create a service, that listens on port 443 or 80 for outside world. Just follow [Exposing applications](/docs/kubectl-expose.html). This issue is mostly related to web servers (like nginx and apache, for nginx there is prepared non-privileged container: `nginxinc/nginx-unprivileged:latest`), ssh server, samba server. All these server can be reconfigured to listen on higher ports.

* You cannot write to e.g., `/run` or `/var/log/` directories. In this case, you do not need to rebuild image and change rights. There is workaround mounting `emptyDir` volume into those directories. Just merge the following two fragments in deployment YAML:

```
volumes:
- name: log
  emptyDir: {}

volumeMounts:
- name: log
  mountPath: /var/log
```
If there are `volumes` and `volumeMounts` sections already, just add these items without the `volumes` and `volumeMounts` lines.
