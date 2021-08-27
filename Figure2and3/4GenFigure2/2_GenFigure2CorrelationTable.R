library(gplots)
library(RColorBrewer)

CalcCor1Tool = function(toolName,DataMatrix){
   justTool = DataMatrix[DataMatrix$Tool == toolName,]
   corVal = cor(justTool[,5],justTool[,6])
return(corVal)}


MakeTableAllTools = function(AllPredictions){
   toolList = names(table(AllPredictions[,1]))
   corVec = CalcCor1Tool(toolList[1],AllPredictions)
   for (i in 2:length(toolList)){
	    nextVal = CalcCor1Tool(toolList[i],AllPredictions)
            corVec = c(corVec, nextVal)
   }
   corVec = as.data.frame(t(corVec))
   names(corVec) = toolList
return(corVec)}

DataCellMix = read.table("../3CombineAndUnroll/Unrolled_CellMix.tsv", header = TRUE, sep = "\t")
DataPBMC = read.table("../3CombineAndUnroll/Unrolled_AllPBMC.tsv", header = TRUE, sep = "\t")
DataStromal = read.table("../3CombineAndUnroll/Unrolled_Stromal.tsv", header = TRUE, sep = "\t")
DataFram = read.table("../3CombineAndUnroll/Unrolled_Fram.tsv", header = TRUE, sep = "\t")


CorrCellMix = MakeTableAllTools(DataCellMix)
CorrPBMC = MakeTableAllTools(DataPBMC)
CorrStromal = MakeTableAllTools(DataStromal)
CorrFram = MakeTableAllTools(DataFram)

#Generate graphs for PBMC1 and PBMC2 separately, not used in final paper
#DataPBMC1 = read.table("Unrolled_PBMC1.tsv", header = TRUE, sep = "\t")
#DataPBMC2 = read.table("Unrolled_PBMC2.tsv", header = TRUE, sep = "\t")
#CorrPBMC1 = MakeTableAllTools(DataPBMC1)
#CorrPBMC2 = MakeTableAllTools(DataPBMC2)

CorrAll = data.frame(CorrPBMC)
CorrAll[2,] = CorrStromal
CorrAll[3,] = CorrCellMix
CorrAll[4,] = CorrFram
row.names(CorrAll) = c("PBMC","Stromal","Cell Mixtures", "Framingham")

write.table(CorrAll, "AllCorrs.tsv", sep = "\t", quote =FALSE)
write.table(CorrCellMix, "CellMixCorrs.tsv", sep = "\t", quote =FALSE)
write.table(CorrPBMC, "BothPBMCCorrs.tsv", sep = "\t", quote =FALSE)
write.table(CorrStromal, "StromalCorrs.tsv", sep = "\t", quote =FALSE)
write.table(CorrFram, "FramCorrs.tsv", sep = "\t", quote =FALSE)

makeHM = function(myMat, OutputPath){
   png(OutputPath, 2250, 1500)
   myMat = as.matrix(myMat)
   myPalate = c(brewer.pal(5,"Reds")[2], brewer.pal(6,"Blues")[2:5])
   heatmap.2(myMat, trace = "none", dendrogram = "none", Rowv = FALSE, Colv = FALSE, col = myPalate, cellnote = round(myMat,2), notecol = "black", margins = c(24,22), main = "Correlation By Tool and Cell Type", breaks = c(-1,0.0,.4,.7,.849,1.0), cexRow = 3.5, cexCol = 3.5, notecex = 3.5, rowsep = c(4), sepcolor = "white")
   dev.off()
}

makeHM(CorrAll, "CorrelationHeatmap.png")

