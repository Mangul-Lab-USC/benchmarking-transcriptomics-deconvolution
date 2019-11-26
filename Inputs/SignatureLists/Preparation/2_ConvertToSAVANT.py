from sys import *

inMat = []
for line in open(argv[1],"r"):
  inMat.append(line.strip().split("\t"))    

SigLists = []
CTs = inMat[0][1:]
for cellType in inMat[0][1:]:
   SigLists.append([cellType])

for parts in inMat[1:]:
   name = parts[0]
   parts = [float(m) for m in parts[1:]]
   biggest = max(parts)
   highestI = parts.index(biggest)
   meanAvg = (sum(parts) - biggest)/float(len(parts)-1)
   SigLists[highestI].append(name)
for sigList in SigLists:
    print "\t".join(sigList)
