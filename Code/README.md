# Análisis de Datos RNA-seq y Demográficos

Este repositorio contiene todos los archivos y scripts necesarios para el análisis estadístico y de expresión diferencial de datos de RNA-seq, así como la recopilación de datos demográficos de las muestras utilizadas en el proyecto.

Contenido del repositorio
Archivos principales:
1. [Demographic.R](./Demographic.R): Archivo con scripts en R para procesar y analizar los datos demográficos de las muestras. Este código emplea como punto de partida la [tabla de datos demográficos](./Demographic_data(metadata).xlsx). 

2. [Demographic_data(metadata).xlsxs](./Demographic_data(metadata).xlsx): Base de datos en formato Excel con información demográfica de las muestras. Incluye los siguientes campos:

+ Sample: Identificador único de la muestra utilizada.
+ Condition: Estado clínico del paciente (A: EA; B:EA con IA; C:control).
+ Pathology: Tipo de patología (EA o Control).
+ Gender: Género del paciente (masculino: M, femenino: F).
+ Onset_age: Edad de inicio de la enfermedad en el paciente.
+ Death_age: Edad del paciente al momento del fallecimiento.
+ Braak_stage: Clasificación del estadio de la patología según los criterios de Braak.
+ APOE: Genotipo del alelo APOE asociado al paciente (relevante en enfermedades neurodegenerativas).
+ Disease_duration: Duración de la enfermedad (en años) desde el inicio hasta el fallecimiento.
+ HTT_short_allele: Número de repeticiones CAG en el alelo corto del gen _HTT_.
+ HTT_long_allele: Número de repeticiones CAG en el alelo largo del gen _HTT_.
+ PMI: Intervalo post-mortem (en horas) entre el fallecimiento y la recolección de la muestra.

3. [RNA-seq_data.Rmd](./RNA-seq_data.Rmd): Archivo R Markdown que contiene los scripts para el análisis de datos de RNA-seq, incluyendo estadística descriptiva y análisis de expresión diferencial de miRNAs. Para ello se emplea como punto de partida la [tabla de datos demográficos](./Demographic_data(metadata).xlsx) y la [matriz de conteos](../Count%20matrix/count_matrix.xlsx). Este script se puede ejecutar manualmente o se puede ejecutar con el resto de scripts de forma automática.
En ambos casos, saldrá una primera ventana para seleccionar el directorio de trabajo. A continuación saldrá una ventana para seleccionar la matriz de conteo y finalmente otra ventana para seleccionar la tabla demográfica.

