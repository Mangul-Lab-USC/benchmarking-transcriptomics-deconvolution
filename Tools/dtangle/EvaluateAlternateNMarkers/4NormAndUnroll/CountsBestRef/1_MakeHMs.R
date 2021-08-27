library(gplots)
library(RColorBrewer)

makeHM = function(myMat, OutputPath){
   png(OutputPath, 750, 750)
   myMat = as.matrix(myMat)
   heatmap.2(myMat, trace = "none", dendrogram = "none", Rowv = FALSE, Colv = FALSE, col = brewer.pal(9,"Blues")[1:7], cellnote = round(myMat,2), notecex = 1, notecol = "black", margins = c(10,14), main = "Number of Samples for Which Reference Produces the Lowest Error")
   dev.off()
}

DataAllPBMC = read.table("AllPBMC.tsv", header = TRUE, sep = "\t", row.names = 1)
DataCellMix = read.table("CellMix.tsv", header = TRUE, sep = "\t", row.names = 1)
DataFram = read.table("FramFixed.tsv", header = TRUE, sep = "\t", row.names = 1)
DataPBMC1 = read.table("PBMC1.tsv", header = TRUE, sep = "\t", row.names = 1)
DataPBMC2 = read.table("PBMC2.tsv", header = TRUE, sep = "\t", row.names = 1)
DataStromal = read.table("Stromal.tsv", header = TRUE, sep = "\t", row.names = 1)

makeHM(DataCellMix, "DataCellMix.png")
makeHM(DataAllPBMC, "AllPBMC.png")
makeHM(DataPBMC1, "PBMC1.png")
makeHM(DataPBMC2, "PBMC2.png")
makeHM(DataStromal, "Stromal.png")
makeHM(DataFram, "Fram.png")



