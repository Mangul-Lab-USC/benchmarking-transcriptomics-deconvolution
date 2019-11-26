#!/usr/bin/Rscript
#library(gplots)
library(RColorBrewer)
library(glmnet)
args = commandArgs(TRUE)

A_GEDITDecon = function(MixMat, RefMat){
    Predictions = C_GLMRegressionLoop(MixMat, RefMat, alpha, lambda, intercept) 
    Predictions = Predictions[2:dim(Predictions)[1],]
    Adjusted = DD_Adjust(Predictions)
    Adjusted = round(Adjusted[,],4)
    Adjusted = t(Adjusted)
    return(Adjusted)}

C_GLMRegressionLoop = function(Samples, Refmat, Alph, Lamb, Inter) 
{   
    Predictions = as.data.frame(matrix(0, ncol = dim(Samples)[2], nrow = 1+dim(Refmat)[2]))
    for (i in 1:dim(Samples)[2]){
      OutMat = as.matrix(coef(glmnet(as.matrix(Refmat), as.matrix(Samples[,i]), 
        lower.limits = 0.0, alpha = Alph, lambda = Lamb, intercept = Inter)))
      LastColumn = dim(OutMat)[2]
      Predictions[,i] = OutMat[,LastColumn] 
    }
    names(Predictions) = names(Samples)
    row.names(Predictions) = c("intercept",names(Refmat))
    return(Predictions)
}

D_AdjustLoop = function(Predictions){
    Adjusted = Predictions
    for (i in 1:length(Predictions)){
        Adjusted[[i]] = DD_Adjust(Predictions[[i]])}
    return(Adjusted)}

DD_Adjust = function(Predictions){
    Adjusted = Predictions
    numPreds = dim(Predictions)[2]
    numCTs   = dim(Predictions)[1]
    for (i in 1:numPreds){
        Adjusted[i] = round(Predictions[i]/sum(Predictions[1:numCTs,i]),5)
      if (sum(Predictions[1:numCTs,i]) == 0.0){
        Adjusted[i] = round(1.0/numCTs,5)
    }
    }
    return(Adjusted)
}

basicHeatMap = function(predictions){heatmap.2(predictions, Rowv = FALSE, Colv = FALSE, trace = "none", col = brewer.pal(9, "Blues"), margins = c(30,12), key = FALSE, lhei = c(.5,4), lwid = c(.5,4), cellnote = round(predictions,2),notecol = "white")}

mixture = read.table(args[1], header = TRUE, row.names = 1, sep = "\t")
ref = read.table(args[2], header = TRUE, row.names = 1, sep = "\t")
outFile = args[3]
strDescr = args[4]

alpha = 0 #as.numeric(args[5])
lambda = 0 #as.numeric(args[6])
intercept = FALSE #as.logical(args[7]) 
AllPredictions = A_GEDITDecon(mixture, ref)

#pdf(file = paste(outFile,".pdf", sep = ""), width = 11, height = 8.5)
#heatmap.2(as.matrix(AllPredictions), Rowv = FALSE, Colv = FALSE, trace = "none", col = brewer.pal(9, "Oranges"), margins = c(30,8), colsep = 0:dim(AllPredictions)[2], rowsep = 0:dim(AllPredictions)[1],cellnote = round(AllPredictions,2),notecol = "black", key = FALSE, lhei = c(.5,4), lwid = c(.5,4), main = "Predicted Sample Composition")
#dev.off()


#pdf(file = paste(args[3],".pdf", sep = ""), width = 11, height = 8.5)
#dev.off()
print(AllPredictions)
write.table(x = AllPredictions, file = outFile, quote = FALSE, sep = "\t")
