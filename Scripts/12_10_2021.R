# Import des données
library(tidyverse)
data <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-12/capture-fishery-production.csv')

# Nombre d'années dispo
table(data$Year)  #1960 à 2018

# Nombre de pays
n_distinct(data$Entity) #264


        # Manipulations des données


# On récupère le continent de chaque pays (264 pays)
library(countrycode)
data$continent <- countrycode(sourcevar = data$Entity,
                            origin = "country.name",
                            destination = "continent")

# On filtre sur l'Europe
data <- data %>% filter(continent == "Europe")

# Nombre de pays
n_distinct(data$Entity)  #46

# Année la plus complète
table(data$Year)  #à partir de 2006

# Sous-base pour 2018 (données les plus récentes)
data_18 <- data %>% filter(Year == 2018)

# On ne garde que les 2 premières lettres des Pays
data_18$Code_2 <- substr(data_18$Code,1,2)

# On supprime les colonnes inutiles
data_18 <- data_18 %>% select(6,4)

# On renomme les colonnes
data_18 <- data_18 %>% rename(id = Code_2,
                              capture = `Capture fisheries production (metric tons)`)




        # Graphique


# Library
library(cartography)
library(sp)

# Upload data attached with the package.
data(nuts2006)

# Plot Europe
plot(nuts0.spdf, border = NA, col = NA, bg = "#A6CAE0")
plot(world.spdf, col = "#E3DEBF", border = NA, add = TRUE)
plot(nuts0.spdf, col = "#D1914D", border = "grey80",  add = TRUE)

# Add circles proportional to the total population in 2018
propSymbolsLayer(spdf = nuts0.spdf, df = data_18,
    var = "capture", symbols = "circle", col = "#920000",
    legend.pos = "right", legend.title.txt = "Capture fisheries \nproduction (metric tons)",
    legend.style = "c")

# Add titles, legend...
layoutLayer(title = "Countries capture fisheries production in Europe in 2018",
    sources = "OurWorldinData.org, 2018",
    scale = NULL, south = TRUE)



