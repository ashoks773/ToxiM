#setwd("/home/ankita/WORK/TOXIN_Project25july16/Analysis_ToxiPred/Descriptors/Final_Analysis/mean")
set.seed (1220104)

library(foreach)
library(doSNOW)
library(randomForest)
library (caret)
library (pROC)

# Setting number of cores in your machine. In this case, it is 2
registerDoSNOW(makeCluster(10, type="SOCK"))

# Loading data
train <- read.csv (file = "desc_train", sep = ",")

train1 <- train[,2:193]
x = train[,2:192]
y = train[,193]

# Optimal mtry
mtry <- tuneRF(x, y, 14, stepFactor=0.5, improve=1e-5, ntree=100)
print(mtry)
best.m <- mtry[mtry[, 2] == min(mtry[, 2]), 1]

# Main Random Forest Code. Run 250 trees on 2 cores parallely and then combine them
rf <- foreach(ntree = rep(100, 5), .combine = combine, .packages = "randomForest") %dopar% randomForest(y~.,data=x,ntree=ntree, mtry=best.m, importance=TRUE)

# Check rf object
rf

# Save rf moldel
save (rf, file = "rf.Rdata")

# Check variable importance
imp = importance(rf, type=1)
write.table (imp, file = "MeanAcc", sep = "\t")

imp1 = importance(rf, type=2)
write.table (imp1, file = "Gini", sep = "\t")

png ('meandecreaseAcc.png')
varImpPlot(rf, type=1)
dev.off ()

png ('Gini.png')
varImpPlot(rf, type=2)
dev.off ()
