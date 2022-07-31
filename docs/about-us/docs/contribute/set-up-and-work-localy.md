# Set up and work localy

There are several ways to contribute to the documentation
based on the user's proficiency with Git/GitLab. From the least to most proficient, these are:    

- [Forking Repository](#forking-repository)    
- [Simple Merge Request (using GitLab web interface)](/#simple-merge-request-using-gitlab-web-interface)    

## Prerequisites
- [Git][1]
- [Docker][2]

## Forking Repository

### Fork Repository
See GitLab @ ICS MU for details. This will create your own clone of our repository where you will be able to make changes. Once you are happy with your changes, use GitLab to submit them to our original repository.

### Clone Repository

```console
# after creating your own copy of the repository on GitLab
git clone git@gitlab.ics.muni.cz:einfra-docs/documentation.git
```

### Create New Branch

```console
# in `documentation` folder
git checkout -b my_change
```

### Make Changes & Run Local Server

Use our `start.sh`, which will use our production [Docker][4] container and will create production version server of the documentation locally on your PC.
```console
# in `mkdocs-material`
./start.sh
```

!!! note
    Edits will be shown live in your browser window, no need to restart the server.

### Partial documentation building

If you don't want to build the whole documentation (due to it's big build time), you can choose to build only subset of the whole documentation site by using argument `-f <path to mkdocs.yml of subdocumnetation>`
```console
./start.sh -f /docs/compute/kubernetes/mkdocs.yml
```

### Publishing changes

#### Commit and Push Changes

If you are satisfied with your changes and you did build the whole documentation to review you changes in the context of the whole site commit and push changes to main respository:

```console
git commit -am "Commit message"
git push --set-upstream origin my_change
```

#### Submit Changes

Create a *Merge Request* via GitLab @ ICS MU.

[1]: https://git-scm.com/downloads
[2]: https://docs.docker.com/get-docker/
[3]: https://docs.e-infra.cz
[4]: ../push-contribution-to-the-repository