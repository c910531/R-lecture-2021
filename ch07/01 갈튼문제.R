gal <- read.csv('data/Galtons Height Data.csv')
glimpse(gal)
plot(gal)
x <- gal %>% 
    filter(Gender=='M') %>% 
    mutate(cm_K=Height*2.54,cm_F=Father*2.54) %>% 
    select(cm_F,cm_K)

x_model <- lm(cm_K~cm_F,data=x)
coef(x_model)

# 회기식 : cm_F = 0.44774 * cm_K + 97.1776

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
