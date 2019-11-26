#library(devtools)
#library(curl)
source("MCPcounter.R")
args = commandArgs(TRUE)

data_test<-read.table(args[1],sep="\t",header=T,check.names=FALSE,stringsAsFactors=FALSE, row.names = 1)
data_test[] <- lapply(data_test, function(x) as.numeric(as.character(x)))
Results<-MCPcounter.estimate(data_test,featuresType="HUGO_symbols")
write.table(t(Results), file = args[2], sep = "\t", quote = FALSE)

