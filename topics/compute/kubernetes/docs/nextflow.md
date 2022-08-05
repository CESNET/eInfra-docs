---
layout: article
title: Running Nextflow Pipelines in Kubernetes
permalink: /docs/nextflow.html
key: nextflow
aside:
  toc: true
sidebar:
  nav: docs
---

The following text describes how to run [Nextflow](https://nextflow.io) pipelines in CERIT-SC Kubernetes cluster.

You need to install Nextflow on your local computer or any computer that you will start the Nextflow, the pipeline will not run on that computer it will run in Kubernetes cluster and the computer serves only for starting it. The computer does not need to be online while the pipeline is still running.

## Nextflow Installation

To install Nextflow enter this command in your terminal:
```
curl -s https://get.nextflow.io | bash
```
You can install specific Nextflow version exporting `NXF_VER` environment
variable before running the install command, e.g.:
```
export NXF_VER=20.10.0
curl -s https://get.nextflow.io | bash
```

## Architecture of Nextflow 

The Nextflow pipeline gets started by running the `nextflow` command, e.g.:

```
nextflow run hello
```

which starts `hello` pipeline. The pipeline run consists of two parts:
*workflow controller* and *workers*. The *workflow controller* manages
pipeline run while *workers* run particular tasks. 

Nextflow engine expects that the *workflow controller* and the *workers* have
access to some shared storage. On a local computer, this is usually just a
particular directory, in case of distributed computing, this has to be a
network storage such as NFS mount. User needs to specify what storage can be
used when running the Nextflow.

## Runing Nextflow in Kubernetes

In case of K8s, *workflow controller* is run as a
[Pod](https://kubernetes.io/docs/concepts/workloads/pods/) in Kubernetes
cluster. Its task is to run *worker* pods according to pipeline definition.
The *workflow controller* pod has some generated name like `naughty-williams`.
The *workers* have hashed names like `nf-81dae79db8e5e2c7a7c3ad5f6c7d59c6`.

### Requirements

* Installed [`kubectl`](https://cerit-sc.github.io/kube-docs/docs/kubectl.html) with configuration file.
* Kubernetes [Namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) to run in (see [here](ns.html) how to know your namespace).
* Created [PVC](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) (see [here](pvc.html) how to do it).

### Running Nextflow

Running the Nextflow in Kubernetes requires local configuration. You can
download
[nextflow.config](deployments/nextflow.config)
which can be used as is in the case, you change `namespace` to correct value
and specify `launchDir` and `workDir` to point somewhere on the PVC. Take
care, if running Nextflow in parallel, always use different `launchDir` and
`workDir` for the parallel runs.

You need to keep the file in the current directory where the `nextflow`
command is run and it has to be named `nextflow.config`.

To instruct the Nextflow to run the `hello` pipeline in Kubernetes, you can run the
following command:
```
nextflow kuberun hello -pod-image 'cerit.io/nextflow:21.09.1' -v PVC:/mnt 
```
where PVC is name of the PVC as discussed above. It will be mounted as /mnt.
You should use this mount point as some pipelines expect this location.

If everything was correct then you should see output like this:
```
Pod started: naughty-williams
N E X T F L O W  ~  version 21.09.0-SNAPSHOT
Launching `nextflow-io/hello` [naughty-williams] - revision: e6d9427e5b [master]
[f0/ce818c] Submitted process > sayHello (2)
[8a/8b278f] Submitted process > sayHello (1)
[5f/a4395f] Submitted process > sayHello (3)
[97/71a2e0] Submitted process > sayHello (4)
Ciao world!
Hola world!
Bonjour world!
Hello world!
```

### Caveats

* If pipeline runs for a long time (not the case of the `hello` pipeline), the `nextflow` command ends with connection terminated. This is normal and it does not mean that pipeline is not running anymore. It stops logging to your terminal only. You can still find logs of the workflow controller in Rancher GUI.

* Running pipeline can be terminated from Rancher GUI, hitting `ctrl-c` does not terminate the pipeline.

* Pipeline debug log can be found on the PVC in `launchDir/.nextflow.log`. Consecutive runs rotate the logs, so that they are not overwritten.

* If pipeline fails, you can try to resume the pipeline with `-resume` command line option, it creates a new run but it tries to skip already finished tasks. See [details](https://www.nextflow.io/blog/2019/demystifying-nextflow-resume.html).

* All runs (success or failed) will keep *workflow controller* pod visible in Rancher GUI, failed workers are also kept in Rancher GUI. You can delete them from GUI as needed.

* For wome *workers*, log are not available in Rancher GUI, but the logs can be watched using the command:
    ```
kubectl logs POD -n NAMESPACE 
    ```
    where `POD` is the name of the *worker* (e.g., `nf-81dae79db8e5e2c7a7c3ad5f6c7d59c6`) and `NAMESPACE` is used namespace.

## nf-core/sarek pipeline

[nf-core/sarek](https://nf-co.re/sarek) is analysis pipeline to detect germline
or somatic variants (pre-processing, variant calling and annotation) from WGS /
targeted sequencing.

### Kubernetes Run

The Sarek requires specific
[nextflow.config](deployments/nextflow-sarek.config),
it sets more memory for a VEP process which is a part of the pipeline. With
basic settings, VEP process will be killed most probably due to memory.
It also requires specific
[custom.config](deployments/custom.config)
as the git version of the Sarek contains bug so that output stats will be
written to wrong files.

The Sarek pipeline uses functions in the pipeline configuration. However,
functions in the pipeline configuration are not currently supported by
`kuberun` executor. 

To deal with this bug, you need Nextflow version 20.10.0,
this is the only supported version.

Download
[nextflow-cfg.sh](deployments/nextflow-cfg.sh)
and
[nextflow.config.add](deployments/nextflow.config.add)
and put both on the PVC (into its root). Do not rename the files and make
`nextflow-cfg.sh` executable (`chmod a+x nextflow-cfg.sh`).

On your local machine (or machine where you run Nextflow) run the following
command (run this command **after and only if** you already installed Nextflow
version 20.10.0):
```
cd /tmp; wget http://repo.cerit-sc.cz/misc/nextflow-20.10.0.jar -q && mv nextflow-20.10.0.jar ~/.nextflow/capsule/deps/io/nextflow/nextflow/20.10.0/
```

This command will install patched version of Nextflow to mitigate the
mentioned bug.

Now, if you have prepared your data on the PVC, you can start the Sarek
pipeline with the following command:
```
nextflow kuberun nf-core/sarek -v PVC:/mnt --input /mnt/test.tsv --genome GRCh38 --tools HaplotypeCaller,VEP,Manta
```

where `PVC` is the mentioned PVC and `test.tsv` contains input data located on
the PVC. 

### Caveats

* It is recommended to download *igenome* from S3 Amazon location to local PVC. It rapidly speeds up `-resume` option in the case the pipeline run fails and you run it again to continue. It also mitigates Amazon overloading or network issues leading to pipeline fail. Once you download the *igenome*, just add something like `--igenomes_base /mnt/igenome` to the command line options of `nextflow`.

* If you receive error about unknown `check_resource`, then you failed with the `nextflow-cfg.sh` and `nextflow.config.add` setup.

* The pipeline run ends with stacktrace and `No signature of method: java.lang.String.toBytes()` error. This is normal and it is result of not specifying email address to send final email. Nothing to be worried about.

* The pipeline run does not clean workDir, it is up to user to clean/remove it.

* Manual resuming of Sarek is possible using different `--input` spec. See [here](https://nf-co.re/sarek/2.7.1/usage#troubleshooting).


## vib-singlecell-nf/vsn-pipelines pipeline

[vsn-pipelines](https://vsn-pipelines.readthedocs.io/en/latest/) contain multiple workflows for analyzing single cell transcriptomics data, and depends on a number of tools.

### Kubernetes Run

You need to download pipeline specific [nextflow.config](deployments/nextflow-vsn.config) and put it into the current directory where you start Nextflow from. This pipeline uses `-entry` parameter to specify entry point of workflow. Unless this [issue #2397](https://github.com/nextflow-io/nextflow/issues/2397) is resolved, patched version of Nextflow is needed. To deal with this bug, you need Nextflow version 20.10.0, this is the only supported version.

On your local machine (or machine where you run Nextflow) run the following
command (run this command **after and only if** you already installed Nextflow
version 20.10.0):
```
cd /tmp; wget http://repo.cerit-sc.cz/misc/nextflow-20.10.0.jar -q && mv nextflow-20.10.0.jar ~/.nextflow/capsule/deps/io/nextflow/nextflow/20.10.0/
```

This command will install patched version of Nextflow to mitigate the
mentioned bug.

On the PVC you need to prepare data into directories specified in the `nextflow.config` see all occurrences of `/mnt/data1` in the config and change them accordingly.

Consult [documentation](https://vsn-pipelines.readthedocs.io/en/latest/index.html) for further config options. 

You can run the pipeline with the following command:
```
nextflow -C nextflow.config kuberun vib-singlecell-nf/vsn-pipelines -v PVC:/mnt -entry scenic
```

where `PVC` is the mentioned PVC, `scenic` is pipeline entry point, and `nextflow.config` is the downloaded `nextflow.config`.

### Caveats

* For parallel run, you need to set `maxForks` in the `nextflow.config` together with `params.sc.scenic.numRuns` parameter. Consult [documentation](https://vsn-pipelines-examples.readthedocs.io/en/latest/PBMC10k_multiruns.html).

* `NUMBA_CACHE_DIR` variable pointing to `/tmp` or other writable directory is requirement otherwise execution fails on permission denied. It tries to update readonly parts of running container.
