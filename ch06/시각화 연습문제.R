# 1. mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비) 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 cty, y축은 hwy로 된 산점도를 만들어 보세요.
library(dplyr)
library(ggplot2)
library(tidyr)

mpg %>%
    select(cty,hwy) %>% 
    ggplot(aes(cty, hwy, col='class')) +
    geom_point(position='jitter')
##------------------------------------------

## 정답
head(mpg)
ggplot(mpg, aes(cty,hwy,col=class)) +
    geom_point(position='jitter')


# 2. 미국 지역별 인구통계 정보를 담은 ggplot2 패키지의 midwest 데이터를 이용해서 전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 알아보려고 합니다.
# x축은 poptotal(전체 인구), y축은 popasian(아시아인 인구)으로 된 산점도를 만들어 보세요.
# 전체 인구는 50만 명 이하, 아시아인 인구는 1만 명 이하인 지역만 산점도에 표시되게 설정하세요.

x <- midwest %>% 
    filter(poptotal<=500000 & popasian <=10000) %>% 
    ggplot(aes(poptotal,popasian,col=state)) + 
    geom_point() +
    scale_x_log10() +
    scale_y_log10()
x
## --------------------------------------------------------
## 정답
head(midwest)
mw <- midwest %>% 
    filter(poptotal <= 500000 & popasian <= 10000)
options(scipen = 10) # 지수 표기를 일반 표기로 변환
ggplot(mw, aes(x=poptotal, y=popasian, col=state)) +
    geom_point() +
    xlim(0,500000) + ylim(0,10000)

# 연결해서 한번에 표기
midwest %>% 
    filter(poptotal <= 500000 & popasian <= 10000) %>% 
    ggplot(aes(x=poptotal, y=popasian, col=state)) +
    geom_point() +
    scale_x_log10() + scale_y_log10()

# 3. 어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 알아보려고 합니다. "suv" 차종을 대상으로 평균 cty(도시 연비)가 가장 높은 회사 다섯 곳을 막대 그래프로 표현해 보세요. 막대는 연비가 높은 순으로 정렬하세요. 

x <- mpg %>% 
    filter(class=='suv') %>% 
    group_by(manufacturer) %>%
    summarise(mcty=mean(cty)) %>% 
    head(5) %>%
    ggplot(aes(reorder(manufacturer,-mcty),mcty)) +
    geom_bar(stat='identity')
x

## 정답 -----------------------------

mpg %>% 
    filter(class == 'suv') %>% 
    group_by(manufacturer) %>% 
    summarise(mean_cty = mean(cty)) %>% 
    arrange(desc(mean_cty)) %>% 
    head(5) %>% 
    ggplot(aes(x=reorder(manufacturer, -mean_cty), y=mean_cty,
               fill=manufacturer)) +
    geom_col() +
    labs(x='Manufacturer', y='average cty)')

# 4. 자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 합니다. 자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.

mpg %>% 
    group_by(class) %>% 
    summarise(num_kind=n()) %>% 
    arrange(desc(num_kind)) %>% 
    ggplot(aes(class,num_kind, col=class)) +
    geom_bar(stat='identity')
    
## 정답 ---------------------------------
mpg %>% 
    group_by(class) %>% 
    summarise(count = n()) %>% 
    ggplot(aes(x=reorder(class,-count),y=count,fill=class))+  # bar에서 col=() X, fill=() O
    geom_col() +
    labs(x='Class')


# 5. economics 데이터를 이용해서 psavert(개인 저축률)가 시간에 따라서 어떻게 변해왔는지 알아보려고 합니다. 시간에 따른 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어 보세요.

economics %>% 
    group_by(psavert) %>% 
    ggplot(aes(date,psavert)) +
    geom_point(stat='identity') +
    geom_smooth()

## 정답 ------------------
head(economics)
ggplot(economics, aes(date,psavert)) +
    geom_line()

#두가지 항목 표기
head(economics)
ggplot(economics) +
    geom_line(aes(date,psavert))+
    geom_line(aes(date, uempmed))

# 6. class(자동차 종류)가 "compact", "subcompact", "suv"인 자동차의 cty(도시 연비)가 어떻게 다른지 비교해보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만들어보세요.

mpg %>% 
    filter(class=='compact' | class=='subcompact' | class=='suv') %>%
    ggplot(aes(class,cty, col=class)) +  # fill=class로 대체 가능
    geom_boxplot()



# 7. Diamonds 데이터 셋을 이용하여 다음 문제를 해결하세요. (단, 컬러, 제목, x축, y축 등 그래프를 예쁘게 작성하세요.)
# 1) cut의 돗수를 보여주는 그래프를 작성하세요.
diamonds %>%
    select(carat,cut) %>% 
    ggplot(aes(cut, carat)) +
    geom_bar(stat='identity', aes(fill=cut)) +
    scale_fill_brewer(palette='RdBu') +
    ggtitle('Diamonds-cut')

## 정답
ggplot(diamonds, aes(cut, fill=cut)) +
    geom_bar()

# 2) cut에 따른 가격의 변화를 보여주는 그래프를 작성하세요.
diamonds %>% 
    select(cut,price) %>% 
    ggplot(aes(cut,price,col=cut)) +
    geom_point(stat='identity',alpha=0.2, position='jitter') +
    geom_smooth()

## 정답----------------------------------
diamonds %>% 
    group_by(cut) %>% 
    summarise(mean_price=mean(price)) %>% 
    ggplot(aes(cut,mean_price,fill=cut)) +
    geom_col()

# 3) cut과 color에 따른 가격의 변화를 보여주는 그래프를 작성하세요.

diamonds %>% 
    group_by(color,cut) %>% 
    ggplot(aes(color,price,group=cut,fill=cut)) +
    geom_bar(stat='identity',position='dodge') +
    geom_smooth() +
    ggtitle('Diamonds-price')

# cut, color에 따른 도수 분포
ggplot(diamonds, aes(x=price)) +
    geom_histogram(bins=5) +
    facet_wrap(~cut + color)

# cut이 'Fair'인 경우, color에 따른 가격의 변화
df_cut_fair <- diamonds %>% 
    fliter(cut=='Fair') %>% 
    group_by(color) %>%
    summarise(mean_price=mean(price))
g_fair <- ggplot(df_cut_fair, aes(color, mean_price, fill=color)) +
    geom_col() +
    ggtitle('Cut = Fair') +
    theme(plot.title=element_text(face="bold", size=16,
                                  vjust=1, color='red'))
g_fair


