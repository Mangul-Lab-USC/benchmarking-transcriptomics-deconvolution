from sys import *

SampleNames = {}

for line in open("DCQ_Fram_LM22-Full.tsv","r"):
   SampleNames[line.strip().split("\t")[0]] = 0


for line in open("TPFram_ExtraRows.tsv","r"):
    name = line.strip().split("\t")[0]
    if name in SampleNames:
        print line.strip()
