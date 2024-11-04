# SexCannalyzer

### Auteur : Marc-Antoine Chiasson  
### Date : 2024-10-30

## Description
**SexCannalyzer** est un script R permettant de déterminer le sexe des plants de cannabis en fonction de l'expression différentielle de deux gènes spécifiques : **REM16** et **FT1**. En analysant les niveaux d'expression de ces gènes, le script permet de classifier les plants de cannabis comme mâle ou femelle et d'identifier les cas potentiellement problématiques. Cette approche est utile pour les chercheurs en biologie végétale et les producteurs de cannabis qui souhaitent détecter le sexe des plants de manière précoce.

## Cas d'utilisation
Le but de **SexCannalyzer** est de :
- Identifier les différences d'expression entre deux gènes clés pour la détermination du sexe du cannabis.
- Filtrer les données transcriptomiques et visualiser les niveaux d'expression de **REM16** et **FT1**.
- Classifier les plants en tant que mâles ou femelles selon les critères d'expression génétique établis.

## Données d'entrée
- **Fichier de données transcriptomiques** : Un fichier CSV contenant les données d'expression des gènes pour différents échantillons. Le fichier doit inclure une colonne nommée `X` avec les identifiants de gènes, tels que `LOC115699937` et `LOC115696989`, qui seront automatiquement renommés en **REM16** et **FT1**. Chaque colonne représente l'identifiant du génotype.
![Texte alternatif de l'image](images/ex_tab_csv.png)

## Résultats
Le script produit plusieurs types de sorties :
1. Un graphique de l'expression du gène REM16 en fonction du sexe.
![Texte alternatif de l'image](images/REM16.png)

2. Un graphique de l'expression du gène FT1 en fonction du sexe.
![Texte alternatif de l'image](images/FT1.png)


3. Un graphique combiné de l'expression des gènes REM16 et FT1 colorié selon le sexe.
![Texte alternatif de l'image](images/REM16+FT1.png)

4. Un tableau présentant le résultats d'un modèle SVM pouvant prédire le sexe en fonction des différences d'expression des deux gènes.



## Instructions

### Pré-requis
- **R** version 4.0 ou supérieure.
- Packages **dplyr**, **ggplot2**, et **ggpubr** (pour les visualisations).
  
### Étapes pour exécuter le script
  
1. **Charger et exécuter le script** : Double-cliquez sur le script `SexCannalyzer.Rmd` dans RStudio ou via une ligne de commande R. Ensuite faire knit sur le document.

2. **Interpréter les graphiques et résultats** :
   - Ouvrez les graphiques générés pour observer les niveaux d'expression de **REM16** et **FT1**. 
   - Suivez les critères d'interprétation pour déterminer le sexe de chaque échantillon :
     - **REM16 ~ 10,5 et FT1 ~ 6,5** : Femelle
     - **REM16 ~ 8,75 et FT1 exprimé** : Mâle
     - **REM16 exprimé sans FT1** : Cas problématique à vérifier
    
   
