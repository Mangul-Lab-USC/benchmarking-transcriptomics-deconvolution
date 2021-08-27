library(ggplot2)



MakeScatter = function(AllPredictions,i, Dataset){
        ToolList = names(table(AllPredictions[,1]))
	curTool = ToolList[i]
	JustTool = AllPredictions[AllPredictions$Tool==curTool,]
	outFile= paste("ScatterPlots/",Dataset,"/",curTool,Dataset,".png", sep = "_")
        print 
	print(outFile)
	png(outFile,2000,2000)
	myplot = ggplot(JustTool, aes(x=Answer, y=Prediction, color = CellType)) + ggtitle(curTool) + theme_bw() + theme(text=element_text(size=100)) + theme(plot.title = element_text(hjust = 0.5)) + xlab("True Fraction") + ylab("Tool Output") + ylim(0,max(1,JustTool$Prediction)) + xlim(0,1) + geom_abline(slope = 1, intercept = 0, size = 2) + geom_point(size=8) + theme(legend.position = "none") 
	# + guides(colour = guide_legend(override.aes = list(size=20))) 
        print(myplot)
	dev.off()}

LoopOverTools = function(AllPredictions,dataset){
  ToolList = names(table(AllPredictions[,1]))
  for (i in 1:length(ToolList)){
	curTool = ToolList[i]
	JustTool = AllPredictions[AllPredictions$Tool==curTool,]
	outFile= paste("ScatterPlots/",curTool,".png", sep = "_")
        MakeScatter(AllPredictions,i,dataset)
  }
}

DataCellMix = read.table("../3CombineAndUnroll/Unrolled_CellMix.tsv", header = TRUE, sep = "\t")
DataPBMC = read.table("../3CombineAndUnroll/Unrolled_AllPBMC.tsv", header = TRUE, sep = "\t")
DataStromal = read.table("../3CombineAndUnroll/Unrolled_Stromal.tsv", header = TRUE, sep = "\t")
DataFram = read.table("../3CombineAndUnroll/Unrolled_Fram.tsv", header = TRUE, sep = "\t")

LoopOverTools(DataCellMix,"cellmix")
LoopOverTools(DataPBMC,"PBMC")
LoopOverTools(DataStromal,"stromal")
LoopOverTools(DataFram,"fram")

# geom_smooth(method=lm, aes(x=Answer,y=Prediction), inherit.aes = FALSE, color = "black")
#geom_abline(slope = 1, intercept = 0) +
