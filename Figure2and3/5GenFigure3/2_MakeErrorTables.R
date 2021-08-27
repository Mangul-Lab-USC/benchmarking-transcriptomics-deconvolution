library(gplots)
library(RColorBrewer)

CalcCor1Tool = function(toolName,DataMatrix){
   justTool = DataMatrix[DataMatrix$Tool == toolName,]
   errorVal = mean(justTool[,7])
return(errorVal)}


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

DataCellMix = read.table("Unrolled_Normed_CellMix.tsv", header = TRUE, sep = "\t")
DataPBMC = read.table("Unrolled_Normed_AllPBMC.tsv", header = TRUE, sep = "\t")
DataStromal = read.table("Unrolled_Normed_Stromal.tsv", header = TRUE, sep = "\t")
DataFram = read.table("Unrolled_Normed_Fram.tsv", header = TRUE, sep = "\t")

DataPBMC1 = read.table("Unrolled_Normed_PBMC1.tsv", header = TRUE, sep = "\t")
DataPBMC2 = read.table("Unrolled_Normed_PBMC2.tsv", header = TRUE, sep = "\t")

CorrCellMix = MakeTableAllTools(DataCellMix)
CorrPBMC = MakeTableAllTools(DataPBMC)
CorrStromal = MakeTableAllTools(DataStromal)
CorrFram = MakeTableAllTools(DataFram)

CorrPBMC1 = MakeTableAllTools(DataPBMC1)
CorrPBMC2 = MakeTableAllTools(DataPBMC2)

ErrAll = data.frame(CorrPBMC)
ErrAll[2,] = CorrStromal
ErrAll[3,] = CorrCellMix
ErrAll[4,] = CorrFram
row.names(ErrAll) = c("PBMC","Stromal","Cell Mixtures", "Framingham")

write.table(ErrAll, "ErrorTables/AllErrors.tsv", sep = "\t", quote =FALSE)
write.table(CorrCellMix, "ErrorTables/CellMixCorrs.tsv", sep = "\t", quote =FALSE)
write.table(CorrPBMC, "ErrorTables/BothPBMCCorrs.tsv", sep = "\t", quote =FALSE)
write.table(CorrStromal, "ErrorTables/StromalCorrs.tsv", sep = "\t", quote =FALSE)
write.table(CorrFram, "ErrorTables/FramCorrs.tsv", sep = "\t", quote =FALSE)


myTable = round(read.table("ErrorTables/AllErrors.tsv", header = TRUE, row.names = 1, sep = "\t",check.names = FALSE),2)

makeHM = function(myMat, OutputPath){
   png(OutputPath, 2000, 1500)
   myMat = as.matrix(myMat)
   myPalate = brewer.pal(9, "Reds")[c(1,2,4,6,7)]
   heatmap.2(myMat, trace = "none", dendrogram = "none", Rowv = FALSE, Colv = FALSE, col = myPalate, cellnote = round(myMat,2), notecol = "black", margins = c(22,18), main = "Correlation By Tool and Cell Type", breaks = c(0.0,.075,.1,.15,.2,.4), cexRow = 3.2, cexCol = 3.3, notecex = 3.5, rowsep = c(4), sepcolor = "white")
   dev.off()
}

makeHM(myTable, "ErrorTables/ErrorHM.png")
