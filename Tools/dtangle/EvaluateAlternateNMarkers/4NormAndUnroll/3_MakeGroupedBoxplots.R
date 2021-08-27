library(ggplot2)

DataCellMix = read.table("Unrolled_Normed_CellMix.tsv", header = TRUE, sep = "\t")
DataPBMC1 = read.table("Unrolled_Normed_PBMC1.tsv", header = TRUE, sep = "\t")
DataPBMC2 = read.table("Unrolled_Normed_PBMC2.tsv", header = TRUE, sep = "\t")
DataStromal = read.table("Unrolled_Normed_Stromal.tsv", header = TRUE, sep = "\t")
DataFram = read.table("Unrolled_Normed_Fram.tsv", header = TRUE, sep = "\t")



#make stat summary plot
MakeSummPlot = function(Data,Title){
	ggplot(Data,aes(x=Tool,y=Error) + geom_pointrange() + stat_summary(fun.data ="mean_cl_boot",color="red",size = 2)}
#ggplot(Data, aes(x=Tool,y=Error, fill = CellType)) + geom_pointrange(Data, mapping = aes(ymin=upper,ymax=lower))}
#+ ggtitle(Title) + theme(plot.title = element_text(hjust = 0.5)) + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + scale_x_discrete(labels = c("AbsCIBERSORT","CIBERSORT","DCQ","DeconRNASeq","dtangle","EPIC","GEDIT","MCP-Counter","quantiseq","SaVaNT","xCell"))
#}
#)fun.data = "mean_sdl", fun.args=list(mult=1), geom="pointrange", color = "red")

# stat_summary(fun.data="mean_sdl",geom="pointrange", color = "red") + 
#boxplot grouped by Tool, members of each group are CT
MakeBoxplot = function(Data, Title){
ggplot(Data, aes(x=Tool, y=Error, fill=CellType)) + ggtitle(Title) + geom_boxplot(outlier.shape = NA) + theme(plot.title = element_text(hjust = 0.5)) + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + scale_x_discrete(labels = c("AbsCIBERSORT","CIBERSORT","DCQ","DeconRNASeq","dtangle","EPIC","GEDIT","MCP-Counter","quantiseq","SaVaNT","xCell"))
}

#boxplot grouped by CT
MakeBoxplot2 = function(Data, Title){
ggplot(Data, aes(x=CellType, y=Error, fill=Tool)) + ggtitle(Title) + geom_boxplot(outlier.shape = NA) + theme(plot.title = element_text(hjust = 0.5)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))
}


png("SummPlots/Fram.png")
MakeSummPlot(DataFram,"Error on Fram")
dev.off()

png("Boxplots/CellMix.png")
MakeBoxplot(DataCellMix, "Error of Predictions on CellMix")
dev.off()

png("Boxplots/PBMC1.png")
MakeBoxplot(DataPBMC1, "Error of Predictions on PBMC1")
dev.off()

png("Boxplots/PBMC2.png")
MakeBoxplot(DataPBMC2, "Error of Predictions on PBMC2")
dev.off()

png("Boxplots/Stromal.png")
MakeBoxplot(DataStromal, "Error of Predictions on Stromal")
dev.off()

png("Boxplots/Fram.png")
MakeBoxplot(DataFram, "Error of Predictions on Framingham")
dev.off()


png("Boxplots2/CellMix.png")
MakeBoxplot2(DataCellMix, "Error of Predictions on CellMix")
dev.off()

png("Boxplots2/PBMC1.png")
MakeBoxplot2(DataPBMC1, "Error of Predictions on PBMC1")
dev.off()

png("Boxplots2/PBMC2.png")
MakeBoxplot2(DataPBMC2, "Error of Predictions on PBMC2")
dev.off()

png("Boxplots2/Stromal.png")
MakeBoxplot2(DataStromal, "Error of Predictions on Stromal")
dev.off()

png("Boxplots2/Fram.png")
MakeBoxplot2(DataFram, "Error of Predictions on Framingham")
dev.off()
