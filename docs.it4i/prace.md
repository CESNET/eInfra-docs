# PRACE User Support

## Introduction

PRACE users coming to the TIER-1 systems offered through the DECI calls are, in general, treated as standard users, so most of the general documentation applies to them as well. This section shows the main differences for quicker orientation, but often uses references to the original documentation. PRACE users who do not undergo the full procedure (including signing the IT4I AuP on top of the PRACE AuP) will not have a password and thus an access to some services intended for regular users. However, even with the limited access, they should be able to use the TIER-1 system as intended. If the same level of access is required, see the [Obtaining Login Credentials][1] section.

All general [PRACE User Documentation][a] should be read before continuing reading the local documentation here.

## Help and Support

If you need any information, request support, or want to install additional software, use PRACE Helpdesk.

Information about the local services are provided in the [introduction of general user documentation Salomon][2] and [introduction of general user documentation Barbora][3]. Keep in mind, that standard PRACE accounts don't have a password to access the web interface of the local (IT4Innovations) request tracker and thus a new ticket should be created by sending an email to support[at]it4i.cz.

## Obtaining Login Credentials

In general, PRACE users already have a PRACE account set up through their HOMESITE (institution from their country) as a result of a rewarded PRACE project proposal. This includes signed PRACE AuP, generated and registered certificates, etc.

If there is a special need, a PRACE user can get a standard (local) account at IT4Innovations. To get an account on a cluster, the user needs to obtain the login credentials. The procedure is the same as for general users of the cluster, see the corresponding [section of the general documentation here][1].

## Accessing the Cluster

### Access With GSI-SSH

For all PRACE users, the method for interactive access (login) and data transfer based on grid services from Globus Toolkit (GSI SSH and GridFTP) is supported.

The user will need a valid certificate and to be present in the PRACE LDAP (contact your HOME SITE or the Primary Investigator of your project for LDAP account creation).

For more information, see [PRACE FAQ][b]

Before you start using any of the services, do not forget to create a proxy certificate from your certificate:

```console
$ grid-proxy-init
```

To check whether your proxy certificate is still valid (12 hours by default), use:

```console
$ grid-proxy-info
```

To access the cluster, several login nodes running the GSI SSH service are available. The service is available from public Internet as well as from the internal PRACE network (accessible only from other PRACE partners).

#### Access From PRACE Network:

It is recommended to use the single DNS name **name-cluster**-prace.it4i.cz which is distributed between the four login nodes. If needed, the user can log in directly to one of the login nodes. The addresses are:

Salomon cluster:

| Login address                | Port | Protocol | Login node                       |
| ---------------------------- | ---- | -------- | -------------------------------- |
| salomon-prace.it4i.cz        | 2222 | gsissh   | login1, login2, login3 or login4 |
| login1-prace.salomon.it4i.cz | 2222 | gsissh   | login1                           |
| login2-prace.salomon.it4i.cz | 2222 | gsissh   | login2                           |
| login3-prace.salomon.it4i.cz | 2222 | gsissh   | login3                           |
| login4-prace.salomon.it4i.cz | 2222 | gsissh   | login4                           |

```console
$ gsissh -p 2222 salomon-prace.it4i.cz
```

When logging from other PRACE system, the prace_service script can be used:

```console
$ gsissh `prace_service -i -s salomon`
```

#### Access From Public Internet:

It is recommended to use the single DNS name **name-cluster**.it4i.cz which is distributed between the four login nodes. If needed, the user can login directly to one of the login nodes. The addresses are:

Salomon cluster:

| Login address                | Port | Protocol | Login node                       |
| ---------------------------- | ---- | -------- | -------------------------------- |
| salomon.it4i.cz              | 2222 | gsissh   | login1, login2, login3 or login4 |
| login1.salomon.it4i.cz       | 2222 | gsissh   | login1                           |
| login2-prace.salomon.it4i.cz | 2222 | gsissh   | login2                           |
| login3-prace.salomon.it4i.cz | 2222 | gsissh   | login3                           |
| login4-prace.salomon.it4i.cz | 2222 | gsissh   | login4                           |

```console
$ gsissh -p 2222 salomon.it4i.cz
```

When logging from other PRACE system, the prace_service script can be used:

```console
$ gsissh `prace_service -e -s salomon`
```

Although the preferred and recommended file transfer mechanism is [using GridFTP][5], the GSI SSH implementation also supports SCP, so for small files transfer, gsiscp can be used:

```console
$ gsiscp -P 2222 _LOCAL_PATH_TO_YOUR_FILE_ salomon.it4i.cz:_SALOMON_PATH_TO_YOUR_FILE_
$ gsiscp -P 2222 salomon.it4i.cz:_SALOMON_PATH_TO_YOUR_FILE_ _LOCAL_PATH_TO_YOUR_FILE_
$ gsiscp -P 2222 _LOCAL_PATH_TO_YOUR_FILE_ salomon-prace.it4i.cz:_SALOMON_PATH_TO_YOUR_FILE_
$ gsiscp -P 2222 salomon-prace.it4i.cz:_SALOMON_PATH_TO_YOUR_FILE_ _LOCAL_PATH_TO_YOUR_FILE_
```

### Access to X11 Applications (VNC)

If the user needs to run X11 based graphical application and does not have a X11 server, the applications can be run using VNC service. If the user is using a regular SSH based access, see this [section in general documentation][6].

If the user uses a GSI SSH based access, then the procedure is similar to the [SSH based access][6], only the port forwarding must be done using GSI SSH:

```console
$ gsissh -p 2222 salomon.it4i.cz -L 5961:localhost:5961
```

### Access With SSH

After they successfully obtain the login credentials for the local IT4Innovations account, the PRACE users can access the cluster as regular users using SSH. For more information, see this [section in general documentation][9].

## File Transfers

PRACE users can use the same transfer mechanisms as regular users (if they have undergone the full registration procedure). For more information, see the [Accessing the Clusters][9] section.

Apart from the standard mechanisms, for PRACE users to transfer data to/from the Salomon cluster, a GridFTP server running the Globus Toolkit GridFTP service is available. The service is available from public Internet as well as from the internal PRACE network (accessible only from other PRACE partners).

There is one control server and three backend servers for striping and/or backup in case one of them would fail.

### Access From PRACE Network

Salomon cluster:

| Login address                 | Port | Node role                   |
| ----------------------------- | ---- | --------------------------- |
| gridftp-prace.salomon.it4i.cz | 2812 | Front end /control server   |
| lgw1-prace.salomon.it4i.cz    | 2813 | Backend / data mover server |
| lgw2-prace.salomon.it4i.cz    | 2813 | Backend / data mover server |
| lgw3-prace.salomon.it4i.cz    | 2813 | Backend / data mover server |

Copy files **to** Salomon by running the following commands on your local machine:

```console
$ globus-url-copy file://_LOCAL_PATH_TO_YOUR_FILE_ gsiftp://gridftp-prace.salomon.it4i.cz:2812/home/prace/_YOUR_ACCOUNT_ON_SALOMON_/_PATH_TO_YOUR_FILE_
```

Or by using prace_service script:

```console
$ globus-url-copy file://_LOCAL_PATH_TO_YOUR_FILE_ gsiftp://`prace_service -i -f salomon`/home/prace/_YOUR_ACCOUNT_ON_SALOMON_/_PATH_TO_YOUR_FILE_
```

Copy files **from** Salomon:

```console
$ globus-url-copy gsiftp://gridftp-prace.salomon.it4i.cz:2812/home/prace/_YOUR_ACCOUNT_ON_SALOMON_/_PATH_TO_YOUR_FILE_ file://_LOCAL_PATH_TO_YOUR_FILE_
```

Or by using the prace_service script:

```console
$ globus-url-copy gsiftp://`prace_service -i -f salomon`/home/prace/_YOUR_ACCOUNT_ON_SALOMON_/_PATH_TO_YOUR_FILE_ file://_LOCAL_PATH_TO_YOUR_FILE_
```

### Access From Public Internet

Salomon cluster:

| Login address           | Port | Node role                   |
| ----------------------- | ---- | --------------------------- |
| gridftp.salomon.it4i.cz | 2812 | Front end /control server   |
| lgw1.salomon.it4i.cz    | 2813 | Backend / data mover server |
| lgw2.salomon.it4i.cz    | 2813 | Backend / data mover server |
| lgw3.salomon.it4i.cz    | 2813 | Backend / data mover server |

Copy files **to** Salomon by running the following commands on your local machine:

```console
$ globus-url-copy file://_LOCAL_PATH_TO_YOUR_FILE_ gsiftp://gridftp.salomon.it4i.cz:2812/home/prace/_YOUR_ACCOUNT_ON_SALOMON_/_PATH_TO_YOUR_FILE_
```

Or by using the prace_service script:

```console
$ globus-url-copy file://_LOCAL_PATH_TO_YOUR_FILE_ gsiftp://`prace_service -e -f salomon`/home/prace/_YOUR_ACCOUNT_ON_SALOMON_/_PATH_TO_YOUR_FILE_
```

Copy files **from** Salomon:

```console
$ globus-url-copy gsiftp://gridftp.salomon.it4i.cz:2812/home/prace/_YOUR_ACCOUNT_ON_SALOMON_/_PATH_TO_YOUR_FILE_ file://_LOCAL_PATH_TO_YOUR_FILE_
```

Or by using the prace_service script:

```console
$ globus-url-copy gsiftp://`prace_service -e -f salomon`/home/prace/_YOUR_ACCOUNT_ON_SALOMON_/_PATH_TO_YOUR_FILE_ file://_LOCAL_PATH_TO_YOUR_FILE_
```

Generally, both shared file systems are available through GridFTP:

| File system mount point | Filesystem | Comment                                                        |
| ----------------------- | ---------- | -------------------------------------------------------------- |
| /home                   | Lustre     | Default HOME directories of users in format /home/prace/login/ |
| /scratch                | Lustre     | Shared SCRATCH mounted on the whole cluster                    |

More information about the shared file systems on Salomon is available [here][10].

!!! hint
    The `prace` directory is used for PRACE users on the SCRATCH file system.

Salomon cluster /scratch:

| Data type                    | Default path                    |
| ---------------------------- | ------------------------------- |
| large project files          | /scratch/work/user/prace/login/ |
| large scratch/temporary data | /scratch/temp/                  |

## Usage of the Cluster

There are some limitations for PRACE users when using the cluster. By default, PRACE users are not allowed to access special queues in the PBS Pro to have high priority or exclusive access to some special equipment like accelerated nodes and high memory (fat) nodes. There may also be restrictions on obtaining a working license for the commercial software installed on the cluster, mostly because of the license agreement or because of insufficient amount of licenses.

For production runs, always use scratch file systems. The available file systems on Salomon is described [here][10].

### Software, Modules and PRACE Common Production Environment

All system-wide installed software on the cluster is made available to the users via the modules. For more information about the environment and modules usage, see the [Environment and Modules][12] section.

PRACE users can use the "prace" module for PRACE Common Production Environment.

```console
$ ml prace
```

### Resource Allocation and Job Execution

For general information about the resource allocation, job queuing, and job execution, see [Resources Allocation Policy][13].

For PRACE users, the default production run queue is "qprod", the same queue as for the national users of IT4I. Previously the "qprace" was the default queue for PRACE users, but since it gradually became identical with the "qprod" queue, it has been retired. For legacy reasons, the "qprace" queue is enabled on systems where it was the default one, but is not available on current and future systems. PRACE users can also use two other queues "qexp" and "qfree".

Salomon:

| queue                              | Active project | Project resources | Nodes                      | priority | authorization | walltime  |
| ---------------------------------- | -------------- | ----------------- | -------------------------- | -------- | ------------- | --------- |
| **qexp** Express queue             | no             | none required     | 32 nodes, max 8 per user   | 150      | no            | 1 / 1 h       |
| **qprod** Production queue         | yes            | >0                | 1006 nodes, max 86 per job | 0        | no            | 24 / 48 h      |
| **qfree** Free resource queue      | yes            | none required     | 752 nodes, max 86 per job  | -1024    | no            | 12 / 12 h      |
| **qprace** Legacy production queue | yes            | >0                | 1006 nodes, max 86 per job | 0        | no            | 24 / 48 h      |

### Accounting & Quota

The resources that are currently subject to accounting are the core hours. The core hours are accounted on the wall clock basis. The accounting runs whenever the computational cores are allocated or blocked via the PBS Pro workload manager (the qsub command), regardless of whether the cores are actually used for any calculation. See the [example in the general documentation][13].

PRACE users should check their project accounting using the PRACE Accounting Tool (DART).

Users who have undergone the full local registration procedure (including signing the IT4Innovations Acceptable Use Policy) and who have received a local password may check at any time, how many core-hours they and their projects have consumed using the command "it4ifree". Note that you need to know your user password to use the command and that the displayed core hours are "system core hours" which differ from PRACE "standardized core hours".

!!! note
    The **it4ifree** command is a part of it4i.portal.clients package, [located here][pypi].

```console
$ it4ifree

Projects I am participating in
==============================
PID         Days left      Total    Used WCHs    Used NCHs    WCHs by me    NCHs by me     Free
----------  -----------  -------  -----------  -----------  ------------  ------------  -------
OPEN-XX-XX  323                0      5169947      5169947         50001         50001  1292555


Projects I am Primarily Investigating
=====================================
PID        Login         Used WCHs    Used NCHs
---------- ----------  -----------  -----------
OPEN-XX-XX user1            376670       376670
           user2           4793277      4793277

Legend
======
WCH   =    Wall-clock Core Hour
NCH   =    Normalized Core Hour
```

By default, a file system quota is applied. To check the current status of the quota (separate for HOME and SCRATCH), use:

```console
$ quota
$ lfs quota -u USER_LOGIN /scratch
```

If the quota is insufficient, contact the [support][15] and request an increase.

[1]: general/obtaining-login-credentials/obtaining-login-credentials.md
[2]: salomon/introduction.md
[3]: barbora/introduction.md
[5]: #file-transfers
[6]: general/accessing-the-clusters/graphical-user-interface/x-window-system.md
[9]: general/shell-and-data-access.md
[10]: salomon/storage.md
[12]: environment-and-modules.md
[13]: general/resources-allocation-policy.md
[15]: #help-and-support

[a]: https://prace-ri.eu/training-support/
[b]: https://prace-ri.eu/about/faqs/
[pypi]: https://pypi.python.org/pypi/it4i.portal.clients
