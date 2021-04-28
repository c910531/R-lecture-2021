library(dplyr)
library(ggplot2)
library(gapminder)

### 01. gapminder 데이터에 기록된 전 세계 인구의 구성 비율 변화
#### 1) 1952~2007년 중 1952년도의 인구 구성을 추출한 후 시각화하라
x = gapminder %>%  
    filter(year==1952) %>% 
    select(country, pop) %>%
    arrange(desc(pop)) %>% 
    head()

pie(x$pop, x$country)
barplot(x$pop, names.arg=x$country)

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

## 2) 정답 (# 숫자 초과로 인한 표기를 as.numeric통해 오류 정정) 
for (i in seq(1952,2007,5)) {
    print(i)
    x <- gapminder %>% 
        filter(year==i) %>% 
        select(country, pop) %>% 
        arrange(desc(pop)) %>% 
        head()
    pie(as.numeric(x$pop), x$country)
    barplot(x$pop, names.arg=x$country)
    title(i)
}


#### 3) 시각화 그래프를 통해 알게 된 사실을 몇 가지로 요약하라

### 02. ggplot2를 이용하여 Iris 데이터 셋에 대해서 다음 문제를 푸세요.

# 2-1 airquality
head(airquality)
library(tidyr)
air_tidy <- gather(airquality, key='Measure', value='Value',
                   -Day, -Month)
head(air_tidy)
tail(air_tidy)
dim(airquality)
dim(air_tidy)

air_tidy %>% 
    ggplot(aes(Day, Value, col=Measure)) +
    geom_point() +
    facet_wrap(~Month)

# 정답
#2-2 iris

iris_tidy <- gather(iris, key='feat', value='value',
                    -Species)
head(iris_tidy)
tail(iris_tidy)
iris_tidy %>% 
    ggplot(aes(feat, value, col=Species)) +
    geom_point(position='jitter') # jitter -> 중복값의 중복 표기 방지

#### 1) 품종별로 Sepal/Petal의 Length, Width 산점도 그리기. (총 6개)
### 항목이 여러개일때 x축 y축 2가지 분류로 나눈 후 그래프 구성하면 쉽다 (tidyr 패키지 활용)


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

# 정답
seto <- filter(iris, Species=='setosa')
vers <- filter(iris, Species=='versicolor')
virg <- filter(iris, Species=='virginica')

seto_s <- seto %>% 
    ggplot(aes(Sepal.Length,Sepal.Width,col=Species)) +
    geom_point()
seto_p <- seto %>% 
    ggplot(aes(Petal.Length,Petal.Width,col=Species)) +
    geom_point()
vers_s <- vers %>% 
    ggplot(aes(Sepal.Length,Sepal.Width,col=Species)) +
    geom_point()
vers_p <- vers %>% 
    ggplot(aes(Petal.Length,Petal.Width,col=Species)) +
    geom_point()
virg_s <- virg %>% 
    ggplot(aes(Sepal.Length,Sepal.Width,col=Species)) +
    geom_point()
virg_p <- virg %>% 
    ggplot(aes(Petal.Length,Petal.Width,col=Species)) +
    geom_point()

grid.arrange(seto_s,seto_p,vers_s,vers_p,
             virg_s,virg_p,ncol=2)

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

# 정답 barplot + legend
seto_mean <- apply(iris[iris$Species=='setosa',1:4],2,mean)
vers_mean <- apply(iris[iris$Species=='versicolor',1:4],2,mean)
virg_mean <- apply(iris[iris$Species=='virginica',1:4],2,mean)
mean_of_iris <- rbind(seto_mean, vers_mean, virg_mean)
mean_of_iris

barplot(mean_of_iris, beside=T,
        main='품종별 평균', ylim=c(0,8), col=c('red','green','blue'))
legend('topright',
       legend=c('Setosa','Versicolor','Virginica'),
       fill=c('red','green','blue'),
       cex=0.5)
################################################################
df <- iris %>% 
    group_by(Species) %>% 
    summarise(sepal_length=mean(Sepal.Length), sepal_width=mean(Sepal.Width),
              petal_length=mean(Petal.Length), petal_width=mean(Petal.Width))
df
df_tidy <- gather(df, key='Feature', value='Value', -Species)
df_tidy
ggplot(df_tidy, aes(x=Feature, y=Value, fill=Species)) +
    geom_bar(stat='identity',position='dodge') +
    coord_flip() 
### 3) 박스 플롯 그리기
par(mfrow=c(3,1))   # mfrow=c( , ) = 3행 1열의 그래프
boxplot(seto$Sepal.Length, seto$Sepal.Width,
        seto$Petal.Length, seto$Petal.Width,
        col=c('red','yellow','green','blue'),
        par(mfrow=c(1,1))
# ggplot
seto_tidy <- gather(seto, key='Feature', value='Value', -Species)
head(seto_tidy)
s1 <- seto_tidy %>% 
    ggplot(aes(x=Feature,y=Value)) +
    s1 <- ggplot(seto_tidy, aes(x=Feature,y=Value,col=Feature)) +
    geom_boxplot() +
    ggtitle('Setosa')
s1

vers_tidy <- gather(vers, key='Feature', value='Value', -Species)
virg_tidy <- gather(virg, key='Feature', value='Value', -Species)
s2 <- vers_tidy %>% 
    ggplot(aes(x=Feature,y=Value)) +
    s2 <- ggplot(vers_tidy, aes(x=Feature,y=Value,col=Feature)) +
    geom_boxplot() +
    ggtitle('Versicolor')
s3 <- virg_tidy %>% 
    ggplot(aes(x=Feature,y=Value)) +
    s3 <- ggplot(virg_tidy, aes(x=Feature,y=Value,col=Feature)) +
    geom_boxplot() +
    ggtitle('Virginica')
grid.arrange(s1,s2,s3, ncol=1)