# Analysis of differential expression of miRNAs in brain tissue of patients with Alzheimer's disease: Influence of _HTT_ genotype
**Abstract** 

This work analyzes the differential expression of microRNAs (miRNAs) in brain tissue of patients with Alzheimer's disease (AD), considering the influence of intermediate alleles (IA) of the HTT gene, known for their pathological role in neurodegeneration. A cohort of 27 patients with AD and 6 healthy controls was used to perform a bioinformatics analysis using pipelines designed in R language. The data, processed with the DESeq2 package, allowed the identification of differentially expressed miRNAs in three key comparisons: AD versus controls, AD without IA versus controls, and AD with IA versus controls.
The results revealed that patients with AD and IA present a higher number of deregulated miRNAs compared to the other groups, suggesting a possible synergistic effect between IA and AD pathological processes. These miRNAs are involved in key biological pathways, such as cell proliferation, intracellular signaling, regulation of apoptosis and neuroinflammation. In addition, specific changes were observed in metabolic pathways related to drug resistance and oncological processes.
The functional analysis of the target genes of the deregulated miRNAs reinforces the hypothesis that AIs of the HTT gene can act as modifying factors in the progression of AD, affecting essential cellular mechanisms. These findings have the potential to open new avenues for developing biomarkers and targeted therapeutic strategies in AD.

The repository contains the following files:
1. [LICENSE](./LICENSE): A GNU GENERAL PUBLIC LICENSE (Version 3, 29 June 2007) is used in accordance with the original text file where all the results are collected, which presents a GNU Free Documentation License (GNU FDL).
2. [Read_counts.rar](./Read_counts.rar): Compressed file containing the read counts of all samples analyzed by RNA-seq. These initial data are available in the ZENODO repository for public consultation, through the code “11185109”.
https://zenodo.org/records/11185109

3. [Count matrix folder](./Count%20matrix): Contains all the macros needed to create the counting matrix from the individual read_counts.

4. [Code](./Code): Contains all the scripts and datasets needed to create the differential expression analysis.
