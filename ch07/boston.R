boston <- read.csv('data/boston.csv')
boston
library(dplyr)
library(ggplot2)
str(boston)
glimpse(boston)

boston %>% 
    select(B,AGE) %>% 
    ggplot(aes(B,AGE, col=AGE)) +
    geom_point(alpha=0.3, position='jitter')


