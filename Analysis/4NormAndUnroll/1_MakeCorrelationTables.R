MakeTable1Tool = function(toolName,DataMatrix){
    justTool = DataMatrix[DataMatrix$Tool == toolName,]
    refNames = names(which(table(justTool[,2]) > 0))
    corMat = data.frame(refNames)
    corMat[,2] = 0
        
    names(corMat) = c("RefMat",paste(toolName,"corr",sep ="_"))
    for (i in 1:length(refNames)){
  	  relData = justTool[justTool$Reference==refNames[i],]
   corMat[i,2] = cor(relData[,5],relData[,6])}


return(corMat)}







MakeTableAllTools = function(AllPredictions){
   toolList = names(table(AllPredictions[,1]))
   outMat = MakeTable1Tool(toolList[1],AllPredictions)
   for (i in 2:length(toolList)){
	    nextMat = MakeTable1Tool(toolList[i],AllPredictions)
   outMat = merge(outMat,nextMat, by="RefMat", all = T)}
return(outMat)}






DataCellMix = read.table("Unrolled_Normed_CellMix.tsv", header = TRUE, sep = "\t")
DataPBMC1 = read.table("Unrolled_Normed_PBMC1.tsv", header = TRUE, sep = "\t")
DataPBMC2 = read.table("Unrolled_Normed_PBMC2.tsv", header = TRUE, sep = "\t")
DataStromal = read.table("Unrolled_Normed_Stromal.tsv", header = TRUE, sep = "\t")
DataFram = read.table("Unrolled_Normed_Fram.tsv", header = TRUE, sep = "\t")
CorrCellMix = MakeTableAllTools(DataCellMix)
CorrPBMC1 = MakeTableAllTools(DataPBMC1)
CorrPBMC2 = MakeTableAllTools(DataPBMC2)
CorrStromal = MakeTableAllTools(DataStromal)
CorrFram = MakeTableAllTools(DataFram)
write.table(CorrCellMix, "CorrelationTables/CellMixNormCorrs.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(CorrPBMC1, "CorrelationTables/PBMC1NormCorrs.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(CorrPBMC2, "CorrelationTables/PBMC2NormCorrs.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(CorrStromal, "CorrelationTables/StromalNormCorrs.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(CorrFram, "CorrelationTables/FramNormCorrs.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
