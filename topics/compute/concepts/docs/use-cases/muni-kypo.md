---
layout: article
title: Cybersecurity platform
aside:
  toc: true
sidebar:
  nav: docs
---

## Goals

1. To research methods and develop software for enhancing cybersecurity knowledge and skills.
1. To provide tools for economically-and-time efficient simulation of real Critical Information Infrastructures (CIIs), detecting of cyber-threats, and then mitigation.
1. Support for research and development of new methods to protect critical infrastructure against attacks.

## Architecture

The architecture consists of several components briefly described [here](https://docs.crp.kypo.muni.cz/basic-concepts/conceptual-architecture/).

## Target Cloud Mapping

As the architecture requires dynamic creation of following resources

- virtual-machines
- networks
- firewall rules (security groups)
- ...others

then the MetaCentrum OpenStack cloud is the optimal choice as provides multiple ways how to automate creation of needed infrastructure on demand.

## Implementation

KYPO Cyber Range Platform (KYPO CRP) is developed by Masaryk University since 2013, and it represents several years of our experience with cyber ranges in education, cyber defense exercises, and trainings. KYPO CRP is entirely based on state-of-the-art approaches such as containers, infrastructures as code, microservices, and open-source software, including cloud provider technology - OpenStack. With practical applications in mind, the team emphasized repeatability, scalability, automation, and interoperability to minimize human tasks and make cyber trainings affordable and cost-efficient.

KYPO CRP uses the same open approach for the content as for its architecture to encourage creating a community of trainers and supporting the sharing of training building blocks. For that reason, virtual machines, networks, and trainings are entirely defined in human-readable data-serialization languages JSON and YAML or use open-source software Packer to build virtual machines and Ansible for describing machine content.

The KYPO CRP sources are currently hosted at [https://gitlab.ics.muni.cz/muni-kypo-crp](https://gitlab.ics.muni.cz/muni-kypo-crp).

## References

* [https://crp.kypo.muni.cz/](https://crp.kypo.muni.cz/)
* [https://docs.crp.kypo.muni.cz/](https://docs.crp.kypo.muni.cz/)
* [https://www.muni.cz/en/research/projects/48647](https://www.muni.cz/en/research/projects/48647)
* [https://www.muni.cz/en/research/projects/31984](https://www.muni.cz/en/research/projects/31984)
* [https://www.muni.cz/en/research/projects/23884](https://www.muni.cz/en/research/projects/23884)
* [https://www.muni.cz/en/research/projects/43025](https://www.muni.cz/en/research/projects/43025)
