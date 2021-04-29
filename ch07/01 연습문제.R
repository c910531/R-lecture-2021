x = c(10.0, 12.0, 9.5, 22.2, 8.0)
y = c(360.2, 420.0, 359.5, 679.0, 315.3)
m <- lm(y ~ x)
summary(m)
plot(x, y)
abline(m, col='blue')

coef(m)
fitted(m)
residuals(m)
deviance(m) / length(x)



deviance(m)
deviance(m) / length(y)


newx <- data.frame((X=c(10.5,25.0,15.0)))
newy <- predict(model, newdata=newX)
newy

plot(newx$x, newy, pch=2)
abline(m, col='red')
