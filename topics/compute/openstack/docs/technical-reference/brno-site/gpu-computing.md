---

title: GPU computing
search:
  exclude: false
---

# GPU Computing

On this page you can find static list of offered GPUs in Metacentrum Cloud.

| GPU								| Total nodes	| GPUs per node |
|-----------------------------------|---------------|---------------|
| NVIDIA Tesla T4					| 16			| 2				|
| NVIDIA A40 (**)					| 2				| 4				|
| NVIDIA TITAN V					| 1				| 1				|
| NVIDIA GeForce GTX 1080 Ti (*)	| 8				| 2				|
| NVIDIA GeForce GTX 2080 (*)		| 9				| 2				|
| NVIDIA GeForce GTX 2080 Ti (*)	| 14			| 2				|

Notes:

- (*) experimental use in academic environment.
- (**) There are currently operating system limitation of VM servers attaching GPU device. Supported are Debian 10 and Centos 7.

Current GPU usage can be viewed on [GPU overview dashboard](https://grafana1.cloud.muni.cz/d/J66duZjnk/openstack-gpu-resource-overview) (valid e-infra / MUNI identity needed).
