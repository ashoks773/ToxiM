#http://blog.yhat.com/posts/comparing-random-forests-in-python-and-r.html
library(randomForest)
library(miscTools)
library(ggplot2)
#set the random seed
set.seed(415)

#import datasets from working directory
train <- read.csv("caco_train_top49", sep=',')
train1 <-train[2:51]
test <- read.csv("caco_test_top49", sep=',')
test1 <- test[2:50]
y <-test[,51]

#####RANDOM FOREST STARTS HERE#########

#fit and predict casual
fit <- randomForest(logPapp ~ HeavyAtomMolWt+MaxAbsEStateIndex+MaxEStateIndex+ExactMolWt+MolWt+NumValenceElectrons+MinEStateIndex+BertzCT+Chi0+Chi0n+Chi0v+Chi1+Chi1n+Chi1v+Chi2n+Chi2v+HallKierAlpha+Kappa1+Kappa2+Kappa3+LabuteASA+PEOE_VSA1+PEOE_VSA11+PEOE_VSA12+PEOE_VSA2+PEOE_VSA8+SMR_VSA1+SMR_VSA6+SlogP_VSA2+SlogP_VSA3+TPSA+EState_VSA1+EState_VSA10+VSA_EState9+FractionCSP3+HeavyAtomCount+NHOHCount+NOCount+NumAliphaticHeterocycles+NumHAcceptors+NumHDonors+NumHeteroatoms+NumRotatableBonds+NumSaturatedHeterocycles+MolLogP+MolMR+fr_Al_COO+fr_NH1+fr_unbrch_alkane, data=train1, ntree=1000, mtry=7, importance=TRUE)

rf.pred2 <- predict(fit, test1)
rf.eval<-data.frame(obs=y, pred=rf.pred2)
write.table (rf.eval, file = "eval_table", sep = "\t")
correlation_accuracy <- cor(rf.eval)
write.table (correlation_accuracy, file = "CoAcc", sep = "\t")
r2 <- rSquared(y, y - rf.pred2 )
write.table (r2, file = "rSquared", sep = "\t")
plot(y, rf.pred2, ylim=c(-7,-3), xlim=c(-7,-3), main="Observed and RF predicted permeability", xlab = "Obs value", ylab = "RF Predicted")
abline(0,1, col="red")
legend("topleft", bty="n", text.col= "red", legend=paste("R^2 :", format(r2, digits=3)))
