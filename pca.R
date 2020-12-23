#setwd("/home/ashoks/WORK/AS_XenoMeta_2015/CompleteAnalysis15/EC6AnaUsingDescriptors_Fingerprints/CompleteAna_SimilaritySearch/First_Level_Results/hybrid_222")
data <- read.csv (file = "../Training_data", sep = ",")
pred <- data[,2:10209]
fac <- data[, 10210]

# If someof the variable having zero variance
pred1 <- pred[,sapply(pred, function(v) var(v, na.rm=TRUE)!=0)]

data.pca <- prcomp(pred1, center = TRUE, scale. = TRUE)
library(devtools)
library(ggbiplot)

png("PCA1", width=8, height=10, units="in", res=600)
g <- ggbiplot(data.pca, obs.scale = 1, var.scale = FALSE, groups = fac, ellipse = FALSE, circle = FALSE, varname.size = 3, var.axes = FALSE, labels = NULL)
g
dev.off ()
png("PCA2", width=8, height=10, units="in", res=600)
p <- plot (data.pca, type = "lines")
p
dev.off ()

# png("Hybrid_Ec6distribution", width=8, height=10, units="in", res=600)
# g <- ggbiplot(data.pca, groups = fac, ellipse = TRUE, circle = TRUE)
# g
# dev.off ()
