# 1. colon 데이터에 랜덤 포트리스를 적용하는데, k-겹 교차 검증을 k를 5,10,15,20으로 바꾸면서 적용하라
# 각각의 혼동 행렬과 정확률을 제시하라.

library(caret)
library(rpart)
library(randomForest)
library(e1071)
library(class)
clean_colon=na.omit(colon)
clean_colon = clean_colon[c(TRUE, FALSE),]
clean_colon$status=factor(clean_colon$status)

## k = 5
control = trainControl(method='cv', number = 5)
formular = status ~ rx+sex+age+obstruct+perfor+adhere+nodes+differ+
    extent+surg+node4
dt = train(formular, data = clean_colon, method = 'rpart',
           metric='Accuracy',trControl=control)
rf = train(formular, data = clean_colon, method = 'rf',
           metric='Accuracy', trControl=control)
sv = train(formular, data = clean_colon, method = 'svmRadial',
           metric='Accuracy', trControl=control)
kn = train(formular, data = clean_colon, method = 'knn',
           metric='Accuracy', trControl=control)
resamp = resamples(list(결정트리 = dt, 랜덤포트리스 = rf, SVM = sv, KNN=kn))

summary(resamp)
## 혼동행렬과 정확률
confusionMatrix(dt, colon$status)

## k = 10 
control = trainControl(method='cv', number = 10)
formular = status ~ rx+sex+age+obstruct+perfor+adhere+nodes+differ+
    extent+surg+node4
dt = train(formular, data = clean_colon, method = 'rpart',
           metric='Accuracy',trControl=control)
rf = train(formular, data = clean_colon, method = 'rf',
           metric='Accuracy', trControl=control)
sv = train(formular, data = clean_colon, method = 'svmRadial',
           metric='Accuracy', trControl=control)
kn = train(formular, data = clean_colon, method = 'knn',
           metric='Accuracy', trControl=control)
resamp = resamples(list(결정트리 = dt, 랜덤포트리스 = rf, SVM = sv, KNN=kn))

summary(resamp)

## k = 15
control = trainControl(method='cv', number = 15)
formular = status ~ rx+sex+age+obstruct+perfor+adhere+nodes+differ+
    extent+surg+node4
dt = train(formular, data = clean_colon, method = 'rpart',
           metric='Accuracy',trControl=control)
rf = train(formular, data = clean_colon, method = 'rf',
           metric='Accuracy', trControl=control)
sv = train(formular, data = clean_colon, method = 'svmRadial',
           metric='Accuracy', trControl=control)
kn = train(formular, data = clean_colon, method = 'knn',
           metric='Accuracy', trControl=control)
resamp = resamples(list(결정트리 = dt, 랜덤포트리스 = rf, SVM = sv, KNN=kn))

summary(resamp)

## k = 20
control = trainControl(method='cv', number = 20)
formular = status ~ rx+sex+age+obstruct+perfor+adhere+nodes+differ+
    extent+surg+node4
dt = train(formular, data = clean_colon, method = 'rpart',
           metric='Accuracy',trControl=control)
rf = train(formular, data = clean_colon, method = 'rf',
           metric='Accuracy', trControl=control)
sv = train(formular, data = clean_colon, method = 'svmRadial',
           metric='Accuracy', trControl=control)
kn = train(formular, data = clean_colon, method = 'knn',
           metric='Accuracy', trControl=control)
resamp = resamples(list(결정트리 = dt, 랜덤포레스트 = rf, SVM = sv, KNN=kn))

summary(resamp)
sort(resamp, decreasing = TRUE)
dotplot(resamp)

# 2. UCLA admission데이터에 대해 하이퍼매개변수 최적화하기
ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit <- factor(ucla$admit)
## 
control=trainControl(method='cv',number=5)
dt = train(admit~.,data=ucla, method='rpart', metric='Accuracy',
           trControl=control)
rf = train(admit~.,data=ucla, method='rf', metric='Accuracy',
           trControl=control)
sc = train(admit~.,data=ucla, method='svmRadial', metric='Accuracy',
           trControl=control)
kn = train(admit~.,data=ucla, method='knn', metric='Accuracy',
           trControl=control)
resamp=resamples(list(결정트리 = dt, 랜덤포레스트 = rf, SVM = sc, KNN = kn))
summary(resamp)
sort(resamp, decreasing = TRUE)
dotplot(resamp)

# 3. voice 데이터에 대해 하이퍼매개변수 최적화하기
getwd()
voice <- read.csv('data/voice.csv')
str(voice)

## 
control=trainControl(method='cv',number=5)
dt = train(label~.,data=voice, method='rpart', metric='Accuracy',
           trControl=control)
rf = train(label~.,data=voice, method='rf', metric='Accuracy',
           trControl=control)
sc = train(label~.,data=voice, method='svmRadial', metric='Accuracy',
           trControl=control)
kn = train(label~.,data=voice, method='knn', metric='Accuracy',
           trControl=control)
resamp=resamples(list(결정트리 = dt, 랜덤포레스트 = rf, SVM = sc, KNN = kn))
summary(resamp)
sort(resamp, decreasing = TRUE)
dotplot(resamp)
