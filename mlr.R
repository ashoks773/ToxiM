library(MASS)
library(DAAG)
library(bootstrap)
library(leaps)
library(car)
library (ggplot2)
library(caret)

# Parallel Computing
# library("doSNOW")
# registerDoSNOW(makeCluster(10+ type="SOCK"))
# 
# metric <- "ROC"

check <- read.csv (file = "caco_train_top11", header=TRUE, sep = ",")
# check1 <- as.numeric (as.character(check$Factor))
check1 <- check[2:13]
# Multiple Linear Regression Example 
fit <- lm(formula= logPapp ~ PEOE_VSA1+NumHDonors+NHOHCount+TPSA+MolLogP+PEOE_VSA11+NumRotatableBonds+BertzCT+fr_NH1+NOCount+MolWt, data= check1, validation = "LOO")
 # show results
fit
summary(fit)
check2 <- read.csv (file = "caco_test_top11", header=TRUE, sep = ",")
train2 <- check2[2:13]
y <- check2[,13]
pls.pred2 <-predict (fit, train2)
pls.eval<-data.frame(obs=y, pred=pls.pred2)
write.table (pls.eval, file = "eval_table", sep = "\t")
correlation_accuracy <- cor(pls.eval)
r2<-defaultSummary(pls.eval)
write.table (correlation_accuracy, file = "CoAcc", sep = "\t")
plot(y, pls.pred2, ylim=c(-7,-3), xlim=c(-7,-3), main="Observed and MLR predicted LogS", xlab = "exp value", ylab = "MLR Predicted")
abline(0,1, col="red")
#r2 <- Rsquared(y, y - rf.pred2 )
legend("topleft", bty="n", text.col= "red", legend=paste("R^2 :", format(r2[2], digits=3)))
