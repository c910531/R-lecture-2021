# Anscombe's quartet
head(anscombe)

# 평균
apply(anscombe, 2, mean)
# 분산
apply(anscombe, 2, var)

# 상관관계
cor(anscombe$x1, anscombe$y1)
cor(anscombe$x2, anscombe$y2)


### for 반복 구문을 이용한 반복 출력
for (i in 1:4) {
    print(cor(anscombe[,i], anscombe[,i+4]))
}

# 요약
summary(anscombe)

# 그래프 그리기
library(ggplot2)

ggplot(anscombe) +
    geom_point(aes(x4,y4),color='darkorange',size=3) +
    # scale_x_continuous(breaks=seq(2,20,2)) +
    # scale_y_continuous(breaks=seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(slope = 0.5, intercept = 3,
                color='cornflowerblue',size=1) +
    labs(title = 'Dataset 1')

# gridExtra (그래프 하나씩을 변수명으로 지정 후 한번에 출력)

p1 <- ggplot(anscombe) +
    geom_point(aes(x1,y1),color='darkorange',size=3) +
    # scale_x_continuous(breaks=seq(2,20,2)) +
    # scale_y_continuous(breaks=seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(slope = 0.5, intercept = 3,
                color='cornflowerblue',size=1) +
    labs(title = 'Dataset 1')
p1

p2 <- ggplot(anscombe) +
    geom_point(aes(x2,y2),color='darkorange',size=3) +
    # scale_x_continuous(breaks=seq(2,20,2)) +
    # scale_y_continuous(breaks=seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(slope = 0.5, intercept = 3,
                color='cornflowerblue',size=1) +
    labs(title = 'Dataset 2')
p2

p3 <- ggplot(anscombe) +
    geom_point(aes(x3,y3),color='darkorange',size=3) +
    # scale_x_continuous(breaks=seq(2,20,2)) +
    # scale_y_continuous(breaks=seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(slope = 0.5, intercept = 3,
                color='cornflowerblue',size=1) +
    labs(title = 'Dataset 3')
p3

p4 <- ggplot(anscombe) +
    geom_point(aes(x4,y4),color='darkorange',size=3) +
    # scale_x_continuous(breaks=seq(2,20,2)) +
    # scale_y_continuous(breaks=seq(2,14,2)) +
    xlim(2,20) +
    ylim(2,14) +
    geom_abline(slope = 0.5, intercept = 3,
                color='cornflowerblue',size=1) +
    labs(title = 'Dataset 4')

p4

library(gridExtra)
grid.arrange(p1,p2,p3,p4, ncol=2, top="Anscombe's Quartet")

figures <- list()
figures <- append(figures, p1)
figures <- append(figures, p2)
figures <- append(figures, p3)
figures <- append(figures, p4)
figures[1]

for (i in 1:4) {
    
}

############################################################

# Source Refactoring
x <-ggplot(anscombe) +
    geom_point(aes(x4,y4),color='darkorange',size=3)
x
assign(paste('m',4,sep='.'), x)
grid.arrange(p1,p2,p3,p4, ncol=2, top="Anscombe's Quartet")

library(dplyr)
for (i in 1:4) {
    x_data <- anscombe[,i]
    y_data <- anscombe[,4+i]
    x <-ggplot(anscombe) +
        geom_point(aes(x_data, y_data),
                   color='darkorange',size=3) +
        # scale_x_continuous(breaks=seq(2,20,2)) +
        # scale_y_continuous(breaks=seq(2,14,2)) +
        xlim(2,20) +
        ylim(2,14) +
        geom_abline(slope = 0.5, intercept = 3,
                    color='cornflowerblue',size=1) +
        labs(title = paste0('Dataset',i),
             x=paste0('x',i),y=paste0('y',i))
    assign(paste('m', i, sep='.'),x)
    rm(x)
}

grid.arrange(m.1,m.2,m.3,m.4, ncol=2, top="Anscombe's Quartet")
