# Documentation overview

## Structure of the documentation
Thanks to the [Monorepo][1] plugin for the mkdocs platform, it is possible to enable a documentation structure consisting of sub-topic-related documentation.

The documentation is organized to categories (2nd level folders) and topics (3rd level folders). See following output for reference.   
```console
.
├── docs
│   ├── about-us
|   |   |-- docs
│   │   └── mkdocs.yml
│   ├── ...
│   ├── compute
│   │   ├── concepts
|   |   |   |-- docs
|   |   |   └── mkdocs.yml
|   |   |-- ...
│   │   └── supercomputing
|   |       |-- docs
|   |       └── mkdocs.yml
│   └── assets
│       ├── css
│       └── js
|── e-infra_theme
|── mkdocs.yml
```

Earch e-INFRA service is represented by it's own topic, therefore folder structure consisting of `mkdocs.yml` file and `docs` folder.

## Documentation configuration - mkdocs.yml

The most important part of the child documentation is `mkdocs.yml` file, where the navigation and structure of the documentation is defined. The important options are:
```yml title="Example of mkdocs.yml"
site_name: "computing/cloud/openstack"
nav:
    - 'index.md'
    - 'about.md'
```

## Building documentation

It is possible to build whole documentation or just it's small fraction.   

[See how to build documentation here][2].


[1]: https://github.com/backstage/mkdocs-monorepo-plugin
[2]: ./set-up-and-work-localy