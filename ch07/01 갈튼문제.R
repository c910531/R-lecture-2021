library(ggplot2)
library(dplyr)
gal <- read.table("http://www.randomservices.org/random/data/Galton.txt", sep = "", header = T)
glimpse(gal)
plot(gal)

x <- gal %>% 
    filter(Gender=='M') %>% 
    mutate(cm_K=Height*2.54,cm_F=Father*2.54) %>% 
    select(cm_F,cm_K)

x_model <- lm(cm_K~cm_F,data=x)
coef(x_model)
mfrow(c(2,2))
plot(x_model)
### 회기식 : cm_F = 0.44774 * cm_K + 97.1776
### 확인할 수 있는 사항
### 첫번째 그래프(Residual vs Fitted plot) : 종속변수와 독립변수간에 선형성을 알아볼 수 있는 그래프이다. 모델 그래프의 기울기가 0에 가까우므로 종속변수와 독립변수 간 선형성이 있음을 알 수 있다.
### 두번째 그래프(Normal Q-Q plot) : 45도 각도의 직선 위에 각 점들이 위치하고 있음을 확인할 수 있으며, 이를 통해 본 데이터가 정규분포를 따르고 있음을 알 수 있다.
### 세 번째 그래프(Scale-Location plot) : 등분산성 확인 플롯. 점들이 랜덤한 형태로(퍼져 있어야) 등분산성을 만족. 이 데이터의 경우 점들이 퍼져 있으므로 등분산성을 만족한다.
### 네 번째 그래프(Residuals vs Leverage plot) : 이상관측치 확인 가능. 숫자가 뜨는 애들이 있으면 그것들이 이상치. 아빠와 아들 키 데이터 셋에 3개의 이상관측치가 있음을 그래프를 통하여 확인할 수 있다.

plot(x)
abline(x_model, col='red')

# ggplot

x %>% 
    ggplot(aes(cm_F,cm_K)) +
    geom_point(position="jitter") +
    geom_abline(intercept = 97.177, slope=0.447,col='red')



summary(x_model)

#### 확인할 수 있는 사항
#### 1. cm_F의 변수인 Pr(>|t|) 값은 2e-16으로 0.05보다 낮기 때문에 신뢰도 높음.
#### 2. R-squeared값은 0.15의 결과로 낮게 도출되었고, 본 모델은 부모-자식간 신장의 상관관계에 대한 설득력이 떨어짐.
#### 3. P-value값은 2.2e-16으로 0.05보다 낮기 때문에 오류 확률은 낮음.

par(mfrow=c(1,1))
x <- seq(min(x$cm_F), max(x$cm_F), length.out=1000)
colors <- c('red','purple','darkorange','blue')
for (i in 1:4) {
    plot(jitter(x$cm_F), jitter(x$cm_K),
         xlab='Father', ylab='Son')
    m <- lm(son ~ poly(cm_F, i), data=gal)
    assign(paste('m', i, sep='.'), m)
    y <- predict(m, data.frame(cm_F=x))
    lines(x, y, col=colors[i], lwd=2)
}

anova(m.1,m.2,m.3,m.4)
