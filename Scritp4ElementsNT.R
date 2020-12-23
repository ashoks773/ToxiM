library("ChemmineR")
# Qsdf <- read.SDFset("1_AllTox.sdf")
# valid <- validSDF(Qsdf)
# sdfset <- Qsdf[valid]
# 
# #Molecular Property Functions (Physicochemical Descriptors)
# propma <- atomcountMA(sdfset, addH=FALSE)
# png ("toxin.png", width=1500,height=1000,res=150)
# boxplot(propma, col="blue", main="Atom Frequency")
# dev.off ()

Qsdf <- read.SDFset("1.AllNonTox.sdf")
valid <- validSDF(Qsdf)
sdfset <- Qsdf[valid]

#Molecular Property Functions (Physicochemical Descriptors)
propma <- atomcountMA(sdfset, addH=FALSE)
png ("Nontoxin.png", width=3500,height=1000,res=200)
boxplot(propma, col="blue", main="Distribution of atoms in non-toxins", xlab="Atoms", ylab="Frequency", ylim=c(0,200))
dev.off ()

# apset <- sdf2ap(sdfset)
# # For clustering based on atom pair
# dummy <- cmp.cluster(db=apset, cutoff=0, save.distances="distmat.rda", quiet=TRUE)
# load("distmat.rda")
# 
# # For clustering based on Fingerprints
# fpset <- desc2fp(apset)
# simMA <- sapply(cid(fpset), function(x) fpSim(fpset[x], fpset, sorted=FALSE))
# hc <- hclust(as.dist(1-simMA), method="single")
# plot(as.dendrogram(hc), edgePar=list(col=4, lwd=2), horiz=TRUE)
# library(gplots)
