library(dplyr)
library(ggplot2)
library(gapminder)

### 01. gapminder 데이터에 기록된 전 세계 인구의 구성 비율 변화
#### 1) 1952~2007년 중 1952년도의 인구 구성을 추출한 후 시각화하라
x = gapminder %>%  
    filter(year==1952) %>% 
    select(continent, pop) %>% 
    head()

pie(x$pop, x$continent)
barplot(x$pop, names.arg=x$continent)

#### 2) 1952~2007년의 인구 구성을 for 문을 이용해 반복적으로 시각화하라
x = gapminder %>%
i = 1952+5n %>% 
    for (n in 0:11) {
        filter(year==i) %>% 
        select(x$year, x$pop) %>% 
    head()
}
pie(x$pop, x$continent)

x <- gapminder %>% 
    filter(year==1952,continent=='Asia') %>% 
    mutate(gdp=gdpPercap*pop) %>% 
    select(country, gdp) %>% 
    arrange(desc(gdp)) %>%
    head()
pie(x$gdp, x$country)
barplot(x$gdp, names.arg=x$country)

#### 3) 시각화 그래프를 통해 알게 된 사실을 몇 가지로 요약하라

### 02. ggplot2를 이용하여 Iris 데이터 셋에 대해서 다음 문제를 푸세요.

#### 1) 품종별로 Sepal/Petal의 Length, Width 산점도 그리기. (총 6개)
iris %>% 
    filter(Species=='setosa') %>%
    ggplot(aes(x=Sepal.Length, y=Sepal.Width)) +
    geom_point(alpha=0.2) +
    ggtitle("Setosa Sepal Length-Width")

iris %>% 
    filter(Species=='setosa') %>%
    ggplot(aes(x=Petal.Length, y=Petal.Width)) +
    geom_point(alpha=0.2) +
    ggtitle("Setosa Petal Length-Width")

iris %>% 
    filter(Species=='versicolor') %>%
    ggplot(aes(x=Sepal.Length, y=Sepal.Width)) +
    geom_point(alpha=0.2) +
    ggtitle("Versicolor Sepal Length-Width")

iris %>% 
    filter(Species=='versicolor') %>%
    ggplot(aes(x=Petal.Length, y=Petal.Width)) +
    geom_point(alpha=0.2) +
    ggtitle("Versicolor Petal Length-Width")

iris %>% 
    filter(Species=='virginica') %>%
    ggplot(aes(x=Sepal.Length, y=Sepal.Width)) +
    geom_point(alpha=0.2) +
    ggtitle("Virginica Sepal Length-Width")

iris %>% 
    filter(Species=='virginica') %>%
    ggplot(aes(x=Petal.Length, y=Petal.Width)) +
    geom_point(alpha=0.2) +
    ggtitle("Virginica Petal Length-Width")



#### 2) 품종별 Sepal/Petal의 Length/Width 평균을 비교하되 항목을 옆으로 늘어놓은 것(beside=T)과 위로 쌓아올린 것 2개를 그리시오. 
#### (총 12개 항목의 데이터를 2개의 그래프에)

avg_Sepal.L <- mean(iris$Sepal.Length)
avg_Sepal.W <- mean(iris$Sepal.Width)
avg_Petal.L <- mean(iris$Petal.Length)
avg_Petal.W <- mean(iris$Petal.Width)

iris %>%
    ggplot(aes(x=avg_Sepal.L,y=avg_Sepal.W, col=Species)) +
    geom_bar(stat='identity') +
    coord_flip()

iris %>%
    ggplot(aes(x=avg_Petal.L,y=avg_Petal.W, col=Species)) +
    geom_bar(stat='identity') +
    coord_flip()

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, col=Species)) +
    geom_bar(stat='identity')

#### 3) 박스 플롯 그리기
boxplot(iris)
