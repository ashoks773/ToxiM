require(gridExtra)
library(reshape2)
library(ggplot2)
a= read.csv(file="../FPTraining_top10per", sep=",", header = T, row.names = 1)
b= read.csv(file="../Desc_train_top100", sep=",", header = T, row.names = 1)

# Name,MaxAbsEStateIndex,ExactMolWt,MinEStateIndex,BalabanJ,BertzCT,Chi1n,Chi4n,HallKierAlpha,Kappa2,PEOE_VSA1,PEOE_VSA14,PEOE_VSA8,SlogP_VSA1,SlogP_VSA2,SlogP_VSA5,TPSA,EState_VSA10,EState_VSA8,EState_VSA9,MolLogP,Factor
# 239.sdf,9.3,437.9,0,0,570.9,5.1,1.3,-0.7,8.6,0,115.9,0,20.2,36.5,0,92.5,10.2,0,11.5,0.4,T
# CHEBI_57566.mol,11.6,305,-5.1,2.1,585.1,5.6,1.8,-1.3,5.6,34.5,5.7,12.6,21.2,33.5,12.6,162.8,24.3,9.5,10.5,-2.7,NT

# d1 = melt(a, id.var="Location") # To melt the complete data

# Simple box plot directly from the data 
# png("box.png")
# boxplot(x51 ~ Location, data = a, ylab="Intensity", xlab="Location")
# dev.off ()

#Box plot using first 20 variables # variables information can be changed according to their importance or all variables can be used
# b=a[,1:21]
# d1 = melt(b, id.var="Factor") # To melt the data with selected variables
# png ("Initial20.png")
# ggplot(data=d1, aes(x=variable, y=value)) + geom_boxplot(aes(fill=Factor))
# dev.off ()

#Boxplot for top 9 fingerprints on the basis of p-value obtained using wilcoxen rank t test
png("Individual9Finger.png")
plot1 <- ggplot(a, aes(x=Factor, y=MACCSFP49, group=Factor)) + geom_boxplot(aes(fill=Factor))
plot2 <- ggplot(a, aes(x=Factor, y=SubFP296, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot3 <- ggplot(a, aes(x=Factor, y=SubFPC296, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot4 <- ggplot(a, aes(x=Factor, y=KRFP1147, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot5 <- ggplot(a, aes(x=Factor, y=SubFPC297, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot6 <- ggplot(a, aes(x=Factor, y=SubFPC299, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot7 <- ggplot(a, aes(x=Factor, y=SubFP297, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot8 <- ggplot(a, aes(x=Factor, y=SubFP299, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot9 <- ggplot(a, aes(x=Factor, y=SubFPC14, group=Factor)) + geom_boxplot(aes(fill=Factor))
# plot10 <- ggplot(a, aes(x=Factor, y=a[10], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot11 <- ggplot(a, aes(x=Factor, y=a[11], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot12 <- ggplot(a, aes(x=Factor, y=a[12], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot13 <- ggplot(a, aes(x=Factor, y=a[13], group=Factor)) + geom_boxplot(aes(fill=Factor))
# plot14 <- ggplot(a, aes(x=Factor, y=a[14], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot15 <- ggplot(a, aes(x=Factor, y=a[15], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot16 <- ggplot(a, aes(x=Factor, y=a[16], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot17 <- ggplot(a, aes(x=Factor, y=a[17], group=Factor)) + geom_boxplot(aes(fill=Factor))
# plot18 <- ggplot(a, aes(x=Factor, y=a[18], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot19 <- ggplot(a, aes(x=Factor, y=a[19], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot20 <- ggplot(a, aes(x=Factor, y=a[20], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
grid.arrange(plot1,plot2,plot3,plot4,plot5,plot6,plot7,plot8,plot9, ncol=3, nrow=3)
dev.off ()

#Boxplot for top 9 Discriptors on the basis of p-value obtained using wilcoxen rank t test
png("Individual9discriptor.png")
plot11 <- ggplot(b, aes(x=Factor, y=NHOHCount, group=Factor)) + geom_boxplot(aes(fill=Factor))
plot21 <- ggplot(b, aes(x=Factor, y=PEOE_VSA1, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot31 <- ggplot(b, aes(x=Factor, y=NumAromaticCarbocycles, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot41 <- ggplot(b, aes(x=Factor, y=fr_benzene, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot51 <- ggplot(b, aes(x=Factor, y=TPSA, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot61 <- ggplot(b, aes(x=Factor, y=NumHDonors, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot71 <- ggplot(b, aes(x=Factor, y=MolLogP, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot81 <- ggplot(b, aes(x=Factor, y=fr_phos_acid, group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
plot91 <- ggplot(b, aes(x=Factor, y=fr_phos_ester, group=Factor)) + geom_boxplot(aes(fill=Factor))
# plot10 <- ggplot(a, aes(x=Factor, y=a[10], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot11 <- ggplot(a, aes(x=Factor, y=a[11], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot12 <- ggplot(a, aes(x=Factor, y=a[12], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot13 <- ggplot(a, aes(x=Factor, y=a[13], group=Factor)) + geom_boxplot(aes(fill=Factor))
# plot14 <- ggplot(a, aes(x=Factor, y=a[14], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot15 <- ggplot(a, aes(x=Factor, y=a[15], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot16 <- ggplot(a, aes(x=Factor, y=a[16], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot17 <- ggplot(a, aes(x=Factor, y=a[17], group=Factor)) + geom_boxplot(aes(fill=Factor))
# plot18 <- ggplot(a, aes(x=Factor, y=a[18], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot19 <- ggplot(a, aes(x=Factor, y=a[19], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
# plot20 <- ggplot(a, aes(x=Factor, y=a[20], group=Factor), add=TRUE) + geom_boxplot(aes(fill=Factor))
grid.arrange(plot11,plot21,plot31,plot41,plot51,plot61,plot71,plot81,plot91, ncol=3, nrow=3)
dev.off ()

# # plot( x, y1, type="l", col="red" )
# # par(new=TRUE)
# # plot( x, y2, type="l", col="green" )
# # ggplot(a, aes(x=Factor, y=x1, group=Factor)) + geom_boxplot(aes(fill=Factor))
# # boxplot()