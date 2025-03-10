**Criterios de Normalización en DESeq2**
La normalización en DESeq2 es un paso crucial para corregir diferencias en la profundidad de secuenciación y hacer que las comparaciones de expresión entre muestras sean más precisas. 
DESeq2 utiliza un método basado en factores de tamaño (size factors) en lugar de métodos como RPKM o TPM.

**¿Por qué es necesaria la normalización?**
En los datos de secuenciación de ARN, diferentes muestras pueden tener:

- Diferencias en la profundidad de secuenciación (algunas tienen más lecturas que otras).
- Efectos de composición (algunos genes altamente expresados pueden sesgar el análisis).
Por lo tanto, es necesario aplicar factores de normalización para hacer que las muestras sean comparables.

**Método de Normalización en DESeq2: Median of Ratios**
El método que utiliza DESeq2 es Median of Ratios (mediana de razones). Funciona en tres pasos:

**Paso 1: Calcular los factores de tamaño (size factors)**
Para cada muestra, se calcula un factor de tamaño relativo basado en la mediana de las razones de expresión en comparación con la muestra "típica".

-Se eliminan genes con cuentas muy bajas (para evitar sesgos en la normalización).
-Se calcula la razón de cada gen respecto a la media geométrica de ese gen en todas las muestras.
-Se toma la mediana de todas las razones en cada muestra → Este será el factor de tamaño.

**Paso 2: Aplicar los factores de tamaño a los datos**
Cada conteo crudo (counts(dds)) se divide por el factor de tamaño de su muestra:

Esto genera los normalized counts, que se pueden usar para análisis exploratorio.

**Paso 3: Efecto de la normalización**
Antes de normalizar:
Las muestras con mayor profundidad de secuenciación pueden tener valores artificialmente más altos.
Los genes altamente expresados pueden sesgar la distribución.

Después de la normalización:
Las muestras quedan ajustadas para comparaciones justas.
Se eliminan los efectos de la profundidad de secuenciación.
Los valores reflejan mejor las diferencias biológicas reales en lugar de sesgos técnicos.
