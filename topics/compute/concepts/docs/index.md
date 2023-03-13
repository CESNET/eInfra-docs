# The Hitchhiker’s Guide to the Computing at e-INFRA CZ

The Czech national e-infrastructure e-INFRA CZ offers several ways for the scientific community to process, analyze, and visualize data. A less technically savvy user may get lost in these concepts, so we introduce the following guide, which should bring you closer to the different computational platforms.

In general, several platforms and their benefits and negatives for common use cases will be discussed, specifically:   

* Grid environment[^1]   
* Cloud services
    * Infrastructure as a Service - OpenStack   
    * Native Container platform - Kubernetes   
    * Software as a Service - Web based applications/computing platforms such as Jupyter Notebooks
* Supercomputer

## What is Grid?
A computational grid service with PBS allows users to submit and manage computing jobs on a distributed infrastructure. Users can submit jobs through a command-line interface or web-based portal, specifying required resources (CPU, MEM, GPU). The scheduler then allocates resources and schedules the job on selected hardware node of whole distributed system. Users can monitor job status through PBS tools or a web portal, which may also provide additional features for managing data. Grid middleware simplifies job submission and management, improving productivity and reducing the need for users to manage their own computing resources.

### Usage
- Best for shell scripts, that are mostly non-interactive. 
- Interactive jobs are reccomended for testing the scripts/algorithms by trials on small datasets. 

### Access
- Required membership of the virtual organization **Meta** (application).
- SSH through Kerberos or SSH public-private key

[Accessing e-INFRA CZ Grid][grid-access]

### Required knowledge 
- Create and understand shell scripts and OS Linux essentials. 
- Be able to use SSH to connect to the grid system, and be able to compile software if needed.
- It is reccomended to understand basic principles of distributed computing and it's storage.
- Be able to work with the system as non-root user.

### Available software
- Software available through modules (module av, module list, module add)
- Licensed software such as Matlab or Ansys
- Modules can be conflicting, not all work together   

[Available software modules in e-INFRA CZ Grid][grid-software]

### Examples

[Examples of computing jobs in e-INFRA CZ Grid][grid-example]

## What is Cloud?
Cloud computing is a technology that enables users to access computing resources, such as servers, storage, and applications, over the internet. Cloud computing providers typically offer on-demand, pay-per-use access to a range of computing resources, allowing users to scale up or down their resource usage as needed.

There are generally three types of cloud computing:

## Infrastructure as a Service (IaaS) - OpenStack
IaaS provides users with access to virtualized computing resources, such as servers, storage, and networking, over the internet. Users typically manage and control their own operating systems, applications, and data, while the cloud provider manages the underlying infrastructure. 

### Usage
Generaly used to run services or conduct computing intensive jobs on reserved resources - complex computing environments (see examples). Also great for testing, debugging and playing with infrastructure.

- Virtualisation of otherwise physical layer — virtual machines, virtual routers and networking, virtualized storage.
- Virtual Machines as primary computing mechanism based on Linux OS or Windows.
- User fully responsible for management of:
    - Operating system, it's security and updates
    - Installation and maintanance of desired services (Apache web server, databases, ...)
    - Infrastructure integration such as attaching and formating storage
- Self service infrastructure, ability to request VM, own router, storage on the fly
- Objects are software defined - VMs, networking, storage, ...

### Access
e-INFRA CZ with membership in virtual organization **Meta** have available "Trial" access which is limited in quota (few CPUs and Memory), ideal for testing the platform. For guaranteed resources it is needed to send a request - specify the amount of resources, principal investigator, and describe the desired use-case.   

[Accessing e-INFRA CZ OpenStack][cl-os-access]

### Required knowledge 
- Required average administration of Linux or Windows (working with storage, services, updates)
- Basics of networking, firewalls
- Basics of Infrastructure to connect to

### Available software
In the context of IaaS, the user has avaiable several operating systems to choose, that are tailored for the e-INFRA CZ OpenStack cloud. 

[Available OS images in e-INFRA CZ OpenStack][cl-os-software]

### Examples

[Examples of computing jobs in e-INFRA CZ OpenStack][cl-os-example] 

## Platform as a Service (PaaS) - Kubernetes
PaaS provides users with a platform for developing, deploying, and managing their applications over the internet. PaaS typically includes a pre-configured operating system, web server, database, and other middleware components, allowing users to focus on application development without worrying about the underlying infrastructure.   
### Usage
### Access
[Accessing e-INFRA CZ OpenStack][cl-k8s-access]
### Required knowledge 
### Available software

[Available software modules in e-INFRA CZ OpenStack][cl-k8s-software]

### Examples

[Examples of computing jobs in e-INFRA CZ OpenStack][cl-k8s-example] 

## Software as a Service (SaaS) 
SaaS provides users with access to software applications over the internet. The applications are typically hosted by the cloud provider and accessed through a web browser or a mobile app. Users do not manage the underlying infrastructure or the application itself, but rather use the application as a service provided by the cloud provider.   
### Usage
### Access
[Accessing e-INFRA CZ OpenStack][cl-ss-access]
### Required knowledge 
### Available software

[Available computing web portals at e-INFRA CZ][cl-ss-software]
[Other managed software services e-INFRA CZ][cl-ss-software]

These three types of cloud computing are often referred to as the "cloud stack," with IaaS forming the base layer, PaaS sitting on top of IaaS, and SaaS sitting on top of both IaaS and PaaS. 

## What is Supercomputer?
A supercomputer is a high-performance computing system that uses thousands or millions of processing cores to process large amounts of data and perform complex calculations quickly. It is housed in a single location rather than distributed grid. 

They are used in scientific, engineering, and industrial fields to perform simulations and optimize designs. Supercomputers offer high-performance computing power, large-scale parallelism, specialized hardware and software, and lower latency and greater bandwidth than traditional grids. 

Access to supercomputers is restricted and controlled, and users typically interact with them in a similiar way as with grids - through a command-line interface or a web-based portal. Supercomputers provide essential computing power for many applications that require a high level of efficiency and speed.

### Usage
- Best for shell scripts, that are mostly non-interactive. 
- Interactive jobs are reccomended for testing the scripts/algorithms by trials on small datasets. 

### Access
- Required membership of the virtual organization **Meta** (application).
- SSH through Kerberos or SSH public-private key

[Accessing e-INFRA CZ Supercomputer][superpc-access]

### Required knowledge 
- Create and understand shell scripts and OS Linux essentials. 
- Be able to use SSH to connect to the grid system, and be able to compile software if needed.
- It is reccomended to understand basic principles of distributed computing and it's storage.
- Be able to work with the system as non-root user.

### Available software
- Software available through modules (module av, module list, module add)
- Licensed software - Matlab, Ansys
- Modules can be conflicting, not all work together   

[Available software modules in e-INFRA CZ Supercomputer][superpc-software]

### Examples

[Examples of computing jobs in e-INFRA CZ Supercomputer][superpc-example]


## What are main differences between these services?

## How to Choose Between Computing Services?

- Read computing service overview
- Check comparision between computing services _(TODO)_

## Combining computing platforms to meet advanced requirements
When chosing just one service is just not enough.

<!-- <div class="grid cards" markdown>

-   :fontawesome-solid-server:{ .md .middle } __Cloud services__

    ---

    It is possible to choose level of service from virtualization to managed container engine.

    [:octicons-arrow-right-24: Virtualization (OpenStack Cloud)](./openstack/)   
    [:octicons-arrow-right-24: Container Engine (Kubernetes)](./kubernetes/)   
    [:octicons-arrow-right-24: Sensitive Proccessing](./sensitive/)   
    [:octicons-arrow-right-24: More](./concepts/)

-   :fontawesome-solid-microchip:{ .md .middle } __Metacentrum Grid services__

    ---

    Traditional distributed computing with software and queues.

    [:octicons-arrow-right-24: How to start](./grid/)   
    [:octicons-arrow-right-24: Running first job](./grid/)   
    [:octicons-arrow-right-24: More](./grid/)   

-   :fontawesome-solid-atom:{ .md .middle } __Supercomputing__

    ---

    Supercomputing centre services.

    [:octicons-arrow-right-24: Overview](./supercomputing/)   
    [:octicons-arrow-right-24: Get Project](./supercomputing/general/applying-for-resources/)   
    [:octicons-arrow-right-24: LUMI](https://docs.lumi-supercomputer.eu/)   


</div> -->

[grid-access]: #
[grid-software]: #
[grid-example]: #
[cl-os-access]: #
[cl-os-software]: #
[cl-os-example]: #
[cl-k8s-access]: #
[cl-k8s-software]: #
[cl-k8s-example]: #
[cl-ss-access]: #
[cl-ss-software]: #
[cl-ss-example]: #
[superpc-access]: #
[superpc-software]: #
[superpc-example]: #
[^1]: Also known as Metacentrum, Metacentrum Grid or NGI CZ. 