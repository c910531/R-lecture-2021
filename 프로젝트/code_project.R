getwd()
library(dplyr)
library(ggplot2)
library(gapminder)

t_trade <- read.csv('data/trade/t_total.csv')
t_trade
View(t_trade)
summary(t_trade)

### 1-1번 그래프 ###
t_g <- t_trade %>%
    filter(계약연도!=2021) %>% 
    group_by(구,계약연도) %>% 
    ggplot(aes(계약연도,거래금액)) + 
    geom_point(stat='identity',alpha=0.2, position='jitter')
t_g

### 1-2번 그래프(세부년도 기재) ###
t_g_b <- t_trade %>%
    group_by(구,계약연도) %>% 
    ggplot(aes(계약연도,거래금액,group=구,col=구)) + 
    geom_bar(stat='identity', position='dodge',aes(fill=구)) 
t_g_b

### 2번 그래프 ###
t_trade %>% 
    group_by(계약연도,구) %>% 
    summarise(avg_t_trade = mean(거래금액)) %>% 
    ggplot(aes(계약연도,avg_t_trade))  +
    geom_line(aes(color=구))  +
    ylab("평균거래가") +
    labs(title = '지역구별 평균거래가격 추이')


### 1-3번 그래프 (거래량) ###

t_volume <- t_trade %>%
    filter(계약연도 != 2021) %>% 
    group_by(계약연도,구) %>% 
    summarise(num_kind=n()) %>% 
    ggplot(aes(계약연도,num_kind)) +
    geom_bar(stat='identity', position='dodge',aes(fill=구)) +
    ylab("계약건수")
t_volume
