# 1. ucla 데이터
# -4가지 모델(dt, rf, svm, knn)
# 예측 / 평가
library(rpart)
library(rpart.plot)
library(ggplot2)
library(randomForest)
library(caret)
library(e1071)
library(class)
ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit <- factor(ucla$admit)
set.seed(2021)
train_index <- createDataPartition(ucla$admit,p=0.8,list=F)
ucla_train <- ucla[train_index,]
ucla_test <- ucla[-train_index,]


## df 모델
dt=rpart(admit~., data=ucla)
par(mfrow=c(1,1), xpd=NA)
plot(dt)
text(dt, use.n=TRUE)

## 예측
pred <- predict(dt, ucla, type='class')
table(pred, ucla$admit)

## 평가
confusionMatrix(pred,ucla$admit)

## 시각화
rpart.plot(dt, type=4)

## 비율대로 훈련/테스트 데이터셋 만들기
train_index <- createDataPartition(ucla$admit, p=0.8, list=F)
ucla_train <- ucla[train_index,]
ucla_test <- ucla[-train_index,]
table(ucla_train$admit)
table(ucla_test$admit)

## 학습
dt <- rpart(admit~.,ucla_train)

## 예측
pred <- predict(dt, ucla_test, type='class')

## 평가
confusionMatrix(pred, ucla_test$admit)

## 시각화
rpart.plot(dt)

# 랜덤 포레스트
rf <- randomForest(admit~., data=ucla)
print(rf)
set.seed(2021)
train_index <- createDataPartition(ucla$admit,p=0.8,list=F)
ucla_train <- ucla[train_index,]
ucla_test <- ucla[-train_index,]

## 모델링
rf <- randomForest(admit~., ucla_train)

## 예측
pred <- predict(rf, ucla_test, type='class')

## 평가
confusionMatrix(pred, ucla_test$admit)

## 시각화
plot(rf)

## 하이퍼 파라메터
small_forest <- randomForest(admit~.,ucla_train,
                             ntree=100, nodesize=4)
s_pred <- predict(small_forest, ucla_test, type='class')
confusionMatrix(s_pred,ucla_test$admit)
plot(small_forest)

# svm
set.seed(2021)
train_index <- createDataPartition(ucla$admit,p=0.8,list=F)
ucla_train <- ucla[train_index,]
ucla_test <- ucla[-train_index,]

## 모델링
svc <- svm(admit~.,ucla_train)

## 예측
pred <- predict(svc, ucla_test, type='class')

## 평가
confusionMatrix(pred, ucla_test$admit)
table(pred, ucla_test$admit)

## 하이퍼 파라미터 C
svc100 <- svm(admit~., ucla_train, cost=100)
pred100 <- predict(svc100, ucla_test, type='class')
table(pred100, ucla_test$admit)

svc001 <- svm(admit~., ucla_train, cost=0.01)
pred001 <- predict(svc001, ucla_test, type='class')
table(pred001, ucla_test$admit)

## 모델을 훈련했을 때의 데이터로 예측
self100 <- predict(svc100, ucla_train, type='class')
table(self100, ucla_train$admit)
self001 <- predict(svc001, ucla_train, type='class')
table(self001, ucla_train$admit)

# KNN
k <- knn(ucla_train[,1:2], ucla_test[,1:2],
         ucla_train$admit,k=5)
k
ucla_test$admit
confusionMatrix(k, ucla_test$admit)


# 2. wine
wine <- read.table('data/wine.data.txt', sep=',')
columns <- readLines('data/wine.name.txt')


# wine data의 column명
names(wine)[1] <- "class"
names(wine)[2:14] <- columns
names(wine)[2:14] <- substr(columns, 4, nchar(columns))
names(wine)
wine$class = factor(wine$class)

str(wine)

# dt 모델
dt=rpart(class~., data=wine)
par(mfrow=c(1,1), xpd=NA)
plot(dt)
text(dt, use.n=TRUE)

## 예측
pred <- predict(dt, wine, type='class')
table(pred, wine$class)

## 평가
confusionMatrix(pred,wine$class)

## 시각화
rpart.plot(dt, type=1)

## 비율대로 훈련/테스트 데이터셋 만들기
set.seed(2021)
train_index <- createDataPartition(wine$class, p=0.8, list=F)
wine_train <- wine[train_index,]
wine_test <- wine[-train_index,]
table(wine_train$class)
table(wine_test$class)

## 학습
dt <- rpart(class~.,wine_train)

## 예측
pred <- predict(dt, wine_test, type='class')

## 평가
confusionMatrix(pred, wine_test$class)

## 시각화
rpart.plot(dt)

# 랜덤 포레스트
set.seed(2021)
train_index <- createDataPartition(wine$class, p=0.8, list=F)
wine_train <- wine[train_index,]
wine_test <- wine[-train_index,]

## 모델링
rf <- randomForest(class~., wine_train)
rf

## 예측
pred <- predict(rf, wine_test, type='class')

## 평가
confusionMatrix(pred, wine_test$class)

## 시각화
plot(rf)

## 하이퍼 파라메터
small_forest <- randomForest(class~.,wine_train,
                             ntree=100, nodesize=4)
s_pred <- predict(small_forest, wine_test, type='class')
confusionMatrix(s_pred,wine_test$class)
plot(small_forest)

# svm
set.seed(2021)
train_index <- createDataPartition(wine$class,p=0.8,list=F)
wine_train <- wine[train_index,]
wine_test <- wine[-train_index,]

## 모델링
svc <- svm(class~.,wine_train)

## 예측
pred <- predict(svc, wine_test, type='class')

## 평가
confusionMatrix(pred, wine_test$class)
table(pred, wine_test$class)

## 하이퍼 파라미터 C
svc100 <- svm(class~., wine_train, cost=100)
pred100 <- predict(svc100, wine_test, type='class')
table(pred100, wine_test$class)

svc001 <- svm(class~., wine_train, cost=0.01)
pred001 <- predict(svc001, wine_test, type='class')
table(pred001, wine_test$class)

## 모델을 훈련했을 때의 데이터로 예측
self100 <- predict(svc100, wine_train, type='class')
table(self100, wine_train$class)
self001 <- predict(svc001, wine_train, type='class')
table(self001, wine_train$class)

# KNN
k <- knn(wine_train[,1:3], wine_test[,1:3],
         wine_train$class,k=5)
k
wine_test$class
confusionMatrix(k, wine_test$class)
