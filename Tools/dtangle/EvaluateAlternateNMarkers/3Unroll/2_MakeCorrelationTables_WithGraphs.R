library(gplots)
library(RColorBrewer)

MakeTable1Tool = function(toolName,DataMatrix){
    justTool = DataMatrix[DataMatrix$Tool == toolName,]
    refNames = names(which(table(justTool[,2]) > 0))
    corMat = data.frame(refNames)
    corMat[,2] = 0
        
    names(corMat) = c("RefMat",toolName)
    for (i in 1:length(refNames)){
  	  relData = justTool[justTool$Reference==refNames[i],]
   corMat[i,2] = cor(relData[,5],relData[,6])}
return(corMat)}


MakeTableAllTools = function(AllPredictions){
   toolList = names(table(AllPredictions[,1]))
   outMat = MakeTable1Tool(toolList[1],AllPredictions)
   for (i in 2:length(toolList)){
	    nextMat = MakeTable1Tool(toolList[i],AllPredictions)
            outMat = merge(outMat,nextMat, by="RefMat", all = T)
   }
   finalMat = outMat[2:dim(outMat)[2]]
   row.names(finalMat) = outMat[,1]
return(finalMat)}

makeHM = function(myMat, OutputPath){
   png(OutputPath, 1500, 1500)
   myPalate = c(brewer.pal(5,"Reds")[3],brewer.pal(5,"Reds")[2], brewer.pal(7,"Blues")[2:6])
   myMat = as.matrix(myMat)
   heatmap.2(myMat, trace = "none", dendrogram = "none", Rowv = FALSE, Colv = FALSE, col = myPalate, cellnote = round(myMat,2), notecol = "black", margins = c(20,22), main = "Correlation By Tool and Cell Type", breaks = c(-1,-.15,0.0,.2,.4,.8,.9,1.0), cexRow = 3, cexCol = 3, notecex = 7)
   dev.off()
}

#IterateThoughCTs(AllPredictions){
#    CellTypes = names(table(AllPredictios$CellType))
#    for i in (1:dim(CellTypes)){
#         JustCT = AllPredictions[AllPredictions$CellType == CellTypes[i],]
#         CorrCT = MakeTableAllTools(JustCT)
#         write.table(CorrCT, file = paste("CorrsByCT/", CellTypes[i], ".tsv",sep = "")
#         makeHM(CorrCT,paste("CorrsByCT/", CellTypes[i], ".png",sep = "")}
 
         

DataCellMix = read.table("Unrolled_CellMix.tsv", header = TRUE, sep = "\t")
DataPBMC = read.table("Unrolled_AllPBMC.tsv", header = TRUE, sep = "\t")
DataStromal = read.table("Unrolled_Stromal.tsv", header = TRUE, sep = "\t")
DataFram = read.table("Unrolled_Fram.tsv", header = TRUE, sep = "\t")




CorrCellMix = MakeTableAllTools(DataCellMix)
CorrPBMC = MakeTableAllTools(DataPBMC)
CorrStromal = MakeTableAllTools(DataStromal)
CorrFram = MakeTableAllTools(DataFram)




write.table(CorrCellMix, "CorrsByRef/CellMixCorrs.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(CorrPBMC, "CorrsByRef/BothPBMCCorrs.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(CorrStromal, "CorrsByRef/StromalCorrs.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(CorrFram, "CorrsByRef/FramCorrs.tsv", sep = "\t", quote =FALSE, row.names = FALSE)


#theme_set(theme_gray(base_size = 10))



makeHM(CorrCellMix, "CorrsByRef/CorrsByRefCellMix.png")
makeHM(CorrPBMC, "CorrsByRef/CorrsByRefPBMC.png")
makeHM(CorrStromal, "CorrsByRef/CorrsByCTStromal.png")
makeHM(CorrFram, "CorrsByRef/CorrsByRefFram.png")


DataPBMC1 = read.table("Unrolled_PBMC1.tsv", header = TRUE, sep = "\t")
DataPBMC2 = read.table("Unrolled_PBMC2.tsv", header = TRUE, sep = "\t")

CorrPBMC1 = MakeTableAllTools(DataPBMC1)
CorrPBMC2 = MakeTableAllTools(DataPBMC2)
makeHM(CorrPBMC1, "CorrsByRef/CorrsByRefPBMC1.png")
makeHM(CorrPBMC2, "CorrsByRef/CorrsByRefPBMC2.png")
write.table(CorrPBMC1, "CorrsByRef/PBMC1Corrs.tsv", sep = "\t", quote =FALSE, row.names = FALSE)
write.table(CorrPBMC2, "CorrsByRef/PBMC2Corrs.tsv", sep = "\t", quote =FALSE, row.names = FALSE)


