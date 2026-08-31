# Obtaining-an-Annotated-VCF-File-from-Raw-Data

## Project Overview
This repository contains an end-to-end bioinformatics pipeline designed to process raw Next-Generation Sequencing (NGS) data from a targeted cancer panel. The workflow covers the entire process from read alignment and variant calling in a Linux environment to downstream data tidying, clinical annotation filtering, and data visualization using R.

## Dataset Disclaimer
The dataset utilized in this project is derived from a real-world oncogenic targeted panel. **All data has been fully anonymized and stripped of any Protected Health Information (PHI) or patient-identifiable data prior to analysis.** The dataset is used strictly for educational purposes, pipeline validation, and bioinformatics portfolio demonstration. 

## Pipeline Workflow

The project is divided into two main stages:

### 1. Upstream Analysis (Linux / Bash)
The `pipeline.sh` script automates the processing of raw FASTQ files.
* **Alignment:** BWA-MEM is used to map reads to the human reference genome (GRCh38.105).
* **Processing:** Samtools is utilized for converting SAM to BAM, sorting, and indexing.
* **Variant Calling:** Bcftools is used to identify genomic variants and generate a VCF file.
* **Annotation:** SnpEff is integrated to annotate the variants with their biological impacts (e.g., missense, frameshift, stop-gained).

### 2. Downstream Analysis and Visualization (R / Quarto)
The `Obtaining an annotated VCF file from raw data.qmd` file processes the annotated VCF to generate a clinical laboratory-style report.
* **Data Wrangling:** Uses `vcfR`, `dplyr`, and `tidyr` to parse complex SnpEff annotations.
* **Clinical Filtering:** Isolates HIGH and MODERATE impact variants and formats them for immediate querying in clinical databases such as Franklin (Genoox) and VarSome.
* **Visualization:** Utilizes `ggplot2` to generate publication-quality figures representing mutation type distributions and highly mutated oncogenes.
* **Reporting:** Rendered via Quarto to produce an interactive HTML document using the `DT` package for searchable data tables.

## Requirements

**Linux Environment:**
* BWA
* Samtools
* Bcftools
* Java (JRE) & SnpEff

**R Environment:**
* vcfR
* dplyr
* tidyr
* ggplot2
* stringr
* knitr
* DT
This two grapth we made.

<img width="1915" height="981" alt="image" src="https://github.com/user-attachments/assets/806f6c09-1b77-4fe7-8575-07ae46481a0c" />

<img width="1914" height="987" alt="image" src="https://github.com/user-attachments/assets/8a84d079-d6fb-40d2-93d7-3db1b78db661" />


