# 데이터 시각화

library(gapminder)
library(dplyr)

y <- gapminder %>%
    group_by(year, continent) %>%
    summarize(c_pop=sum(pop))
head(y,20)

# 1단계 - 막 그래프
plot(y$year,y$c_pop)

# 2단계 - 마커의 색상 변경 (대륙별)
plot(y$year,y$c_pop,col=y$continent)

# 3단계 - 마커의 모양 변경 (대륙별)
plot(y$year,y$c_pop,col=y$continent, pch=c(1:5))
length(levels(y$continent)) # 대륙 항목 개수 확인
plot(y$year,y$c_pop,col=y$continent,
     pch=c(1:length(levels(y$continent))))

# 4단계 - 범례 표시
legend('topleft',
       legend=levels(y$continent),
       pch=c(1:length(levels(y$continent))),
       col=c(1:length(levels(y$continent))))

# 대륙별 인당 GDP, 기대수명

plot(gapminder$gdpPercap, gapminder$lifeExp,
     pch=c(1:length(levels(gapminder$continent))),
     col=gapminder$continent)
legend('bottomright',
       legend=levels(gapminder$continent),
       pch=c(1:length(levels(gapminder$continent))),
       col=c(1:length(levels(gapminder$continent))))

# 로그 스케일 적용
plot(log10(gapminder$gdpPercap), gapminder$lifeExp,
     pch=c(1:length(levels(gapminder$continent))),
     col=gapminder$continent)
legend('bottomright',
       legend=levels(gapminder$continent),
       pch=c(1:length(levels(gapminder$continent))),
       col=c(1:length(levels(gapminder$continent))))

# ggplot을 이용해서 그려보기
library(ggplot2)

## 인구수에 따른 도표의 크기 조절
ggplot(gapminder, aes(x=gdpPercap,y=lifeExp,col=continent,size=pop)) +
    geom_point() +
    scale_x_log10()

## 도표의 투명도를 이용한 심미적 기능 추가
ggplot(gapminder, aes(x=gdpPercap,y=lifeExp,col=continent,size=pop)) +
    geom_point(alpha=0.5) +
    scale_x_log10()

# 2007년도 자료만 보기 (filter로 자료 추출 후 그래프 표현) (dplyr과 ggplot 연동)
gapminder %>%
    filter(year==2007) %>% 
    ggplot(aes(x=gdpPercap,y=lifeExp,col=continent,size=pop)) +
    geom_point(alpha=0.5) +
    scale_x_log10()

ggplot(gapminder, aes(x=gdpPercap,y=lifeExp,col=continent,size=pop)) +
    geom_point(alpha=0.5) +
    scale_x_log10() +
    facet_wrap(~year)

# 시각화 기본 기능
# 1. 비교/순위
gapminder %>% 
    filter(continent=='Asia' & year==1952) %>% 
    ggplot(aes(reorder(country,pop),pop)) +
    geom_bar(stat='identity') +
    coord_flip() # 차트 옆으로

# 2. 비교/순위 - 로그 스케일 조정
gapminder %>% 
    filter(continent=='Asia' & year==1952) %>% 
    ggplot(aes(reorder(country,pop),pop)) +
    geom_bar(stat='identity') +
    scale_y_log10() +
    coord_flip()

# 3. 변화 추세
gapminder %>% 
    filter(country=='Korea, Rep.') %>% 
    ggplot(aes(year,lifeExp, col=country)) +
    geom_point() +
    geom_line()

# 4. 여러 데이터의 변화 추세
    ggplot(gapminder, aes(x=year, y=lifeExp, col=continent)) +
    geom_point(alpha=0.2) +
    geom_smooth()

# 5. 분포 - 히스토그램 (main = '차트 제목')
x <- filter(gapminder,year==1952)
hist(x$lifeExp, main='Histogram of lifeExp in 1952')

# ggplot을 이용한 히스토그램

x %>% 
    ggplot(aes(lifeExp)) +
    geom_histogram()

# 6. 대륙별 세분화된 분포 특성 - boxplot
x %>% 
    ggplot(aes(continent,lifeExp)) +
    geom_boxplot()

# 7. 상관 관계
plot(log10(gapminder$gdpPercap), gapminder$lifeExp)
