# Documentation overview

## Structure of the documentation
Thanks to the [Monorepo][1] plugin for the mkdocs platform, it is possible to create a documentation structure consisting of sub-topic-related documentation.

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

Each e-INFRA service is represented by it's own topic, therefore folder structure consisting of `mkdocs.yml` file and `docs` folder.

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

## Publishing changes

Once the changes to the documentation has beed made locally or within the Gitlab graphical editor, it is important to publish it a make it visible on the main documentation domain. The changes will go through automatic checks and final review of our editor staff.

[Please refer to this documentation page to see how][3]


[1]: https://github.com/backstage/mkdocs-monorepo-plugin
[2]: ../set-up-and-work-localy
[3]: ../push-contribution-to-the-repository