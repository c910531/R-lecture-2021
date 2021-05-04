# 분류(Classification)
# 결정 트리(Decision Tree)
library(rpart)
head(iris)

dtc <- rpart(Species ~., iris)  # iris 데이터를 결정 트리로 학습
summary(dtc)
dtc

# 결정트리 시각화
par(mfrow=c(1,1), xpd=NA)
plot(dtc)
text(dtc, use.n=T)

# 예측
pred <- predict(dtc, iris, type='class')
table(pred, iris$Species)

# 평가
library(caret)  # install.packages('caret') 설치 후 불러오기
confusionMatrix(pred,iris$Species)

# 시각화
library(rpart.plot)
ibrary(ggplot2)
rpart.plot(dtc)
rpart.plot(dtc, type=4)

# 훈련 / 테스트 셋으로 분리하여 시행
set.seed(2021)
iris_index <- sample(1:nrow(iris), 0.8*nrow(iris))
iris_train <- iris[iris_index, ]
iris_test <- iris[setdiff(1:nrow(iris), iris_index),]
iris_test <- iris[-iris_index,] # 윗 지정 식과 동일한 결과값 출
dim(iris_train)
dim(iris_test)
table(iris_train$Species)
table(iris_test$Species)

# 모델링
dtc <- rpart(Species~.,iris_train)

# 예측
pred <- predict(dtc, iris_test, type='class')

# 평가
confusionMatrix(pred, iris_test$Species)

# 비율대로 훈련/테스트 데이터셋 만들기
train_index <- createDataPartition(iris$Species, p=0.8, list=F)
iris_train <- iris[train_index,]
iris_test <- iris[-train_index,]
table(iris_train$Species)
table(iris_test$Species)

# 학습
dtc <- rpart(Species~., iris_train)

# 예측
pred <- predict(dtc, iris_test, type='class')

# 평가
confusionMatrix(pred, iris_test$Species)

# 시각화
rpart.plot(dtc)
