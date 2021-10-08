# Import des données
library(tidyverse)
data <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-05/nurses.csv')

# Format et nombre d'observations
str(data)
dim(data)

# Nombre d'années
table(data$Year)

# Sous-base
df <- data %>% select(1:4,8) %>% rename(salary_med = `Annual Salary Median`,
                                         total_employed = `Total Employed RN`,
                                         standard_error = `Employed Standard Error (%)`)

# Plot
library(gganimate)
df %>%
  ggplot(aes(x=total_employed, y=salary_med, size=standard_error)) +
    geom_point(alpha=0.6, shape=21, color="black", fill = "#0066CC") +
    scale_size(name="Employed standard error") +
    theme_bw() +
    theme(legend.position="bottom") +
    xlab("Total employed registered nurses") +
    ylab("Annual salary median") +
    scale_x_continuous(breaks = seq(0, 300000, 100000), labels = c("0","100000","200000","300000")) +
    transition_time(Year) +
    labs(title = "Total employed nurses given the median anual salary in US",
         subtitle = "Year: {as.integer(frame_time)}")  +
    theme(plot.title = element_text(size = 13.8, face = "bold"))
anim_save("05_10_2021.gif")




