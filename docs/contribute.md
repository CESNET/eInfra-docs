# Contribute To Documentation

There are several ways to contribute to the documentation
based on the user's proficiency with Git/GitLab. From the least to most proficient, these are:

## Forking Repository

Since this documentation is built with [MkDocs Material][1], you need to install it first. See the [official installation instructions][2].

Once you have MkDocs Material installed,
proceed with the following steps:

### Fork Repository
See GitLab @ ICS MU for details. This will create your own clone of our repository where you will be able to make changes. Once you are happy with your changes, use GitLab to submit them to our original repository.

### Clone Repository

```console
# after creating your own copy of the repository on GitLab
git clone git@gitlab.ics.muni.cz:einfra-docs/documentation.git
```

### Create New Branch

```console
# in `mkdocs-material`
git checkout -b my_change
```

### Make Changes & Run Local Server

```console
# in `mkdocs-material`
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material
```

!!! note
    Edits will be shown live in your browser window, no need to restart the server.

### Commit and Push Changes

```console
git commit -am "Commit message"
git push origin my_change
```

### Submit Changes

Create a *Merge Request* via GitLab @ ICS MU.

## Simple Merge Request

This option is suitable for less extensive contribution
(e.g. a section or a subsection) of an already existing page).

In this case, simply:

1. click the **Edit this page**
under the Table of Content on the right side of the respective page;
1. make the changes;
1. create a merge request.

## Contacting Support

The easiest way is to contact us at [support@e-infra.cz][3] with your contribution.

[1]: https://github.com/squidfunk/mkdocs-material
[2]: https://squidfunk.github.io/mkdocs-material/getting-started/
[3]: mailto:support@e-infra.cz
