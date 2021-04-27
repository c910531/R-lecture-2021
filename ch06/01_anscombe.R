# Anscombe's quartet
head(anscombe)

# 평균
apply(anscombe, 2, mean)
# 분산
apply(anscombe, 2, var)

# 상관관계
cor(anscombe$x1, anscombe$y1)
cor(anscombe$x2, anscombe$y2)

for (i in 1:4) {
    print(cor(anscombe[,i], anscombe[,i+4]))
}

# 요약
summary(anscombe)
