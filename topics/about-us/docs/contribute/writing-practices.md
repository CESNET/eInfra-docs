# Best Practices for Writing Doc

This section contains conventions and best practices for writing the best possible documentation.

!!! note
    The section is work in progress.

## Passing Test in Doc Build

Each pipeline starts with four test jobs:

1. **capitalize** - checks capitalization of (sub)titles. Every word should start with a capital letter except for prepositions. Non-standard words with mixed lower- and uppercase letters (e.g. eINFRA) should be added to the *.spelling* file.

1. **docs** - checks some standard rules of formatting to make the source code more "readable".
The most important being: **trailing spaces** (multiple spaces at the EOL), **consecutive blank lines** or,
alternatively, **missing blank lines** (each element -- admonition, codeblock, (sub)title, img link -- must be divided by a blank line).

1. **pylint** - don't know, but always passes :)

1. **pysafety** - related to missing security update for the tornado package, always fails (is allowed to fail)

## Contribution and Revision Process

TODO. Here we should write down some processess for revisions and merging requests for change.
