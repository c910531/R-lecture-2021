# 현실 세계의 모델링

X=c(3,6,9,12.)
Y=c(3,4,5.5,6.5)
plot(x,y)

# model_1: y=0.5x + 1.0
Y1 = 0.5*x + 1
Y1

# 평균 제곱 오차 : Mean Squared Error
(Y - Y1)**2
sum((Y-Y1)**2)
mse <- sum((Y - Y1)**2) / length(Y)
mse


# model 2 : y=5/12x + 7/4
Y2 = 5 * X / 12+ 7/4
Y2
mse2 <- sum((Y-Y2)**2) / length(Y)
mse2
