from sys import *


def ParseFileName(fname):
  corefname = fname.split("/")[-1].split(".")[0]
  parts = corefname.strip().split("_")
  return parts

def main():
  flist = []
  SampleDict = {}
  for line in open(argv[1],"r"):
   flist.append(line.strip())
  print "\t".join(["Tool","Reference","SampleName", "CellType","Prediction", "Answer", "Error", "SqError"])
  partsList = []
  for line in open(argv[2],"r"):
     partsList.append(line.strip().split("\t"))

  CellTypes = partsList[0][1:]
  AnswersD = {}
  for parts in partsList[1:]:
     Sample = parts[0]
     SampleDict[Sample] = 0
     for i in range(1,len(parts)):
       CellType = CellTypes[i-1]  # -1 is a recent change that I may want to verify
       Answer = parts[i]
       AnswersD[Sample.lower() + "-" + CellType] = Answer
       #print Sample.lower() + "-" + CellType, Answer, parts
  for fname in flist:
     fstream = open(fname,"r")
     Tool = fname.split("_")[0].split("/")[-1]
     reference = fname.split("_")[2]
     LineList = []
     First = True
     for line in fstream:
       if First:
           First = False
           continue
       LineList.append(line.strip().split("\t"))

     for parts in LineList:
          
       Sample = parts[0]
       if Sample not in SampleDict:
           continue

       numParts = [float(m) for m in parts[1:]]
       minVal = round(min(numParts),6)
       if minVal < 0:
         adjustedParts = [m - minVal for m in numParts]
         numParts = adjustedParts
         #print minVal
       totalWeight = sum(float(m) for m in numParts[:-1])
       for i in range(0,len(numParts)-1):
         if totalWeight == 0:
            prediction = 0
         else:
            prediction = float(numParts[i])/float(totalWeight)
         #print "\t".join([str(m) for m in [parts[i+1], numParts[i], totalWeight,prediction]])
         CellType = CellTypes[i]
         TrueProp = AnswersD[Sample.lower() + "-" + CellType]
         Error = abs(float(TrueProp)-prediction)
         SqError = Error*Error
         print "\t".join([Tool, reference, Sample ,CellType,str(prediction), TrueProp, str(Error), str(SqError)])
main()
