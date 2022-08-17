# Best Practices for Writing Doc

This section contains conventions and best practices for writing the best possible documentation.

!!! note
    The section is work in progress.

## Authoring and responsibility

Each topic has responsible department or person which will be responsible for approving changes.

| Area      | Responsible                          |
| ----------- | ------------------------------------ |
| Homepage, navigation, general site       | @rosinec, Jan Siwiec |
| Accounts      | Pavel Zlamal |
| Data processing    | @rosinec |
| Data storage    | du.cesnet.cz |
| Managed Data Services | @rosinec |
| General Information    | @rosinec, Jan Siwiec |

## Passing Test in Doc Build

Each pipeline starts with four test jobs:

1. **capitalize** - checks capitalization of (sub)titles. Every word should start with a capital letter except for prepositions. Specific words with mixed lower- and uppercase letters (e.g. eINFRA) should be added as exceptions to the *.spelling* file.

1. **docs** - checks some standard rules of formatting to make the source code more "readable".
The most frequently occuring errors being: **trailing spaces** (i.e. multiple spaces at the EOL), **consecutive blank lines** or,
alternatively, **missing blank lines** (each element -- admonition, codeblock, (sub)title, image link, etc. -- must be divided by a blank line).
For a detailed list of the rules, see [https://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md][1].

1. **pylint** - don't know, but always passes :)

1. **pysafety** - related to missing security update for the tornado package, always fails (is allowed to fail)

## Contribution and Revision Process

TODO. Here we should write down some processess for revisions and merging requests for change.

[1]: https://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md
