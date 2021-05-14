getwd()
library(dplyr)
library(ggplot2)
library(gapminder)

t_trade<- read.csv('data/trade/total_trade.csv')
t_trade
View(t_trade)
t_g <- t_trade %>%
    group_by(시군구,계약연도) %>% 
    ggplot(aes(계약연도,t_거래금액,group=시군구,col=시군구)) + 
    geom_point(stat='identity',alpha=0.2, position='jitter') +
    scale_y_log10()
t_g


t_g_b <- t_trade %>%
    group_by(시군구,계약연도) %>% 
    ggplot(aes(계약연도,t_거래금액,group=시군구,col=시군구)) + 
    geom_bar(stat='identity', position='dodge',aes(fill=시군구))  
t_g_b

summarise(avg_t_trade = mean(전용면적),avg_mon=mean(거래금액),
          +               avg_avg=avg_mon/avg_t_trade) 
dun_avg_16

t_trade %>% 
    group_by(시군구,계약연도,거래금액) %>% 
    summarise(avg_t_trade = mean(전용면적),avg_mon=mean(거래금액),
              avg_avg=avg_mon/avg_t_trade) %>% 
    ggplot(aes(계약연도,avg_avg,group=시군구,col=시군구)) +
    geom_bar(stat='identity',position='jitter')
