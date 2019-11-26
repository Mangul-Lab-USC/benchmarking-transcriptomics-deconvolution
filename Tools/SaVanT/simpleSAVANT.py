from sys import *

def main():
   
   expMat = readInMat(argv[1])
   sigMat = readInMat(argv[2])
   N = int(argv[3])
   sampleNames = expMat[0]
   expDict = matToDict(expMat[1:])
   outMat = AverageAllSigs(sigMat,expDict, N )
   outMat = [sampleNames] + outMat
   printMat(flipMat(outMat))
   return 

def flipMat(mat):
   
  flipped = [[m] for m in mat[0]]
  for line in mat[1:]:
    for i in range(len(line)):
       el = line[i]
       flipped[i].append(el)

  return flipped

def printMat(mat):
   for line in mat:
     print ",".join([str(m) for m in line])

def readInMat(fileName):
   myMat = []
   for line in open(fileName):
     parts = [m.strip("\"") for m in line.strip().split("\t")]
     if len(parts) == 1:
       parts = [m.strip("\"") for m in line.strip().split(",")]

     myMat.append(parts)
       
   return myMat

def matToDict(matrix):
   expDict = {}
   """
   keys = geneSymbol
   vals = vector of expression of gene across all samples
   """   
   for line in matrix:
     expDict[line[0]] = line[1:]
   return expDict

def AverageAllSigs(sigList, expDict, N):
   """
   return the average expression value of the first N genes in geneList in matrix
   """
   outMat = []
   for sig in sigList:
     outMat.append(AverageOneSig(sig,expDict, N))

   return outMat

def AverageOneSig(sig, expDict, N):
     numSamples = len(expDict[expDict.keys()[0]])
     summationVec = [0.0]*numSamples
     counter = 0
     for sigGene in sig[1:]:
       if sigGene in expDict:
         geneExpVec = expDict[sigGene]
         for i in range(len(geneExpVec)):
           summationVec[i] += float(geneExpVec[i])
         counter += 1
         if counter >= N:
           break
       
     AverageVec = [0] * numSamples
     for i in range(len(summationVec)):
       AverageVec[i] = summationVec[i]/float(counter)

     return [sig[0]] + AverageVec


main()      
