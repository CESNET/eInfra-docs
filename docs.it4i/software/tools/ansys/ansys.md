# Overview of ANSYS Products

[SVS FEM][a] as [ANSYS Channel partner][b] for the Czech Republic provided all ANSYS licenses for our clusters and supports all ANSYS Products (Multiphysics, Mechanical, MAPDL, CFX, Fluent, Maxwell, LS-DYNA, etc.) to IT staff and ANSYS users. In case of a problem with ANSYS functionality, contact [hotline@svsfem.cz][c].

We provides commercial as well as academic variants. Academic variants are distinguished by the "**Academic...**" word in the license name or by the two letter preposition "**aa\_**" in the license feature name. Change of license is realized on command line or directly in the user's PBS file (see individual products).

To load the latest version of any ANSYS product (Mechanical, Fluent, CFX, MAPDL, etc.) load the module:

```console
$ ml ANSYS
```

ANSYS supports interactive mode, but due to assumed solution of extremely difficult tasks it is not recommended.

If the user needs to work in the interactive mode, we recommend to configure the RSM service on the client machine which allows to forward the solution to the cluster directly from the client's Workbench project (see ANSYS RSM service).

[a]: http://www.svsfem.cz/
[b]: http://www.ansys.com/
[c]: mailto:hotline@svsfem.cz
