# Set up and work locally

One of the mechanisms to work with the documentation is to run it on your computer using Docker. This allows you to work offline and see the documentation rendered in a web browser.

## Prerequisites

- [Git][1]
- [Docker][2]

## Fork Repository

Fork the [e-INFRA CZ documentation repository][3]. This will create your own clone of upstream e-INFRA CZ documentation repository where you will be able to make changes. Once you are happy with your changes, use GitLab to submit them to our original repository.

## Clone Repository

```console
# after creating your own copy of the repository on GitLab
git clone git@gitlab.ics.muni.cz:einfra-docs/documentation.git
```

## Create New Branch

At the moment there is no convention on how to name the feature branches. Try to make clear what feature will be added within the new branch.

```console
# in `documentation` folder
git checkout -b my_change
```

## Make Changes & Run Local Server

You can edit the documentation and run local server to see changes live. Use our `start.sh`, which will use our production [Docker][2] container and will create production version server of the documentation locally on your PC. Then go to [http://localhost:8080][4] to see changes, from now, every change will reload the page in the browser automatically.

```console
./start.sh
```

By default the URL where the server listens is [http://localhost:8080][4]

!!! note
    Edits will be shown live in your browser window, no need to restart the server.

### Partial documentation building

If you don't want to build the whole documentation (due to its big build time), you can choose to build only subset of the whole documentation site by using argument `-f <path to mkdocs.yml of subdocumentation>`

```console
./start.sh -f topics/about-us/mkdocs.yml
```

## Publishing changes

Now you are ready to send changes to your forked repository of the e-INFRA CZ documentation.

### Commit and Push Changes

If you are satisfied with your changes and you did build the whole documentation to review you changes in the context of the whole site commit and push changes to main repository:

```console
git commit -am "Commit message"
git push --set-upstream origin my_change
```

### Submit Changes

Create a *Merge Request* via GitLab @ ICS MU to send __your__ changes to __upstream__ repository. Please refer to the tutorial on how to create merge request to upstream repository at [Gitlab documentation][5]. 

[1]: https://git-scm.com/downloads
[2]: https://docs.docker.com/get-docker/
[3]: https://gitlab.ics.muni.cz/einfra-docs/documentation
[4]: http://localhost:8080
[5]: https://docs.gitlab.com/ee/user/project/repository/forking_workflow.html#merging-upstream
