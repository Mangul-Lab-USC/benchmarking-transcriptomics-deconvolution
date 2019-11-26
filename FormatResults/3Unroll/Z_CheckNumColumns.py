#flist = ["MatPredictions/Cibersort_LM22Ref.csv", "MatPredictions/Cibersort_BluePrintRef.csv","MatPredictions/GEDITPreds_BluePrint.csv", "MatPredictions/XCell_ReNormalized.csv","MatPredictions/XCell_Default.csv","MatPredictions/Cibersort_BPPredictions.csv"]
from sys import *


def ParseFileName(fname):
  corefname = fname.split("/")[-1].split(".")[0]
  parts = corefname.strip().split("_")
  return parts

def main():
  flist = []
  for line in open(argv[1],"r"):
   flist.append(line.strip())
  print "\t".join(["Tool","CellType","Prediction", "Answer", "Error", "SqError"])
  partsList = []
  for line in open(argv[2],"r"):
     partsList.append(line.strip().split("\t"))

  CellTypes = partsList[0][1:]
  AnswersD = {}
  for parts in partsList[1:]:
     Sample = parts[0]
     for i in range(1,len(parts)):
       CellType = CellTypes[i-1]  # -1 is a recent change that I may want to verify
       Answer = parts[i]
       AnswersD[Sample.lower() + "-" + CellType] = Answer

  for fname in flist:
     fstream = open(fname,"r")
     Tool = fname.split("_")[0].split("/")[-1]
     reference = fname.split("_")[2]
     LineList = []
     First = True
     for line in fstream:
       if First:
           First = False
           predCTs = line.strip().split()
           continue
       parts = line.strip().split("\t")
       if len(parts) != len(CellTypes)+1:
           print fname
           print len(parts)-1
           print len(CellTypes)
           print "\t".join(predCTs)
           print "\t".join(CellTypes)
           break


main()
