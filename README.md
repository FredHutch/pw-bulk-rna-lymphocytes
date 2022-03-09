# Bulk RNAseq Lymphocyte Analysis (PubWeb)
Quantification of lymphocyte cell types from bulk RNA sequencing data

## Purpose

The purpose of this repository is to estimate the proportional abundance
of lymphocyte cell types from bulk RNA sequencing data.

## Approach

While there are a number of different published tools for the estimation
of cell type proportion from RNAseq data (most notably CIBERSORT), few of
these tools are available for standalone execution. This workflow uses a
recently published tool (quanTIseq) which has been made available by the
authors as a Docker image, which is suitable for use in Nextflow.

The quanTIseq method was published in:
[Finotello, F., Mayer, C., Plattner, C. et al. Molecular and pharmacological modulators of the tumor immune contexture revealed by deconvolution of RNA-seq data. Genome Med 11, 34 (2019). https://doi.org/10.1186/s13073-019-0638-6](https://genomemedicine.biomedcentral.com/articles/10.1186/s13073-019-0638-6)

The source code is available at [https://github.com/icbi-lab/quanTIseq](https://github.com/icbi-lab/quanTIseq),
with documentation at [https://icbi.i-med.ac.at/software/quantiseq/doc/](https://icbi.i-med.ac.at/software/quantiseq/doc/).

While the authors have published a Docker image at `icbi/quantiseq2`, we
have reproduced that image at `quay.io/hdc-workflows/quantiseq` using the
repository [https://github.com/FredHutch/docker-quantiseq](https://github.com/FredHutch/docker-quantiseq)
in order to tag each image with a traceable commit hash linked to the
version of the source code which was installed.

## Input Data

While the quanTIseq tool can be used to analyze RNAseq data from raw
FASTQ files, we have chosen to implement this workflow using the input
data represented by a tabular gene expression matrix. In particular,
this workflow was developed with the goal of providing downstream
analysis from the [nf-core/rnaseq](https://github.com/nf-core/rnaseq)
workflow.

The only restrictions for the input data is that the first column
must contain gene IDs and the first row contains specimen names.
While the quanTIseq tool uses TSV formatted tables, this workflow
will instead require the input of CSV formatted tables in order to
conform to the output of the `nf-core/rnaseq` pipeline.
