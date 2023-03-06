# Technical Details

Technical details for nerds.

## Structure of the Documentation

Thanks to the [Monorepo][1] plugin for the mkdocs platform, it is possible to create a documentation structure consisting of sub-topic-related documentation.

The documentation is organized to topics.

```console
.
├── topics
│   ├── about-us
|   |   |-- docs
│   │   └── mkdocs.yml
│   ├── storage
│   └── compute
│       ├── concepts
|       |   |-- docs
|       |   └── mkdocs.yml
|       |-- ...
│       └── supercomputing
|           |-- docs
|           └── mkdocs.yml
|── docs
│   └── assets
│       ├── css
│       └── js
|── e-infra_theme
└── mkdocs.yml
```

Each e-INFRA service is represented by it's own topic, therefore folder structure consists of `topics`, `docs`, `mkdocs.yml` file and `e-infra_theme` folder. Which are essential files in the documentation system.

## Documentation Configuration - mkdocs.yml

The most important part of the child documentation is `mkdocs.yml` file, where the navigation and structure of the documentation is defined. The important options are:

```yml title="Example of mkdocs.yml"
site_name: "computing/cloud/openstack" # will be used in URL
nav:
    - 'index.md'
    - 'about.md'
```

## Using Git Submodules

The documentation can be composed from different git repositories thanks to the `git submodules` concept. To add new submodule, use standard `git submodule` commands.
The resulting file, where submodule should be registered is `.gitsubmodule`. Example of such file can be observed within the documentation project in the root directory (or in following code snippet).

!!! warning

    The changes in the submodule at the source location can't trigger CI/CD pipeline of e-INFRA CZ documentation. However the pipeline is being run periodicaly in the midnight.

```config title="Example of .gitmodules"
[submodule "user/awesome_project"]
    path = topics/compute/supercomputing/docs
    url = https://<username>:<deploy_token>@gitlab.example.com/user/awesome_project.git
```

Use `topics/compute/supercomputing` as current working example of how to use the `git submodules`.

## Integration of New Service

As service owner you can easily integrate your service documentation within the main repository or use submodule.
To establish right place for the service documentation, please contact us at support@e-infra.cz.

## Development Process

The development process of the documentation is supported by CI/CD. Each commit to any remote branch will trigger an automatic pipeline that will try deploy changed documentation to the desired location.

Pipeline consists of:

1. Various test, see more at [writing practices page][2]
1. Building documentation - runinng `mkdocs build`
1. Pushing resulted artifact (final documentation site) to:
    1. If changes were pushed to the __main__ branch, the site is deployed to the **docs.e-infra.cz** immidiately.
    2. If changes were pushed to the __any other__ branch, the site is deployed to the special URL for review - **docs.e-infra.cz/review/branch_name**

Please note, the pipeline is being run also 10 minutes after midnight each day to ensure, that submodule components of the documentation are being updated.

[1]: https://github.com/backstage/mkdocs-monorepo-plugin
[2]: ../style-guide/writing-practices
