
library(RColorBrewer)
library(gplots)

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

CalcErrorAllTools = function(AllPredictions){
toolList = names(table(AllPredictions[,1]))
outMat = CalcError1Tool(toolList[1],AllPredictions)
for (i in 2:length(toolList)){
    nextMat = CalcError1Tool(toolList[i],AllPredictions)
    outMat = merge(outMat,nextMat, by="RefMat", all = T)}
myNames = outMat[,1]
outMat = outMat[,2:dim(outMat)[2]]
row.names(outMat) = myNames
return(outMat)}

MakeHM = function(myMat, OutputPath){
   png(OutputPath, 1500, 1500)
   myPalate = c(brewer.pal(2,"Blues")[2],brewer.pal(2,"Blues")[1],brewer.pal(7,"Reds"))
   #c(brewer.pal(5,"Reds")[3],brewer.pal(5,"Reds")[2], brewer.pal(7,"Blues")[2:6])
   myMat = as.matrix(myMat)
   print(myMat)
   heatmap.2(myMat, trace = "none", dendrogram = "none", Rowv = FALSE, Colv = FALSE, col = myPalate, cellnote = floor(100*myMat)/100, notecol = "black", margins = c(17,20), main = "Correlation By Tool and Cell Type", breaks = c(0.0,0.1,.125,0.15,.175,.2,.225,.25,.3,.5), cexRow = 3, cexCol = 3, notecex = 3)
   dev.off()
}

DataCellMix = read.table("Unrolled_Normed_CellMix.tsv", header = TRUE, sep = "\t")
DataPBMC1 = read.table("Unrolled_Normed_PBMC1.tsv", header = TRUE, sep = "\t")
DataPBMC2 = read.table("Unrolled_Normed_PBMC2.tsv", header = TRUE, sep = "\t")
DataStromal = read.table("Unrolled_Normed_Stromal.tsv", header = TRUE, sep = "\t")
DataFram = read.table("Unrolled_Normed_Fram.tsv", header = TRUE, sep = "\t")
DataAllPBMC = read.table("Unrolled_Normed_AllPBMC.tsv", header = TRUE, sep = "\t")

CellMix = CalcErrorAllTools(DataCellMix)
PBMC1 = CalcErrorAllTools(DataPBMC1)
PBMC2 = CalcErrorAllTools(DataPBMC2)
Stromal = CalcErrorAllTools(DataStromal)
Fram = CalcErrorAllTools(DataFram)
AllPBMC = CalcErrorAllTools(DataAllPBMC)

MakeHM(CellMix, "ErrorByRef/CellMix.png")
MakeHM(PBMC1, "ErrorByRef/PBMC1.png")
MakeHM(PBMC2, "ErrorByRef/PBMC2.png")
MakeHM(Stromal, "ErrorByRef/Stromal.png")
MakeHM(Fram, "ErrorByRef/Fram.png")
MakeHM(AllPBMC, "ErrorByRef/AllPBMC.png")

write.table(CellMix, "ErrorByRef/CellMixErrors.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(PBMC1, "ErrorByRef/PBMC1Errors.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(PBMC2, "ErrorByRef/PBMC2Errors.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(Stromal, "ErrorByRef/StromalErrors.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(Fram, "ErrorByRef/FramErrors.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(AllPBMC, "ErrorByRef/AllPBMCErrors.tsv", sep = "\t", quote =FALSE, row.names = FALSE)

