#setwd("/home/ashoks/WORK/TOXIN_Project06july16/Analysis_ToxiPred/FingerPrints/Opt_training")
set.seed (1220104)

library(foreach)
library(doSNOW)
library(randomForest)
library (caret)
library (pROC)

# Setting number of cores in your machine. In this case, it is 2
registerDoSNOW(makeCluster(10, type="SOCK"))

# Loading data
train <- read.csv (file = "new_Training_top20", sep = ",")
train1 <- train[,2:22]
x = train[,2:21]
y = train[,22]

# Optimal mtry
mtry <- tuneRF(x, y, 4, stepFactor=0.5, improve=1e-5, ntree=100, na.action =na.omit)
print(mtry)
best.m <- mtry[mtry[, 2] == min(mtry[, 2]), 1]
