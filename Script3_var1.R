# This script will run after the script1, Here the mtry value range will be used accoding to the script1 results

#setwd("/home/ashoks/WORK/TOXIN_Project06july16/Analysis_ToxiPred/FingerPrints/Opt_training")

library (randomForest)
library (randomForestSRC)
library (rfUtilities)
library (caret)
library(mlbench)

#Load dataset with 0.5% important variables only
train1 <- read.csv (file = "Training_top0.5per", sep = ",")
x = train1[,2:52]
y = train1[,53]

metric <- "ROC"
mtry <- sqrt(ncol(x))

# Extend Caret
customRF <- list(type = "Classification", library = "randomForest", loop = NULL)
customRF$parameters <- data.frame(parameter = c("mtry", "ntree"), class = rep("numeric", 2), label = c("mtry", "ntree"))
customRF$grid <- function(x, y, len = NULL, search = "grid") {}
customRF$fit <- function(x, y, wts, param, lev, last, weights, classProbs, ...) {
  randomForest(x, y, mtry = param$mtry, ntree=param$ntree, ...)
}
customRF$predict <- function(modelFit, newdata, preProc = NULL, submodels = NULL)
   predict(modelFit, newdata)
customRF$prob <- function(modelFit, newdata, preProc = NULL, submodels = NULL)
   predict(modelFit, newdata, type = "prob")
customRF$sort <- function(x) x[order(x[,1]),]
customRF$levels <- function(x) x$classes

# train model on 0.5% imp data
control <- trainControl(method="repeatedcv", number=10, repeats=3, classProbs = TRUE, summaryFunction = twoClassSummary)
tunegrid <- expand.grid(.mtry=c(3, 5, 7, 9, 11, 14), .ntree=c(100:1000))
custom1 <- train(y~., data=x, method=customRF, metric=metric, tuneGrid=tunegrid, trControl=control)
summary(custom1)
print(custom1)
png ('Optimized_imp0.5.png')
plot(custom1)
dev.off ()
