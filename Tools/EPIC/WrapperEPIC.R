source("EPIC_fun.R")
args = commandArgs(TRUE)

dataset = read.table(args[1], header = TRUE, row.names = 1, sep = "\t")
RefMat = read.table(args[2], header = TRUE, row.names = 1, sep = "\t")
sigList = scan(args[3], character(), quote = "")

RefList = list()
RefList$refProfiles = RefMat
RefList$sigGenes = sigList

output = EPIC(bulk = dataset, reference = RefList)
write.table(output$cellFractions,args[4], sep = "\t", quote = FALSE)
