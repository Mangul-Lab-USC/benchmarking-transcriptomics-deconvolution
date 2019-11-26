from sys import *

convDict = {}
for line in open("A_SymbToEntrez.tsv"):
   parts = line.strip().split("\t")
   symb = parts[0]
   elist = parts[1]
   if len(elist.split(",")) > 1:
      entrez = elist.split(",")[0][3:]
   else:
      entrez = elist
   convDict[symb] = entrez

for line in open(argv[1]):
   parts = line.strip().split("\t")
   for part in parts[1:]:
      if part in convDict:
         #pass
         print part + "\t" + parts[0] + "\t" + convDict[part]
