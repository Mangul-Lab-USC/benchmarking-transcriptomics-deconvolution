library(gplots)
library(RColorBrewer)

myTable = round(read.table("AggregateError.tsv", header = TRUE, row.names = 1, sep = "\t",check.names = FALSE),2)


Reds = brewer.pal(7,"Reds")

myPalate = c(Reds[1:2],Reds[4:7])

makeHM = function(myMat, OutputPath){
   png(OutputPath, 1500, 1500)
   myMat = as.matrix(myMat)
   heatmap.2(myMat,2, trace = "none", dendrogram = "none", Rowv = FALSE, Colv = FALSE, col = myPalate, cellnote = myMat, notecex = 2.0, notecol = "black", margins = c(20,19), main = "Correlation By Tool and Cell Type", breaks = c(0.0,.05,.075,.1,0.15,0.2,.25), colsep = c(1:12), rowsep = c(1:6), sepwidth = c(.01,.01), sepcolor = "gray", cexCol = 3, cexRow = 3)
   dev.off()
}

makeHM(myTable, "FullErrorTable.png")