
CalcError1Tool = function(toolName,DataMatrix)
{justTool = DataMatrix[DataMatrix$Tool == toolName,]
refNames = names(which(table(justTool[,2]) > 0))
errMat = data.frame(refNames)
errMat[,2] = 0

names(errMat) = c("RefMat",paste(toolName,"err",sep ="_"))
for (i in 1:length(refNames)){
    relData = justTool[justTool$Reference==refNames[i],]
    errMat[i,2] = mean(relData[,7])}

return(errMat)}

CalcErrorAllTools = function(AllPredictions)
{toolList = names(table(AllPredictions[,1]))
outMat = CalcError1Tool(toolList[1],AllPredictions)
for (i in 2:length(toolList)){
    nextMat = CalcError1Tool(toolList[i],AllPredictions)
    outMat = merge(outMat,nextMat, by="RefMat", all = T)}
return(outMat)}


DataCellMix = read.table("Unrolled_Normed_CellMix.tsv", header = TRUE, sep = "\t")
DataPBMC1 = read.table("Unrolled_Normed_PBMC1.tsv", header = TRUE, sep = "\t")
DataPBMC2 = read.table("Unrolled_Normed_PBMC2.tsv", header = TRUE, sep = "\t")
DataStromal = read.table("Unrolled_Normed_Stromal.tsv", header = TRUE, sep = "\t")
DataFram = read.table("Unrolled_Normed_Fram.tsv", header = TRUE, sep = "\t")
CorrCellMix = CalcErrorAllTools(DataCellMix)
CorrPBMC1 = CalcErrorAllTools(DataPBMC1)
CorrPBMC2 = CalcErrorAllTools(DataPBMC2)
CorrStromal = CalcErrorAllTools(DataStromal)
CorrFram = CalcErrorAllTools(DataFram)
write.table(CorrCellMix, "ErrorTables/CellMixErrors.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(CorrPBMC1, "ErrorTables/PBMC1Errors.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(CorrPBMC2, "ErrorTables/PBMC2Errors.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(CorrStromal, "ErrorTables/StromalErrors.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(CorrFram, "ErrorTables/FramErrors.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
