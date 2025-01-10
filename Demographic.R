# Instalar y cargar librerías y funciones necesarias----
if (!require("readxl")) install.packages("readxl")
library(readxl)
if (!require("dplyr")) install.packages("dplyr")
library(dplyr)
if (!require("stats")) install.packages("stats")
library(stats)
if (!require("tidyr")) install.packages("tidyr")
library(tidyr)
if (!require("car")) install.packages("car")
library(car)
if (!require("rstatix")) install.packages("rstatix")
library(rstatix)
if (!require("FSA")) install.packages("FSA")
library(FSA)

TABLE <- function(data, variable1, variable2, tableName) {
  Table <- xtabs(formula = as.formula(paste0("~", variable1, "+", variable2)), data = data)
  cat(paste0("\nFrequency table: ", tableName, "\n"))
  Table <- as.matrix(Table)
  rownames(Table) <- levels(data[[variable1]])
  colnames(Table) <- levels(data[[variable2]])
  Table[is.nan(Table)] <- 0
  print(Table)
}

#Ajuste de datos----
Demograficos<-choose.files()
samples <- read_excel(Demograficos)
samples$Condition<-as.factor(samples$Condition)
samples$Pathology<-as.factor(samples$Pathology)
samples$Gender<-as.factor(samples$Gender)
samples$APOE<-as.factor(samples$APOE)


samples <- samples %>%
  mutate(
    # Crear la columna "AI" para identificar los alelos intermedios
    AI = ifelse(HTT_long_allele > 26, "IA", "Normal"),
    
    # Crear la columna "E4" para seleccionar las muestras con APOE-4+
    E4 = ifelse(grepl("4", as.character(APOE)), "APOE4", "No-APOE4")
  )

#Tabla demografica y p valores para los 3 grupos (Condition)----
# Calcular estadísticas descriptivas
Datos_demograficos <- samples %>%
  group_by(Condition) %>%
  summarise(
    Total_muestras = n(),
    # Frecuencias y porcentajes para variables categóricas
    Sexo_hombres = sum(Gender == "M", na.rm = TRUE),
    Sexo_hombres_pct = paste0(round((sum(Gender == "M", na.rm = TRUE) / n()) * 100, 1), "%"),
    HTT_intermedios = sum(AI == "IA", na.rm = TRUE),
    HTT_intermedios_pct = paste0(round((sum(AI == "IA", na.rm = TRUE) / n()) * 100, 1), "%"),
    APOE4_portadores = sum(E4 == "APOE4", na.rm = TRUE),
    APOE4_portadores_pct = paste0(round((sum(E4 == "APOE4", na.rm = TRUE) / n()) * 100, 1), "%"),
    
    # Estadísticas descriptivas para edades/duracion
    Edad_inicio_media = round(mean(Onset_age, na.rm = TRUE),2),
    Edad_inicio_sd = round(sd(Onset_age, na.rm = TRUE),2),
    Edad_muerte_media = round(mean(Death_age, na.rm = TRUE),2),
    Edad_muerte_sd = round(sd(Death_age, na.rm = TRUE),2),
    Duración_media = round(mean(Disease_duration, na.rm = TRUE),2),
    Duración_sd = round(sd(Disease_duration, na.rm = TRUE),2),

    # Estadísticas descriptivas para tamaño de alelos
    HTT_short_allele_media = round(mean(HTT_short_allele, na.rm = TRUE),2),
    HTT_short_allele_sd = round(sd(HTT_short_allele, na.rm = TRUE),2),
    HTT_long_allele_media = round(mean(HTT_long_allele, na.rm = TRUE),2),
    HTT_long_allele_sd = round(sd(HTT_long_allele, na.rm = TRUE),2)
  )

Datos_demograficos<- as.data.frame(t(Datos_demograficos))

# Usar la primera fila como nombres de columnas
colnames(Datos_demograficos) <- Datos_demograficos[1, ]
Datos_demograficos <- Datos_demograficos[-1, ]  # Eliminar la fila usada como nombres
print(Datos_demograficos)

# Test exacto de Fisher para variables categóricas (ya que Chi-cuadrado no es adecuado)
Table<-TABLE(samples,"Condition","Gender","Sex distribution")
pairwise_fisher_test(Table, p.adjust.method="holm",conf.int = TRUE, detailed = T)
Table<-TABLE(samples,"Condition","E4","E4 distribution")
pairwise_fisher_test(Table, p.adjust.method="holm",conf.int = TRUE, detailed = T)
Table<-TABLE(samples,"Condition","AI","AI distribution")
pairwise_fisher_test(Table, p.adjust.method="holm",conf.int = TRUE, detailed = T)

# Test t (si los datos son normales)
dunnTest(samples$Death_age~samples$Condition,
         method = "holm")
dunnTest(samples$HTT_short_allele~samples$Condition,
         method = "holm")
dunnTest(samples$HTT_long_allele~samples$Condition,
         method = "holm")
AD<-subset(samples,samples$Pathology=="AD")
round(t.test(Onset_age ~ Condition, data = AD)$p.value,3)
round(t.test(Disease_duration ~ Condition, data = AD)$p.value,3)
round(t.test(Death_age ~ Condition, data = AD)$p.value,3)

#Tabla demografica y p valores para comparar AD frente a controles (Condition)----

Datos_demograficos_v2 <- samples %>%
  group_by(Pathology) %>%
  summarise(
    Total_muestras = n(),
    # Frecuencias y porcentajes para variables categóricas
    Sexo_hombres = sum(Gender == "M", na.rm = TRUE),
    Sexo_hombres_pct = paste0(round((sum(Gender == "M", na.rm = TRUE) / n()) * 100, 1), "%"),
    HTT_intermedios = sum(AI == "IA", na.rm = TRUE),
    HTT_intermedios_pct = paste0(round((sum(AI == "IA", na.rm = TRUE) / n()) * 100, 1), "%"),
    APOE4_portadores = sum(E4 == "APOE4", na.rm = TRUE),
    APOE4_portadores_pct = paste0(round((sum(E4 == "APOE4", na.rm = TRUE) / n()) * 100, 1), "%"),
    
    # Estadísticas descriptivas para edades/duración
    Edad_inicio_media = round(mean(Onset_age, na.rm = TRUE),2),
    Edad_inicio_sd = round(sd(Onset_age, na.rm = TRUE),2),
    Edad_muerte_media = round(mean(Death_age, na.rm = TRUE),2),
    Edad_muerte_sd = round(sd(Death_age, na.rm = TRUE),2),
    Duración_media = round(mean(Disease_duration, na.rm = TRUE),2),
    Duración_sd = round(sd(Disease_duration, na.rm = TRUE),2),
    
    # Estadísticas descriptivas para tamaño de alelos
    HTT_short_allele_media = round(mean(HTT_short_allele, na.rm = TRUE),2),
    HTT_short_allele_sd = round(sd(HTT_short_allele, na.rm = TRUE),2),
    HTT_long_allele_media = round(mean(HTT_long_allele, na.rm = TRUE),2),
    HTT_long_allele_sd = round(sd(HTT_long_allele, na.rm = TRUE),2)
  )

Datos_demograficos_v2 <- as.data.frame(t(Datos_demograficos_v2))

# Usar la primera fila como nombres de columnas
colnames(Datos_demograficos_v2) <- Datos_demograficos_v2[1, ]
Datos_demograficos_v2 <- Datos_demograficos_v2[-1, ]  # Eliminar la fila usada como nombres
print(Datos_demograficos_v2)

# Test exacto de Fisher para variables categóricas (ya que Chi-cuadrado no es adecuado)
# IC para Sexo
fisher_sexo <- fisher.test(table(samples$Pathology, samples$Gender))
p_sexo <- round(fisher_sexo$p.value, 3)
ic_sexo <- round(fisher_sexo$conf.int, 3)

# IC para APOE4
fisher_apoe4 <- fisher.test(table(samples$Pathology, samples$E4))
p_apoe4 <- round(fisher_apoe4$p.value, 3)
ic_apoe4 <- round(fisher_apoe4$conf.int, 3)

# IC para AI
fisher_IA <- fisher.test(table(samples$Pathology, samples$AI))
p_IA <- round(fisher_IA$p.value, 3)
ic_IA <- round(fisher_IA$conf.int, 3)

# Imprimir resultados
cat("Sexo - p:", p_sexo, ", IC:", ic_sexo, "\n")
cat("APOE4 - p:", p_apoe4, ", IC:", ic_apoe4, "\n")
cat("AI - p:", p_IA, ", IC:", ic_IA, "\n")



# Si los datos numéricos cumplen con normalidad, se puede usar t-test:
# Verificar normalidad de los datos
shapiro.test(samples$Death_age[samples$Pathology == "AD"])  
shapiro.test(samples$Death_age[samples$Pathology == "Control"]) 
shapiro.test(samples$HTT_short_allele[samples$Pathology == "AD"])  
shapiro.test(samples$HTT_short_allele[samples$Pathology == "Control"]) 
shapiro.test(samples$HTT_long_allele[samples$Pathology == "AD"])  
shapiro.test(samples$HTT_long_allele[samples$Pathology == "Control"]) 

leveneTest(Death_age ~ Pathology, data = samples)
# Test t (si los datos son normales)
p_edad_muerte <- round(t.test(Death_age ~ Pathology, data = samples)$p.value,3)
#Wilcox si los datos no son normales
p_alelo_corto <- round(wilcox.test(HTT_short_allele ~ Pathology, data = samples, exact=FALSE)$p.value,3)
p_alelo_largo <- round(wilcox.test(HTT_long_allele ~ Pathology, data = samples, exact=FALSE)$p.value,3)
                                            
# Crear tabla resumen con p-valores
pvalores_demograficos_v2 <- data.frame(
  Variable = c("Sexo (hombres)", "Edad de muerte", 
               "Alelo corto HTT", "Alelo largo HTT", "APOE ε4","IA"),
  p_valor = c(p_sexo, p_edad_muerte, p_alelo_corto, p_alelo_largo, p_apoe4,p_IA)
)
print(pvalores_demograficos_v2)

