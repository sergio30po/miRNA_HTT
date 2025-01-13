# Análisis de Datos RNA-seq y Demográficos

Este repositorio contiene todos los archivos y scripts necesarios para el análisis estadístico y de expresión diferencial de datos de RNA-seq, así como la recopilación de datos demográficos de las muestras utilizadas en el proyecto.

Contenido del repositorio
Archivos principales:
1. Demographic.R: Archivo con scripts en R para procesar y analizar los datos demográficos de las muestras. Este código emplea como punto de partida la tabla de datos demográficos. 

2. Demographic_data.xlsx: Base de datos en formato Excel con información demográfica de las muestras. Incluye los siguientes campos:

+ Sample
+ Patient_ID
+ Condition
+ Pathology
+ Biobank
+ Gender
+ Onset_age
+ Death_age
+ Braak_stage
+ APOE
+ Disease_duration
+ HTT_short_allele
+ HTT_long_allele
+ PMI

3. RNA-seq_data.Rmd: Archivo R Markdown que contiene los scripts para el análisis de datos de RNA-seq, incluyendo estadística descriptiva y análisis de expresión diferencial de miRNAs.

