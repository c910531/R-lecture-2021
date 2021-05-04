library(caret)
library(rpart)
library(randomForest)

ucla <- read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit <- factor(ucla$admit)
set.seed(2021)

# 1) 4가지 모델
control <- trainControl(method='cv', number=5)
dt <- train(admit~., data=ucla, method='rpart',
            metric='Accuracy', trControl=control)
rf <- train(admit~., data=ucla, method='rf',
            metric='Accuracy', trControl=control)
sv <- train(admit~., data=ucla, method='svmRadial',
            metric='Accuracy', trControl=control)
kn <- train(admit~., data=ucla, method='knn',
            metric='Accuracy', trControl=control)

resamp <- resamples(list(결정트리=dt, 랜덤포레스트=rf,
                             SVM=sv, KNN=kn))
summary(resamp)
# 2) cv = 5
control <- trainControl(method='cv', number=5)
new_rf <- train(admit~., data=ucla, method='rf',
                metric='Accuracy', trControl=control)
confusionMatrix(new_rf)

# 3) 정확도, 정밀도, 재현율
r = rpart(admit~., data=ucla)
rf = randomForest(admit~., data=ucla, ntree= 3)
r_pred = predict(r, ucla, type='class')
confusionMatrix(r_pred, ucla$admit)
f_pred=predict(rf,ucla)
confusionMatrix(f_pred, ucla$admit)
