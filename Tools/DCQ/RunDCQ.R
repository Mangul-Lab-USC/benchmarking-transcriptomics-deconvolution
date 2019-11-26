library("ComICS")
args = commandArgs(TRUE)

ref = read.table(args[1], header = TRUE, row.names =1, sep = "\t")
mix = read.table(args[2], header = TRUE, row.names = 1, sep = "\t")
markers = as.data.frame(row.names(ref))
outFile = args[3]
Result = dcq(ref, mix, markers)
flipped = t(as.data.frame(Result))
write.table(flipped, outFile, quote = FALSE, sep = "\t")


