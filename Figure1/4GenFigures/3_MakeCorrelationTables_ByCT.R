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

makeHM = function(myMat, OutputPath, myTitle){
   png(OutputPath, 1500, 1500)
   myMat = as.matrix(myMat)
   heatmap.2(myMat, trace = "none", dendrogram = "none", Rowv = FALSE, Colv = FALSE, col = c("#EC2727",brewer.pal(9,"Blues")[1:7]), cellnote = round(myMat,2), notecex = 2, notecol = "black", margins = c(10,14), main = myTitle, breaks = c(-1,0.0,0.25,0.5,0.6,0.7,0.8,0.9,1.0))
   dev.off()
}

IterateThroughCTs = function(AllPredictions,DatasetName){
    CellTypes = names(table(AllPredictions$CellType))
    for (i in 1:length(CellTypes)){
         JustCT = AllPredictions[AllPredictions$CellType == CellTypes[i],]
         CorrCT = MakeTableAllTools(JustCT)
         outTsv = paste("CorrsByCT/", DatasetName, CellTypes[i], ".tsv",sep = "") 
         outPng = paste("CorrsByCT/", DatasetName, CellTypes[i], ".png",sep = "")
         write.table(CorrCT, outTsv)
         makeHM(CorrCT,outPng, paste(CellTypes[i],DatasetName,sep = "\n"))}
    }
         

DataCellMix = read.table("Unrolled_CellMix.tsv", header = TRUE, sep = "\t")
DataPBMC = read.table("Unrolled_AllPBMC.tsv", header = TRUE, sep = "\t")
DataStromal = read.table("Unrolled_Stromal.tsv", header = TRUE, sep = "\t")
DataFram = read.table("Unrolled_Fram.tsv", header = TRUE, sep = "\t")

IterateThroughCTs(DataCellMix, "Cell Mixtures")
IterateThroughCTs(DataPBMC, "PBMC Mixtures")
IterateThroughCTs(DataStromal, "Stromal Mixtures")
IterateThroughCTs(DataFram, "Framingham Cohort")
