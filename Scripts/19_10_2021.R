# Import des données 
library(tidyverse)
data <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-19/pumpkins.csv')

# Statistiques
table(data$id)  #années de 2013 à 2021
n_distinct(data$state_prov) #188 états
n_distinct(data$country) #75 pays

# On sépare l'année et le type
data$year <- substr(data$id, 1,4)
data$type <- substr(data$id, 6,7)
n_distinct(data$year) #9 années
n_distinct(data$type) # 6 types

# Sous df avec seulement les plus gros légumes
ranking_first <- data %>% filter(place == 1) %>% arrange(type) %>% select(3,15,16)
ranking_first$year <- as.integer(ranking_first$year, length = 4)



            # GRAPH

ranking_first %>% filter(type == "F") %>%
    ggplot(aes(x = year, y = weight_lbs, group=1)) + 
    geom_line(color = "#FC4E07", size = 2) +
    geom_point(color = "#FC4E07", size = 9, shape = "\U1F383") +
    labs(x = "Year", y = "Weight in pounds", title = "Weight evolution of the biggest field pumpkin from 2013 to 2021") +
    theme_classic() +
    theme(panel.background = element_rect(fill = "black", colour="black"),
          plot.background = element_rect(fill = "black", colour="black"),
          axis.text = element_text(color = "yellow", size = 12),
          axis.line = element_line(colour = "yellow", size = 1),
          axis.title = element_text(colour = "yellow", size = 15),
          axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0)), # increase space between text and title
          axis.title.x = element_text(margin = margin(t = 20, r = 0, b = 0, l = 0)),
          plot.title = element_text(colour = "yellow", size = 20, margin = margin(t = 0, r = 0, b = 20, l = 0))
          )






