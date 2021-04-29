# 단순 선형 회귀의 적용
# Cars 데이터
str(cars)
plot(cars)

car_model <- lm(dist~speed,data=cars)
coef(car_model)

# 회기식 : dist = 3.9324 * speed - 17.5791

abline(car_model, col='red')
summary(car_model)
par(mfrow=c(2,2))
plot(car_model)

# 속도 21.5, 제동거리는 ?
car_model <- lm(dist~speed,data=cars)
coef(car_model)

nx1=data.frame(speed=c(21.5))
predict(car_model,nx1)

# 고차 다항식 적용
lm2 <- lm(dist~poly(speed,2),data=cars)
plot(cars)
x <- seq(0,25,length.out=200) # length.out -> 몇개로 나눌거냐
y <-  predict(lm2, data.frame(speed=x))
lines(x, y, col='blue')
abline(car_model, col='red', lwd=2) # lwd=n -> 선의 두께 조정

summary(lm2)

# cars 1차식부터 4차식까지
x <- seq(0,25,length.out=200)
colors <- c('red','purple','darkorange','blue')
plot(cars)
for(i in 1:4) {
    m <- lm(dist~poly(speed, i), data=cars)
    assign(paste('m',i,sep='.'),m)
    y <-  predict(m, data.frame(speed=x))
    lines(x,y,col=colors[i], lwd=2)
}

# 분산 분석(anova)
anova(m.1, m.2, m.3, m.4)

# women data
women
plot(women)
m <- lm(weight~height, data=women)
abline(m, col='red', lwd=2)
summary(m)

# 2차식으로 모델링
m2 <- lm(weight ~ poly(height, 2), data=women)
x <- seq(58,72, length.out=300)
y <- predict(m2, data.frame(height=x))
lines(x, y, col='blue', lwd=2)
summary(m2)
