from sys import *
"""
TODO: 
    verify that all cell type labels are properly interpreted
    Manually check addition is done correctly
"""
"""
Purpose of this script:
Depending on the tool, reference, and mixture, the columns of the
outputs may need to me reordered or combined to match the answerkey
"""

def ConvertNames(namesList):
    newNames = []
    for oldName in namesList:
       newNames.append(Convert1Name(oldName))
    return newNames

def Convert1Name(Name):
  name = Name.lower()
  if "mono" in name:
     return "Monocytes"
  if "nk" in name\
          or "natural" in name:
     return "Lymphocyte"
  if "cd4" in name:
     return "Lymphocyte"
  if "cd8" in name:
     return "Lymphocyte"
  if "neutrophil" in name:
     return "Neutrophils"
  if "macrophage" in name:
     return "Macrophages"
  if "fibroblast" in name:
     return "Fibroblast"
  if "mast" in name:
     return "Mast Cell"
  if "endothelial" in name\
          or "Endo" in name:
     return "Endothelial"
  if name == "b" or \
          "b cell" in name\
          or "b_cell" in name\
          or "b.cell" in name\
          or "bcell" in name:
     return "Lymphocyte"
  return Name

def combineColumns(predMat, colsToCombine):
    ConvertedMat = []
    for lineParts in predMat:
      ConvertedLine = [lineParts[0]]
      for group in colsToCombine:
        groupSum = 0
        for col in group:
          try:
            groupSum += float(lineParts[col+1])
          except:
            continue
        ConvertedLine.append(str(groupSum))
      ConvertedMat.append(ConvertedLine)
    return ConvertedMat

def ReformatPredictions(predictionsFile, AnsCTs):
    """
    Identifies columns in predictions file that correspond to the columns of the answer file
    in the case of multiples pred CTS that map to the same AnsCT, takes the sum
    """
    predMat = []
    for line in open(predictionsFile,"r"):
      splitLine = line.strip().split("\t")
      if len(splitLine) == 1:
         splitLine = line.strip().split(",")
      predMat.append(splitLine)
    if len(predMat[0]) == len(predMat[1]):
       #i.e. something like "gene" fills top left corner
       convertedNames = ConvertNames(predMat[0][1:])
    else:
       convertedNames = ConvertNames(predMat[0])
    colsToCombine = []

    for i in range(len(AnsCTs)):
        colsToCombine.append([])
    for i in range(len(AnsCTs)):
      AnsCT = AnsCTs[i]
      for j in range(len(convertedNames)):
        predCT = convertedNames[j]
        if predCT == AnsCT:
          colsToCombine[i].append(j)
    #print "\t".join(AnsCTs)
    #print "\t".join(predMat[0])
    #print "\t".join(convertedNames)
    #print colsToCombine
    Reformatted = combineColumns(predMat[1:], colsToCombine)
    return Reformatted       

    
def main():

   AnsFile = open(argv[2],"r")
   AnsMat = []
   for line in AnsFile:
     AnsMat.append(line.strip().split("\t"))
     break
   if len(AnsMat[0]) == 1:
      AnsMat[0] = AnsMat[0][0].strip().split(",")
   AnsCTs = ConvertNames(AnsMat[0])[1:]
   NewPreds = ReformatPredictions(argv[1],AnsCTs)
   print "\t" + "\t".join(AnsCTs)
   for line in NewPreds:
      pass
      print "\t".join(line)
main()
