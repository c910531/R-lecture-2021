getwd()
library(dplyr)
library(ggplot2)


d_trade <- read.csv('data/trade/d_trade.csv')
d_trade


summary(d_trade)
View(d_trade)

d_trade %>% 
    filter(계약연도==2017) %>% 
    select(시군구, 전용면적,거래금액) %>% 
    summarise(avg_d_trade = mean(전용면적),avg_mon=mean(거래금액),
              avg_avg=avg_mon/avg_d_trade) %>% 
    ggplot(aes(avg_d_trade, avg_mon)) +
    geom_boxplot()
