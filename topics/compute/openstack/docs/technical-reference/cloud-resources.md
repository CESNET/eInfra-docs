---

title: Cloud Resources
search:
  exclude: false
---

# Cloud Resources

## Classification of Application

Your application may be:

 * `A.` single instance application, running on one of cloud computation resources
 * `B.` multi-instance application with messaging support (MPI), where all instances run on the same cloud computation resource
 * `C.` true distributed computing, where the application runs in jobs scheduled to multiple cloud computation resources

Applications running in a single cloud resource (`A.` and `B.`) are a direct match for MetaCentrum Cloud OpenStack. Distributed applications (`C.`) are best handled by [MetaCentrum PBS system](https://metavo.metacentrum.cz/cs/state/personal).

## Maintaining Cloud Resources

Your project is computed within the MetaCentrum Cloud Openstack project where you can claim MetaCentrum Cloud Openstack resources (for example virtual machine, floating IP, ...). There are multiple ways how to set up the MetaCentrum Cloud Openstack resources:

 * manually using [MetaCentrum Cloud Openstack Dashboard UI](https://dashboard.cloud.muni.cz) (Openstack Horizon)
 * automated approaches
   * [Terraform](https://registry.terraform.io/providers/terraform-provider-OpenStack/OpenStack/latest/docs) ([example 1](https://github.com/terraform-provider-OpenStack/terraform-provider-OpenStack/tree/main/examples/app-with-networking), [example 2](https://gitlab.ics.muni.cz/cloud/terrafrom-demo))
   * Ansible
   * [openstack heat](https://docs.openstack.org/heat/train/template_guide/hello_world.html)

If your project infrastructure (MetaCentrum Cloud Openstack resources) within the cloud is static you may select a manual approach with [MetaCentrum Cloud Openstack Dashboard UI](https://dashboard.cloud.muni.cz). There are projects which need to allocate MetaCentrum Cloud Openstack resources dynamically. In such cases, we strongly encourage automation even at this stage.

## Transferring Data to Cloud

There are several options how to transfer the project to cloud resources:

 * manually with `scp`
 * automatically with `ansible` ([example](https://gitlab.ics.muni.cz/cloud/cloud-estimate-pi/-/blob/de673766b832c48142c6ad1be73f5bce046b02a2/ansible/roles/cloud-project-native/tasks/init.yml#L29-47))
 * automatically with `terraform`
 * indirectly in a project container (example: [releasing a project container image](https://gitlab.ics.muni.cz/cloud/cloud-estimate-pi/-/blob/de673766b832c48142c6ad1be73f5bce046b02a2/.gitlab-ci.yml#L17-80), [pulling and running a project image](https://gitlab.ics.muni.cz/cloud/cloud-estimate-pi/-/blob/de673766b832c48142c6ad1be73f5bce046b02a2/ansible/roles/cloud-project-container/tasks/deploy.yml#L16-28))
 * indirectly in OpenStack (glance) image (you need to obtain image-uploader role)
   * OpenStack Glance images may be public, private, community or shared.

### SSH to Cloud VM Resources and Manual Update

In this scenario, you log into your cloud VM and perform all required actions manually. This approach does not scale well –⁠ it is not effective enough as different users may configure cloud VM resources in different ways sometimes resulting in different resource behavior.

### Automated Work Transfer and Synchronization With Docker (Or Podman)

There are automation tools that may help you to ease your cloud usage:

* Ansible and/or Terraform
* container runtime engine (Docker, Podman, ...)

Ansible is a cloud automation tool that helps you with:

* keeping your VM updated
* automatically migrating your applications or data to/from cloud VM

Container runtime engine helps you to put yours into a container stored in a container registry.
Putting your work into a container has several advantages:

* share the code including binaries in a consistent environment (even across different Operating Systems)
* avoids application (re)compilation in the cloud
* your application running in the container is isolated from the host's container runtime so
  * you may run multiple instances easily
  * you may easily compare different versions at once without collisions
* you become ready for future Kubernetes cloud

As a container registry we suggest either:

* public quay.io ([you need to register for free first](https://quay.io/signin/))
* private Masaryk University [registry.gitlab.ics.muni.cz:443](registry.gitlab.ics.muni.cz:443)

An example of such an approach is demonstrated in [`cloud-estimate-pi` project](https://gitlab.ics.muni.cz/cloud/cloud-estimate-pi).

## Receiving Data From Experiments to Your Workstation

It certainly depends on how your data are stored, the options are:

* files transfer
  * manual file transfer with `scp` (and possibly `sshuttle`)
  * automated file transfer with `scp` + `ansible` (and possibly `sshuttle`), demonstrated in [`cloud-estimate-pi` project](https://gitlab.ics.muni.cz/cloud/cloud-estimate-pi/-/blob/master/ansible/roles/cloud-project-container/tasks/download.yml)
* database data/objects transfer
  * data stored in the S3 compatible database may be easily received via [minio client application MC](https://docs.min.io/docs/minio-client-complete-guide)
  * date stored in [OpenStack Swift Python client `swift`](https://docs.openstack.org/python-swiftclient/train/swiftclient.html)

## Highly Available Cloud Application

Let's assume your application is running in multiple instances in the cloud already.
To make your application highly available (HA) you need to

* run the application instances on different cloud resources
* use MetaCentrum Cloud load-balancer component (based on [OpenStack Octavia](https://docs.openstack.org/octavia/train/reference/introduction.html#octavia-terminology)) which is going to balance traffic to one of the app's instances.

Your application surely needs a Fully Qualified Domain Name (FQDN) address to become popular. Setting FQDN is done on the public floating IP linked to the load-balancer.

## Cloud Project Example and Workflow Recommendations

This chapter summarizes effective cloud workflows on the (example) [`cloud-estimate-pi` project](https://gitlab.ics.muni.cz/cloud/cloud-estimate-pi).

The project recommendations are:

1. Project files should be versioned in [a VCS](https://en.wikipedia.org/wiki/Version_control) (Git)
1. The project repository should
   * contain the documentation
   * follow standard directory structure `src/`, `conf/`, `kubernetes/`
   * include CI/CD process pipeline ([`.gitlab-ci.yml`](https://gitlab.ics.muni.cz/cloud/cloud-estimate-pi/-/blob/master/.gitlab-ci.yml), ...)
   * contain deployment manifests or scripts (kubernetes manifests or declarative deployment files (Ansible, Terraform, Puppet, ...))
1. The project release should be automated and triggered by pushing a [semver v2 compatible](https://semver.org/) [tag](https://dev.to/neshaz/a-tutorial-for-tagging-releases-in-git-147e)
1. The project should support execution in a container as there are significant benefits: ([`Dockerfile`](https://gitlab.ics.muni.cz/cloud/cloud-estimate-pi/-/blob/master/Dockerfile))
   * consistent environment (surrounding the application)
   * application portability across all Operating Systems
   * application isolation from host Operating System
   * multiple ways how to execute the application (container cloud support advanced container life-cycle management)
1. The project should have a changelog (either manually written or generated) (for instance [`CHANGELOG.md`](https://gitlab.ics.muni.cz/cloud/cloud-estimate-pi/-/blob/master/CHANGELOG.md))

We recommend every project defines cloud usage workflow which may consist of:

1. Cloud resource initialization, performing
   * cloud resource update to the latest state
   * install necessary tools for project compilation and execution
   * test container infrastructure (if it is used)
   * transfer project files if need to be compiled
1. Project deployment (and execution) in the cloud, consisting of
   * compilation of the project in the cloud (if native execution selected)
   * execution of the project application[s] in the cloud
   * storing or collecting project data and logs
1. Download project data from cloud to workstation (for further analysis or troubleshooting)
   * download of project data from cloud to user's workstation
1. Cloud resource destroy

## Road-Map to Effective Cloud Usage

Project automation is usually done in CI/CD pipelines. Read [Gitlab CI/CD article](https://docs.gitlab.com/ee/ci/introduction/) for more details.
![](https://docs.gitlab.com/ee/ci/introduction/img/gitlab_workflow_example_extended_v12_3.png)

The following table shows the different cloud usage phases:

| Cloud usage phase | Cloud resource management | Project packaging | Project deployment | Project execution | Project data synchronization | Project troubleshooting |
| :---              | :---:                     | :-----------:     | :------:           | :------------:    | :------------:               | :------------:          |
| ineffective manual approach | manual (`ssh`)      | manually built binaries (versioned?) | manual deployment (scp) | manual execution (ssh) | manual transfers (scp) | manual investigation on VM (scp) |
| ...               | ...                       | ...               | ...                | ...               | ...                          | ...                     |
| [continuous delivery](https://docs.gitlab.com/ee/ci/introduction/#continuous-delivery) (automated, but deploy manual) | semi-automated (GUI + `ansible` executed manually) | container ([semver](https://semver.org) versioned) | semi-automated (`ansible` executed manually) | semi-automated (`ansible` executed manually) | semi-automated (`ansible` executed manually) | semi-automated (`ansible` and `ssh` manually)  |
| [continuous deployment](https://docs.gitlab.com/ee/ci/introduction/#continuous-deployment) (fully-automated) | automated (`terraform` and/or `ansible` in CI/CD) | container ([semver](https://semver.org) versioned) | automated (`ansible` in CI/CD) | automated (`ansible` in CI/CD) | automated (`ansible` in CI/CD) | semi-automated (`ansible` in CI/CD and `ssh` manually)  |

## How to Convert Legacy Application Into Container for Cloud?

Containerization of applications is one of the best practices when you want to share your application and execute it in the cloud. Read about [the benefits](https://cloud.google.com/containers).

The application containerization process consists of the following steps:

* Select a container registry (where container images with your applications are stored)
  * Publicly available registries like [quay.io](https://quay.io) are best as everyone may receive your application even without credentials
* Your project applications should be containerized via creating a `Dockerfile` ([example](https://gitlab.ics.muni.cz/cloud/cloud-estimate-pi/-/blob/master/Dockerfile))
  * Follow [docker guide](https://www.freecodecamp.org/news/a-beginners-guide-to-docker-how-to-create-your-first-docker-application-cc03de9b639f/) if you are not familiar with `Dockerfile` syntax
  * If your project is huge and contains multiple applications, then it is recommended to divide them into few parts by topic each part building a separate container.
* Project CI/CD jobs should build applications, create container image[s] and finally release (push) container image[s] with applications to the container registry
* Everyone is then able to use your applications (packaged in a container image) regardless of which Operating System (OS) he or she uses. Container engine (docker, podman, ...) is available for all mainstream OSes.
  * Cloud resources are then told to pull and run your container image[s]. ([example](https://gitlab.ics.muni.cz/cloud/cloud-estimate-pi/-/blob/de673766b832c48142c6ad1be73f5bce046b02a2/ansible/roles/cloud-project-container/tasks/deploy.yml#L11-28))

Learn best-practices on our cloud example [project `cloud-estimate-pi`](https://gitlab.ics.muni.cz/cloud/cloud-estimate-pi).
