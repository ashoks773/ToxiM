# Tutorials: http://stackoverflow.com/questions/17924828/differences-in-heatmap-clustering-defaults-in-r-heatplot-versus-heatmap-2
#            http://stanstrup.github.io/heatmaps.html

# Script given by parul
a= read.csv(file="Desc_trainTop20Wilcox", sep=",", header=T, row.names = 1)
b= read.csv(file="Fing_trainTop20Wilcox", sep=",", header=T, row.names = 1)

# d1 = a[c(2:11)]
# b = data.matrix(d1)

# heatmap(b)
# heatmap(b, col = cm.colors(256))
# heatmap(b, col = heat.colors(256))

# Script1 ---------------------------------- Developed by ashok -------------------------------- #
# library (RColorBrewer)
# library(gplots) 
# a= read.csv(file="checkdata", sep="\t", header=T, row.names = 1)
# # a= read.csv(file="checkdata", sep="\t")
# 
# rnames <- a[,1]
# mat_data <- data.matrix(a[,3:ncol(a)])
# rownames(mat_data) <- rnames
# 
# my_palette <- colorRampPalette(c("red", "yellow", "green"))(n = 299) # Optional for colour
# #col_breaks = c(seq(-1,0,length=100), # for red
# #seq(0,0.8,length=100),  # for yellow
# #seq(0.81,1,length=100)) # for green
# 
# png("heatmaps_in_r.png", width = 5*300, height = 5*300, res = 300, pointsize = 5)   # create PNG for the heat map        
# # 5 x 300 pixels
# # 300 pixels per inch
# # smaller font size 8
# heatmap.2(mat_data,
#   cellnote = mat_data,  # same data set for cell labels
#   main = "Correlation", # heat map title
#   notecol="black",      # change font color of cell labels to black
#   density.info="none",  # turns off density plot inside color legend
#   trace="none",         # turns off trace lines inside the heat map
#   margins =c(12,9),     # widens margins around plot
#   col=my_palette,       # use on color palette defined earlier
#   #breaks=col_breaks,    # enable color transition at specified limits
#   dendrogram="row",     # only draw a row dendrogram
#   Colv="NA")            # turn off column clustering
# 
# distance = dist(mat_data, method = "manhattan") # Distance calculation using matrix data
# cluster = hclust(distance, method = "ward") # Clustering using these distances
# png("heatmaps_in_r_AfterClustering.png", width = 5*300, height = 5*300, res = 300, pointsize = 5)   # create PNG for the heat map        
# heatmap.2(mat_data,
#   cellnote = mat_data,  # same data set for cell labels
#   main = "Correlation", # heat map title
#   notecol="black",      # change font color of cell labels to black
#   density.info="none",  # turns off density plot inside color legend
#   trace="none",         # turns off trace lines inside the heat map
#   margins =c(12,9),     # widens margins around plot
#   col=my_palette,       # use on color palette defined earlier
#   #breaks=col_breaks,    # enable color transition at specified limits
#   dendrogram="row",     # only draw a row dendrogram
#   Rowv = as.dendrogram(cluster),
#   Colv= "NA")            # turn off column clustering

# a= read.csv(file="checkdata", sep="\t", header=T, row.names = 1)
# a2 <- a[,2:11]
# a3 = data.matrix(a2)
# library("made4")
# require(RColorBrewer)

# heatmap.2(a2, trace="none")
# heatplot(a3)
# dist.pear <- function(x) as.dist(1-cor(t(x)))
# hclust.ave <- function(x) hclust(x, method="average")
# heatmap.2(a3, trace="none", distfun=dist.pear, hclustfun=hclust.ave)
# heatmap.2(a3, trace="none", distfun=dist.pear, hclustfun=hclust.ave,scale="row")
# heatmap.2(a3, trace="none", distfun=dist.pear, hclustfun=hclust.ave,scale="col")

# library("devtools")
# source_url("https://raw.githubusercontent.com/obigriffith/biostar-tutorials/master/Heatmaps/heatmap.3.R")
# source ("/mnt/hdd2/Databases/heatmap.3.R") # Additional If this R file has been downloaded and stored in this folder

# cols <- colorRampPalette(brewer.pal(10, "RdBu"))(256)
# distCor <- function(x) as.dist(1-cor(t(x)))
# hclustAvg <- function(x) hclust(x, method="average")
# heatmap.3(a3, trace="none", scale="row", zlim=c(-3,3), reorder=FALSE, distfun=distCor, hclustfun=hclustAvg, col=rev(cols), symbreak=FALSE) # Not running

# ** ----------------------------------------------------------- Heat map for publication ------------------------------------------------------------------- ** #
library(dplyr)
library(NMF)
library(RColorBrewer)
a2 <- a[,1:20]
result_matrix <- data.matrix(a2)
aheatmap(result_matrix, color = "-RdBu:50", breaks = 0,  main = "Association", distfun = "spearman", fontsize=10,  filename="DesHeatMap.pdf")
aheatmap(result_matrix, color = "-RdBu:50", breaks = 0, scale = "col", cellwidth = 10, cellheight =10, border_color = "white", main = "Association", distfun = "spearman", fontsize=10,  filename="DesHeatMap1.pdf")

# demo('aheatmap') This command will help us to modifify the heatmap according to the desired requirements
# scale = "col" If varibles are in the column and 
# scale = "row" If varibles are in the row

b2 <- b[,1:20]
result_matrix <- data.matrix(b2)
aheatmap(result_matrix, color = "-RdBu:50", breaks = 0,  main = "Association", distfun = "spearman", fontsize=10,  filename="FingerHeatMap.pdf")
aheatmap(result_matrix, color = "-RdBu:50", breaks = 0, scale = "col", cellwidth = 10, cellheight =10, border_color = "white", main = "Association", distfun = "spearman", fontsize=10,  filename="FingHeatMap1.pdf")

#d3heatmap(result_matrix,Rowv = FALSE, Colv=FALSE)