# TUTORIAL: http://machinelearningmastery.com/compare-the-performance-of-machine-learning-algorithms-in-r/


library (randomForest)
library (randomForestSRC)
library (rfUtilities)
library (caret)
library(mlbench)
library(pROC)

# Parallel Computing
library("doSNOW")
registerDoSNOW(makeCluster(10, type="SOCK"))

metric <- "ROC"

check <- read.csv (file = "../Training_data", sep = ",")
check1 <- check[,2:10210]
#data(check)

# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3, classProbs = TRUE, summaryFunction = twoClassSummary)
# CART
set.seed(7)
fit.cart <- train(Factor ~., data=check1, method="rpart", trControl=control, metric=metric)
save (fit.cart, file = "fit.cart.Rdata")
# LDA
#set.seed(7)
#fit.lda <- train(Factor ~., data=check1, method="lda", trControl=control, metric=metric)
#save (fit.lda, file = "fit.lda.Rdata")
# SVM
set.seed(7)
fit.svm <- train(Factor ~., data=check1, method="svmRadial", trControl=control, metric=metric)
save (fit.svm, file = "fit.svm.Rdata")
# kNN
set.seed(7)
fit.knn <- train(Factor ~., data=check1, method="knn", trControl=control, metric=metric)
save (fit.knn, file = "fit.knn.Rdata")
# Random Forest
set.seed(7)
fit.rf <- train(Factor ~., data=check1, method="rf", trControl=control, metric=metric)
save (fit.rf, file = "fit.rf.Rdata")
# collect resamples
#results <- resamples(list(CART=fit.cart, LDA=fit.lda, SVM=fit.svm, KNN=fit.knn, RF=fit.rf))
results <- resamples(list(CART=fit.cart, SVM=fit.svm, KNN=fit.knn, RF=fit.rf))



# summarize differences between modes
summary(results)

# save results
save (results, file = "comparitive_results.Rdata")

# box and whisker plots to compare models
scales <- list(x=list(relation="free"), y=list(relation="free"))

png ('boxplot.png')
bwplot(results, scales=scales)
dev.off ()

# density plots of accuracy
scales <- list(x=list(relation="free"), y=list(relation="free"))
png ('densityplot.png')
densityplot(results, scales=scales, pch = "|")
dev.off ()


# dot plots of accuracy
scales <- list(x=list(relation="free"), y=list(relation="free"))
dotplot(results, scales=scales)
png ('dotplot.png')
dotplot(results, scales=scales)
dev.off ()

# pair-wise scatterplots of predictions to compare models
png ('pairwisescatterplot.png')
splom(results)
dev.off ()


# xyplot plots to compare models
#png ('LDA_SVM.png')
#xyplot(results, models=c("LDA", "SVM"))
#dev.off ()

# xyplot plots to compare models
png ('RF_SVM.png')
xyplot(results, models=c("SVM", "RF"))
dev.off ()

# xyplot plots to compare models
png ('KNN_SVM.png')
xyplot(results, models=c("KNN", "RF"))
dev.off ()

# xyplot plots to compare models
png ('CART_SVM.png')
xyplot(results, models=c("CART", "RF"))
dev.off ()

# difference in model predictions
diffs <- diff(results)
# summarize p-values for pair-wise comparisons
summary(diffs)

