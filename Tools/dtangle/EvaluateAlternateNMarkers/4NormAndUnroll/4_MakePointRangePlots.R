library(ggplot2)
library(gplots)
library(dplyr)

DataCellMix = read.table("Unrolled_Normed_CellMix.tsv", header = TRUE, sep = "\t")
DataPBMC = read.table("Unrolled_Normed_AllPBMC.tsv", header = TRUE, sep = "\t")
DataStromal = read.table("Unrolled_Normed_Stromal.tsv", header = TRUE, sep = "\t")
DataFram = read.table("Unrolled_Normed_Fram.tsv", header = TRUE, sep = "\t")


MakeSummTable = function(Data){
SumTable = Data %>% group_by(Tool, CellType) %>% summarize( sd = sd(Error), bot = quantile(Error,probs = .05)[1],top = quantile(Error,probs = .95)[1], Error = mean(Error))
return(SumTable)}

MakePRPlotGCT = function(SumTable, linewd, fat)
{ggplot(SumTable, aes(CellType,Error)) + 
geom_pointrange(aes(ymin=bot, ymax = top, color = Tool, y = Error, lwd = linewd), fatten = fat, position = position_dodge(0.7)) +
 theme(axis.text.x = element_text(angle = 45, hjust = 1))
}
SCM = MakeSummTable(DataCellMix)
SPBMC = MakeSummTable(DataPBMC)
SStromal = MakeSummTable(DataStromal)
SFram = MakeSummTable(DataFram)

theme_set(theme_gray(base_size = 35))

png(file = "PointRangePlots/CellMix_ByCT.png", 2000,2000)
MakePRPlotGCT(SCM, .5,1.5)
dev.off()


png(file = "PointRangePlots/PBMC_ByCT.png", 2000,2000)
MakePRPlotGCT(SPBMC, .5, 1.5)
dev.off()


png(file = "PointRangePlots/Stromal_ByCT.png", 2000,2000)
MakePRPlotGCT(SStromal, .5, 1.5)
dev.off()


png(file = "PointRangePlots/Fram_ByCT.png", 1500,1500)
MakePRPlotGCT(SFram, 1.5, 2)
dev.off()

# +
# theme(axis.text.y = element_text(size = 30)) +
# theme(legend.text = element_text(size = 20))
