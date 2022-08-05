---

title: Contribute to documentation
search:
  exclude: false
---

# Contribute to documentation

We use the OpenSource [MkDocs Material](https://github.com/squidfunk/mkdocs-material) project to generate the documentation.

## Requirements
Install [MkDocs Material](https://squidfunk.github.io/mkdocs-material/getting-started/).

## Work-flow Overview

1. Fork & clone repository
2. Create a branch
3. Commit your changes
4. Push to the branch
5. Create a Merge Request with the content of your branch

### Fork Repository
See [GitLab @ ICS MU](https://gitlab.ics.muni.cz/cloud/documentation/forks/new) for details. This will create your own clone of our repository where you will be able to make changes. Once you are happy with your changes, use GitLab to submit them to our original repository.

### Clone Repository
``` bash
# after creating your own copy of the repository on GitLab
git clone git@gitlab.ics.muni.cz:${GITLAB_USER}/documentation.git
```

### Create New Branch
``` bash
# in `mkdocs-material`
git checkout -b my_change
```

### Make Changes & Run Local Server
``` bash
# in `mkdocs-material`
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material
```

> Edits will be shown live in your browser window, no need to restart the server.

### Commit and Push Changes
``` bash
git commit -am "My updates"
git push origin my_change
```

### Submit Changes
Create a *Merge Request* via [GitLab @ ICS MU](https://gitlab.ics.muni.cz/cloud/documentation/merge_requests/new).

## Theme Documentation

Full theme documentation is available on page [squidfunk.github.io/mkdocs-material/](https://squidfunk.github.io/mkdocs-material/).
