---
layout: article
title: Dockerfile
permalink: /docs/dockerfile.html
key: desktop
aside:
  toc: true
sidebar:
  nav: docs
---
## Docker Image

Docker image is essential component of container infrastructure. It is an image that contains an application and all its required parts (libraries and other files). 

Docker image is created usually using a `Dockerfile`. The `Dockerfile` contains commands that builds the image, environment variables, command to run when starting the container, entrypoint and many other items.

Docker images are named using the following schema: `registry/name:tag`. If `registry` is omitted, docker hub registry is used. Example of docker image name is: `cerit.io/xserver:v1.0`. 

Before building own docker image, it is strongly recommended to search public registry for an existing image that contains desired application, but also check what is the time stamp of last image, i.e., if someone makes new releases and bug fixes. We can recommend, e.g., `bitnami` images. There some limitation of using external docker images on our infrastructure, see [limitations](/docs/limitations.html).

## Create Own Docker Image

If you find it necessary to create own image, you find below a brief guide. For full guide see [official docker documentation](https://docs.docker.com/develop/). Knowledge of installing Linux applications and basics of Linux packaging systems is required.

Here you find most common Dockerfile commands:

1. `FROM image` -- defines image name you start your docker image from, e.g. `ubuntu`.
2. `RUN cmd` -- run command that modifies the starting image, more than one `RUN` command can be used.
3. `COPY localfile containerfile` -- copy local files into docker image, you can use optional `--chown=user:group` to change ownership during copy. Copy and changing ownership later using `RUN chown` is discouraged as resulting image is twice as big.
4. `USER uid` -- switch user to `uid` (or name), from this line, all other commands will run under identity of specified user, if this command was not used, everything is done as `root` user. The last `USER uid` directive also specifies as which user the container will run by default.
5. `CMD command` -- run `command` as default command when starting the container.
6. 'WORKDIR dir` -- specifies current working directory, last working directory will be used as initial directory in a running container.

Example of Dockerfile:
```dockerfile
FROM debian:buster
RUN apt update -y && apt upgrade -y && apt install build-essential libssh-dev git -y
RUN git clone https://gitlab.con/zvon/iobench && cd iobench && make && make install
USER 1000
CMD /bin/bash -c "tail -f /dev/null"
```

## Dockerfile Tips

* Container usually does not have any created user in `/etc/passwd`. In this case, you can see `I have no name` prompt. Also in this case, there is no `home` directory which defaults to `/`, many applications fail here as `/` will not be writable. It is recommended to create some default user that the container run as. Name of the user is not important. The following command will create group named `group` and user named `user`, double `user` at the end of the command is not an error. 
```dockerfile
RUN addgroup --gid 1000 group && \
    adduser --gid 1000 --uid 1000 --disable-password --gecos User user
```

* Container defaults to UTC time zone. If it not desired, it should be set to proper default, e.g. 
```dockerfile
RUN echo 'Europe/Prague' > /etc/timezone
```

* Packaging tools must not be interactive. E.g., for `deb` systems: 
```dockerfile
RUN DEBIAN_FRONTEND=noniteractive apt-get install -y curl
``` 
Do not forget to add `-y` to most of packaging tools.

* Debian family systems usually install recommended packages by default which is not desired here, disable it: 
```dockerfile
RUN apt-get install -y --no-install-recommends curl
```

* Keep resulting image as small as possible. It is needed to clean temporary files. E.g. for `deb`: 
```dockerfile
RUN apt-get update && apt-get -y install curl && apt-get clean && rm -rf /var/lib/apt/lists/*
``` 
for `conda`: 
```dockerfile
RUN conda install package && conda clean --all -f -y && rm -rf "~/.cache
```
**Cleaning must be done within a single `RUN` command.** 

* Each `RUN` command creates a new docker image layer. It is recommended to merge related commands into a single `RUN` command, e.g., install all required packages at once, not one by one.

* For Kubernetes, there is no need to use the `EXPOSE` command to publish network ports. See [Exposing applications](docs/kubectl-expose.html).

* Running `chown` or `chmod` doubles the size of changes files in the docker file, i.e., `chown` on all files in the docker file doubles the size of the docker file.

* If chaining commands, always chain with `&&` and never with just `;`. If one of commands fails, chaining with `&&` stops build of whole image which is mostly desired. Chaining with `;` can hide some failing commands and makes it hard to debug why image is not as it should be.

## Building Docker Image

### Manual Build

Once the `Dockerfile` is created, the docker image can be built. The following describes manual docker image building. Manual building can be useful for debugging build process.

To be able to build docker image locally, you need to have a computer with Linux and with installed docker. For docker installation, follow instruction for your Linux distribution, usually `docker-ce` is the right package. You may need to become member of `docker` group to be able to use docker.

Put the `Dockerfile` to a directory, e.g., `mydocker` and run the following replacing `repo/name:tag` with proper name and tag.
```
docker build -t repo/name:tag mydocker
```

If the build has been successful, image is locally built and needs to be pushed to a registry. If you are not logged into the registry, issue `docker login registry` replacing `registry` with real registry name. 
```
docker push repo/name:tag
```
The `repo/name:tag` must be exactly the same as in build case.

### Automated Build

Automated build can be done using so called CI/CD pipeline. Build is done using *runner* component which is a part of many github/gitlab installation. You can utilize [gitlab.ics.muni.cz](https://gitlab.ics.muni.cz), see [GitLab Containers](/docs/containers_build.html) how to do it. This gitlab also provides docker registry so once built image can be stored here for using from Kubernetes. Registry is public or private depending on the project settings, see [GitLab Containers](/docs/containers_build.html#how-to-use-images-from-gitlab-registry).

Automated build can be slow, so it is not best option for debugging build process.

## Running Docker Images

It can be useful to run the built image manually before running it on Kubernetes, e.g., checking that all the files are in place, important directories are writable and so on. Manual running is fast and has no restriction on privileges. However, be careful to run unknown images on own computer. To run docker image locally, you need Linux computer with installed docker, see manual build above.

Local run can be also useful for inspecting image, e.g., for getting `UID` of running user, if it is not known as `UID` may be needed for running in Kubernetes.

For testing purposes, you can run docker image using:
```
docker run -it --rm registry/name:tag command
```

This command will run the `registry/name:tag` image and runs the `commend` inside it. You can add `-u uid` to run the image as user `uid`.

If used image has `ENTRYPOINT` set, the `command` will not be run but only is passed as an argument to the `ENTRYPOINT` script. If you need to avoid running, you can pass `--entrypoint /bin/bash` option to `docker run`. However, not all images have `/bin/bash` or even `/bin/sh` available. In such a case, you need to rebuild the image and add/install `bash` or `sh`.

Hitting `ctrl-c` or `ctrl-d` terminates the running docker image. All modifications inside the container are lost unless you use `docker commit`, see [official docker documentation](https://docs.docker.com/develop/), in this case, do not use `--rm` option that removes exited images automatically. 
