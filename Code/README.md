# RNA-seq and Demographic Data Analysis

This repository contains all the files and scripts required for statistical and differential expression analysis of RNA-seq data, as well as the collection of demographic data from the samples used in the project.

## Repository Content

### Main Files:
1. [Demographic.R](./Demographic.R): Script in R for processing and analyzing the demographic data of the samples. This code uses the [demographic data table](./Demographic_data(metadata).xlsx) as a starting point.

2. [Demographic_data(metadata).xlsx](./Demographic_data(metadata).xlsx): Excel database containing demographic information of the samples. It includes the following fields:

   + **Sample**: Unique identifier of the sample used.
   + **Condition**: Clinical status of the patient (A: AD; B: AD with IA; C: control).
   + **Pathology**: Type of pathology (AD or Control).
   + **Gender**: Gender of the patient (male: M, female: F).
   + **Onset_age**: Age at disease onset.
   + **Death_age**: Age of the patient at the time of death.
   + **Braak_stage**: Classification of the pathology stage according to Braak criteria.
   + **APOE**: Genotype of the APOE allele associated with the patient (relevant in neurodegenerative diseases).
   + **Disease_duration**: Duration of the disease (in years) from onset to death.
   + **HTT_short_allele**: Number of CAG repeats in the short allele of the _HTT_ gene.
   + **HTT_long_allele**: Number of CAG repeats in the long allele of the _HTT_ gene.

3. [RNA-seq_data.Rmd](./RNA-seq_data.Rmd): R Markdown file containing scripts for RNA-seq data analysis, including descriptive statistics and differential expression analysis of miRNAs. It uses the [demographic data table](./Demographic_data(metadata).xlsx) and the [count matrix](../Count%20matrix/count_matrix.xlsx) as starting points. This script can be run manually or executed along with other scripts automatically. 

   In both cases, a window will first prompt the user to select the working directory. Next, another window will prompt the user to select the count matrix, followed by a third window to select the demographic table.
