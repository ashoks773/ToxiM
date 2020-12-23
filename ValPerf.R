# The best model constructed using 10 per of the data, mtry = 88, and ntree = 1000
library (randomForest)
library (caret)
library (ROCR)
library (pROC)

set.seed(7)
#1.----------------------------------------------------------------------- Estate ---------------------------------------------------------------------------------------#

#Load dataset with 5% important variables only

#train1 <- read.csv (file = "Training_top10per", sep = ",")
#x = train1[,2:1021]
#y = train1[,1022]

# print("RF performance at mtry = 88")
# rf_mtry88 <- randomForest (y ~., data = x, mtry = 88, ntree = 1000, do.trace = 200, na.action = na.fail, importance = TRUE, cv.fold = 10)
# save (rf_mtry88, file = "rf_mtry88.Rdata")

load ("rf_mtry88.Rdata")
print ("rfmtry88ntree1k_confusion")
rf_mtry88$confusion

print ("rfmtry88ntree1k_Importance")
imp = importance (rf_mtry88, type =1)
write.table (imp, file = "rfmtry88ntree1k_Importance", sep = "\t")

png ("rfmtry88ntree1k.png")
varImpPlot(rf_mtry88,type=1)
dev.off ()


#------------------------ Blind set ------------------------------#
accuracies <-c()
data <- read.csv (file = "Test_data_10per", sep = ",")
fac = data$Factor
test = data[,2:1021]

#test_AA <- read.csv (file = "Valid_AA", sep = "\t")
#load ("AA.rf.Rdata")
print("prediction of classes in blindset model constructed using top 10per fp")
prediction = predict(rf_mtry88, test, type="prob")
table(prediction)
write.table (prediction, file = "Blind_pred", sep = "\t")


#----------------------- Confusion matrix-----------------------------
print ("Confusion matrix on validation set")
final_predictions <- predict(rf_mtry88, data[,2:1021])
confusionMatrix(final_predictions, data$Factor)


#-------------------For ROC -----------------------------------------

predictions <- read.csv (file = "Blind_pred", sep = "\t")
print ("Area under the curve using top 10per fp model at BLind Set")
auc(data$Factor, predictions$T)

OOB.pred <- predictions[,2]

pred.obj <- prediction (OOB.pred,fac)

RP.perf <- performance(pred.obj, "rec","prec")
png ("valid_preform")
plot (RP.perf, lwd = "3") #col="red",
dev.off ()

#ROC.perf <- performance(pred.obj, "tpr","fpr")
#png ("valid_preform1")
#plot (ROC.perf, lwd= "3") #col="red", 
#dev.off ()

ROC.perf <- performance(pred.obj, "tpr","fpr")
png ("Fingerprintvalid_preform1_New.png", res = 600, units ="in", height =10, width =10)
plot (ROC.perf, lwd= "3") #col="red", 
legend("center", bty="n", legend=paste("AUC :", format(auc(data$Factor, predictions$T), digits=4)))
dev.off ()
