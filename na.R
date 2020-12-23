#http://rstudio-pubs-static.s3.amazonaws.com/55376_55239f5c7346474f8069ef9e6c611424.html

set.seed (1220104)

library(foreach)
library(doSNOW)
library(randomForest)
library (caret)
library(rattle)
library (pROC)

# Setting number of cores in your machine. In this case, it is 2
registerDoSNOW(makeCluster(10, type="SOCK"))

# Loading data
train <- read.csv (file = "Desc_test", sep = ",", na.strings=c("na"))
id_na_Cols <- sapply(train,function(x)any(is.na(x)))
trainData <- train[,!(id_na_Cols)]
write.table (trainData, file = "new_Desc_test", sep = ",")
