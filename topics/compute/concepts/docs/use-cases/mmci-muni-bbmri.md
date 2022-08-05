---
layout: article
title: Biological tissue digitization
aside:
  toc: true
sidebar:
  nav: docs
authors:
  - rosinec
  - freznicek
---

## Goals

Pathologists at The Masaryk Memorial Cancer Institute (MMCI) need biological tissue scans (WSI) in digital form so that they can easily process (look, share, analyse) them.

## Terminology

Tissue fixed in formaline blocks is cut into very thin layers that are placed on a glass slide and examined under a microscope by pathologists. This allows confirmation of a diagnosis of the diseased tissue. 
When are such glass slides scanned into a digital format they are called Whole Slide Images (WSI).

## Architecture

The Whole Slide Images are manually scanned to a local MMCI computer (in Mirax format) and then transferred to raw data storage at MU ICS. The transfer is done over secured connection between the SensitiveCloud environment and MMCI network which are both considered to be safe environments for sensitive data.

Once the huge images in Mirax format enter the raw data storage, they are transformed into open TIFF format, compressed and saved into dedicated location to be ready for further usage. By lowering the size during data transformation is some inforamtion lost but without it it would be nearly impossible to visualize such images by so-called online microscope tooling (OpenSeadragon in our case). The WSI quality is after size reduction still very high and pathologists use it for diagnostic purposes. 

There is an directory structure optimized within the data storage enabling imediate usage of the TIFF files by the pathologist via Hospital Information System (HIS).


## Target cloud mapping

TODO

## Implementation

Conversion from Mirax proprietary format to TIFF open format is done by using open-source convertor [Vips](https://libvips.github.io/pyvips/intro.html).
Virtual server visualizing the TIFF images uses open-source [OpenSeadragon project](https://openseadragon.github.io/).


## References
* https://www.bbmri.cz/
* https://www.mou.cz/en/about-the-mmci/t1632
* https://libvips.github.io/pyvips/intro.html
* https://openseadragon.github.io
