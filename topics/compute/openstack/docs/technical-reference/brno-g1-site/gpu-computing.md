---

title: GPU Computing
search:
  exclude: false
---

# GPU Computing

On this page, you can find a static list of GPUs offered in Metacentrum Cloud.

| GPU								| Total nodes	| GPUs per node |
|-----------------------------------|---------------|---------------|
| NVIDIA Tesla T4					| 16			| 2				|
| NVIDIA A40 (**)					| 2				| 4				|
| NVIDIA GeForce GTX 2080 (*)		| 9				| 2				|
| NVIDIA GeForce GTX 2080 Ti (*)	| 14			| 2				|

Notes:

- (*) experimental use in academic environment.
- (**) There are currently operating system limitations of VM servers attaching GPU device. Supported are Debian 10 and Centos 7.

Current GPU usage can be viewed on [GPU overview dashboard](https://grafana1.cloud.muni.cz/d/J66duZjnk/openstack-gpu-resource-overview) (valid e-infra/MUNI identity needed).
