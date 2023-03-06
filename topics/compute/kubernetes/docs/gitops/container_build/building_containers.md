---
layout: article
title: Building Docker containers with Gitlab
permalink: /docs/containers_build.html
key: containers_build
aside:
  toc: true
sidebar:
  nav: docs
---

This tutorial shows how to set up the basic GitLab pipeline to automaticaly build Docker image and publish it to a container registry.

## Prerequisites

- Gitlab repository
- Dockerfile in the repository with desired container configuration

## Configure CI/CD Gitlab Pipeline File

- In your desired repository, use **Set up CI/CD** button as shown in the following image.
![setup](./gitops/container_build/containers_1.png)

- In the `.gitlab-ci.yml` editor copy and paste following snippet:

```yaml
docker-build:
  image: docker:latest
  stage: build
  services:
    - docker:dind
  before_script:
    - docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" $CI_REGISTRY
  script:
    - |
      if [[ "$CI_COMMIT_BRANCH" == "$CI_DEFAULT_BRANCH" ]]; then
        tag=""
        echo "Running on default branch '$CI_DEFAULT_BRANCH': tag = 'latest'"
      else
        tag=":$CI_COMMIT_REF_SLUG"
        echo "Running on branch '$CI_COMMIT_BRANCH': tag = $tag"
      fi
    - docker build --pull -t "$CI_REGISTRY_IMAGE${tag}" .
    - docker push "$CI_REGISTRY_IMAGE${tag}"
  rules:
    - if: $CI_COMMIT_BRANCH
      exists:
        - Dockerfile
```

This will use the standard Gitlab Container Registry available within your own project. Note the variable `$CI_REGISTRY`, which is specific for the repository.

- Commit changes
![commit](./gitops/container_build/containers_2.png)

- Pipeline will be triggered and it's status could be shown within the last commit information.
![pipeline_status](./gitops/container_build/containers_3.png)
For list of jobs for given pipeline visit `CI/CD > Pipelines`
![pipelines](./gitops/container_build/containers_4.png)

If pipeline job succeeds, the freshly built container image will be uploaded to Gitlab's container registry.   
The `Packages & Registries > Container registry` is available here:
![sda](./gitops/container_build/containers_5.png)

For advanced information please refer to the [official documentation](https://docs.gitlab.com/ee/user/packages/container_registry/#container-registry-examples-with-gitlab-cicd)

## How to Use Images From GitLab Registry

If the project's visibility within GitLab is public and container registry is not limited to authenticated users, simply use:

```bash
docker run [options] registry.example.com/group/project/image [arguments]
```

> If you are using MUNI ICS GitLab, the registry URL is: registry.gitlab.ics.muni.cz

If project visibility or container registry are set to private, authentication to container registry is needed. You will need to create deploy token and use it as descibed in the [official documentation](https://docs.gitlab.com/ee/user/packages/container_registry/#authenticate-with-the-container-registry)

For more information please refer to [official documentation](https://docs.gitlab.com/ee/user/packages/container_registry/#use-images-from-the-container-registry).

## Upload Image to Custom Container Registry

Change the options of `docker login` command in `before_script` part of your definition of pipeline (`gitlab-ci.yml`).

```yaml
  before_script:
    - docker login -u "username" -p "password" example.io
```
