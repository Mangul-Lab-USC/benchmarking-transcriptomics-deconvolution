library(nnls)
args = commandArgs(TRUE)



mixMat = read.table(args[1], header = TRUE, row.names =1, sep = "\t")
refMat = read.table(args[2], header = TRUE, row.names =1, sep = "\t")
SharedNames = intersect(row.names(mixMat),row.names(refMat))

readyMix = as.matrix(mixMat[SharedNames,])
readyRef = as.matrix(refMat[SharedNames,])

outMat = matrix(nrow = dim(readyMix)[2],ncol = dim(readyRef)[2])

for (i in 1:dim(readyMix)[2]){
      rawVec = nnls(readyRef, readyMix[,i])[[1]]
      normVec = rawVec/sum(rawVec)
      outMat[i,] = normVec}

outDF = as.data.frame(outMat)
names(outDF) = names(refMat)
row.names(outDF) = names(mixMat)

write.table(outDF, file = args[3], sep = "\t", quote = FALSE, col.names = NA)
