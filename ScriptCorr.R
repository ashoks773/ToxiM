library ("corrplot")
a <- read.csv (file = "Desc_trainTop20Wilcox", sep = ",", header = TRUE, row.names =1)
b <- ncol(a)
c <- a[,1:(b-1)]
d <- cor(c)
png ('DescCorr.png')
corrplot(d, method="pie")
dev.off ()

a1 <- read.csv (file = "Fing_trainTop20Wilcox", sep = ",", header = TRUE, row.names =1)
b1 <- ncol(a1)
c1 <- a1[,1:(b1-1)]
d1 <- cor(c1)
png ('FingCorr.png')
corrplot(d1, method="pie")
dev.off ()
