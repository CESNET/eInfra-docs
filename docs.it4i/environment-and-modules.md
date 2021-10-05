# Environment and Modules

## Shells on Clusters

The table shows which shells are supported on the IT4Innovations clusters.

| Cluster Name    | bash | tcsh | zsh | ksh | dash |
| --------------- | ---- | ---- | --- | --- | ---- |
| Karolina        | yes  | yes  | yes | yes | yes  |
| Barbora         | yes  | yes  | yes | yes | no   |
| Salomon         | yes  | yes  | yes | yes | no   |
| DGX-2           | yes  | no   | no  | no  | no   |

!!! info
    BASH is the default shell. Should you need a different shell, contact support@it4i.cz.

## Environment Customization

After logging in, you may want to configure the environment. Write your preferred path definitions, aliases, functions, and module loads in the .bashrc file

```console
# ./bashrc

# users compilation path
export MODULEPATH=${MODULEPATH}:/home/$USER/.local/easybuild/modules/all

# User specific aliases and functions
alias qs='qstat -a'

# load default intel compilator !!! is not recommended !!!
ml intel

# Display information to standard output - only in interactive ssh session
if [ -n "$SSH_TTY" ]
then
 ml # Display loaded modules
fi
```

!!! note
    Do not run commands outputting to standard output (echo, module list, etc.) in .bashrc for non-interactive SSH sessions. It breaks the fundamental functionality (SCP, PBS) of your account. Take care for SSH session interactivity for such commands as stated in the previous example.

### Application Modules

!!! note

    Due to a different architecture, the Data Analytics compute node on Karolina has a different module tree. This issue is expected to be resolved by 15. October 2012.

In order to configure your shell for running particular application on clusters, we use a Module package interface.

Application modules on clusters are built using [EasyBuild][1]. The modules are divided into the following structure:

```
 base: Default module class
 bio: Bioinformatics, biology and biomedical
 cae: Computer Aided Engineering (incl. CFD)
 chem: Chemistry, Computational Chemistry and Quantum Chemistry
 compiler: Compilers
 data: Data management & processing tools
 debugger: Debuggers
 devel: Development tools
 geo: Earth Sciences
 ide: Integrated Development Environments (e.g. editors)
 lang: Languages and programming aids
 lib: General purpose libraries
 math: High-level mathematical software
 mpi: MPI stacks
 numlib: Numerical Libraries
 perf: Performance tools
 phys: Physics and physical systems simulations
 system: System utilities (e.g. highly depending on system OS and hardware)
 toolchain: EasyBuild toolchains
 tools: General purpose tools
 vis: Visualization, plotting, documentation and typesetting
 OS: singularity image
 python: python packages
```

!!! note
    The modules set up the application paths, library paths and environment variables for running particular application.

The modules may be loaded, unloaded, and switched according to momentary needs. For details, see [lmod][2].

[1]: software/tools/easybuild.md
[2]: software/modules/lmod.md
