# Charger les packages nécessaires
library(e1071)
library(caret)
library(tidyr)
library(dplyr)

# Définir le répertoire de travail
setwd("C:/Users/tony7/Desktop/data")

# Charger et préparer les données de base
tab <- read.csv("2_Data_RNASeq_Cannabis_Sex.csv")

# Remplacer les identifiants des gènes par leurs noms (REM16 et FT1)
tab$X <- tab$X %>%
  gsub("LOC115699937", "REM16", .) %>%
  gsub("LOC115696989", "FT1", .)

# Fonction pour préparer les données de gène en format long
prepare_gene_data <- function(data, gene_name) {
  gene_data <- data %>% filter(X == gene_name)
  gene_long <- as.data.frame(t(gene_data[,-1])) %>%
    rename(expression = V1) %>%
    mutate(
      sample = rownames(.),
      sex = substr(sample, nchar(sample) - 1, nchar(sample)),
      gene = gene_name
    )
  return(gene_long)
}

# Préparer les données pour les gènes REM16 et FT1
rem16_long <- prepare_gene_data(tab, "REM16")
ft1_long <- prepare_gene_data(tab, "FT1")

# Combiner les données des deux gènes
data_t <- bind_rows(rem16_long, ft1_long)

# Charger et préparer les données pour le modèle
data_model_raw <- read.csv("data_modele.csv", header = FALSE) %>%
  slice(-3) %>%  # Supprimer la ligne inutile si nécessaire
  t() %>% 
  as.data.frame() %>%
  rename(sample = V1, expression = V2, sex = V3, gene = V4)

# Nettoyer les noms d'échantillon et convertir les types
data_t <- data_t %>%
  mutate(
    sample = gsub("XX1", "XX", sample),
    sample = gsub("XY1", "XY", sample),
    expression = as.numeric(as.character(expression))
  )

# Transformer les données en format large pour chaque gène
data_wide <- data_t %>%
  pivot_wider(names_from = gene, values_from = expression) %>%
  select(REM16, FT1, sex)

# Convertir la variable cible 'sex' en facteur
data_model <- data_wide %>%
  mutate(sex = as.factor(sex))

# Diviser les données en ensemble d'entraînement et de test
set.seed(42)
trainIndex <- createDataPartition(data_model$sex, p = 0.7, list = FALSE)
train_data <- data_model[trainIndex, ]
test_data <- data_model[-trainIndex, ]

# Entraîner le modèle SVM
svm_model <- svm(sex ~ REM16 + FT1, data = train_data, kernel = "linear")

# Faire des prédictions sur l'ensemble de test
predictions <- predict(svm_model, test_data)

# Évaluer les performances du modèle
conf_matrix <- confusionMatrix(predictions, test_data$sex)
print(conf_matrix)



# Entraîner le modèle SVM
svm_model <- svm(sex ~ REM16 + FT1, data = train_data, kernel = "linear")

# Sauvegarder le modèle
saveRDS(svm_model, "svm_model.RDS")
