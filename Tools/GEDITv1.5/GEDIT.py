#!/usr/bin/python
import sys
import getSigGenesModal
import MatrixTools
import HandleInput
import os
import random
import numpy as np

def main():
  """
  usage default:
  python ThisScript.py -mix SamplesMat.tsv -ref RefMat.tsv

  user selected parameters:
  python ThisScript.py -mix SamplesMat.tsv -ref RefMat.tsv -numSigs SigsPerCT -method SigMethod -RS rowscaling
  """
  #where to write results 
  scratchSpace = "scratch/"
  downloadsSpace = "downloads/"

  myArgs = HandleInput.checkInputs(sys.argv[1:])
  if myArgs[0] == False:
    print myArgs[1:]
    return

  rawMix = myArgs[0]
  rawRef = myArgs[1]
  SigsPerCT = myArgs[2]
  minSigs = myArgs[3]
  SigMethod = myArgs[4]
  RowScaling = myArgs[5]
  MixFName = myArgs[6].split("/")[-1]
  RefFName = myArgs[7].split("/")[-1]

  numCTs = len(rawRef[0])-1
  TotalSigs = int(SigsPerCT*numCTs)
 
  stringParams = [MixFName,RefFName,SigsPerCT,minSigs\
                                ,SigMethod,RowScaling]
  
  stringParams = [str(m) for m in stringParams]

  scratchSpace = scratchSpace + "_".join(stringParams) + "_"
  downloadsSpace = downloadsSpace +  "_".join(stringParams) + "_"

  SampleNames = rawMix[0]
  CTNames = rawRef[0]

  mixGenes = []
 
  betMix = rawMix
  betRef = MatrixTools.remove0s(rawRef)
  
  normMix, normRef = MatrixTools.qNormMatrices(betMix,betRef)
  sharedMix, sharedRef = MatrixTools.getSharedRows(normMix,betRef)

  if len(sharedMix) < 1 or len(sharedRef) < 1:
      print "error: no gene names match between reference and mixture"
      return
  if len(sharedMix) < numCTs or len(sharedRef) < numCTs:
      print "warning: only ", len(sharedMix) , " gene names match between reference and mixture"
  #write normalized matrices
  #MatrixTools.writeMatrix([CTNames] + normRef, scratchSpace + "NormRef.tsv") 
  #MatrixTools.writeMatrix([SampleNames] + normMix, scratchSpace + "NormMix.tsv") 
  modeList = SigMethod.split(",")
  SigRef = getSigGenesModal.returnSigMatrix([CTNames] + sharedRef, \
  SigsPerCT, TotalSigs, SigMethod)
  
  SigMix, SigRef = MatrixTools.getSharedRows(sharedMix, SigRef)

  """
  write matrices with only sig genes. files are not used by this program,
  but potentially informative to the user
  """
  
  MatrixTools.writeMatrix([CTNames] + SigRef, scratchSpace + "SigRef.tsv") 
  #MatrixTools.writeMatrix([SampleNames] + SigMix, scratchSpace + "SigMix.tsv") 
  ScaledRef, ScaledMix = MatrixTools.RescaleRows(SigRef[1:], SigMix[1:], RowScaling)
 
  ScaledRef = [CTNames] + ScaledRef
  ScaledMix = [SampleNames] + ScaledMix 

  refFile = scratchSpace + "ScaledRef.tsv"
  mixFile = scratchSpace + "ScaledMix.tsv"

  MatrixTools.writeMatrix(ScaledRef, refFile)
  MatrixTools.writeMatrix(ScaledMix, mixFile)
   
  strDescr = "_".join(stringParams)
  Rscript = "GLM_Decon.R"
  outFile =  "predictions/" + "_".join(stringParams) + "Predictions.tsv"
  print "Rscript", Rscript, mixFile, refFile, outFile
  #predictions = Regression(scratchSpace, CTNames, SampleNames,refFile, mixFile,strDescr)
  #if predictions == False:
  #   return

  #for line in predictions:
  #  print "\t".join([str(el) for el in line])
  return

def readInPredictions(fname):
  PredictionStream = open(fname,"r")
  predictions = []
  first = True
  for line in PredictionStream:
     parts = line.strip().split(",")
     if len(parts) < 2: #i.e. its not csv, actually tsv
       parts = line.strip().split()
     if first:
       first = False
     else:
       parts = parts[1:]
     predictions.append(parts)
  return predictions

def printJobInfo(inputVector, mix, randomizer):
  inLen = len(inputVector[0])
  refLen = len(inputVector[1])
  matched = len(mix)
  print inLen , " genes were submitted<br>"
  print refLen, " genes were in the reference<br>"
  print matched, " genes matched between the reference and submitted file<br>"
  print "Job ID:", randomizer, "<br>"
  print "<br>Parameters:<br>"
  print "NumGenes:\t", inputVector[2], "<br>"
  print "NumTissues:\t", inputVector[3], "<br>"
  print "Method:\t\t", inputVector[4], "<br>"
  print "Intensity Exclusion Ratio:", inputVector[5], "<br>"
  if inputVector[4] == "Entropy":
    print "ZScore Exclusion Ratio", inputVector[6]
  if inputVector[4] == "Zscore":
    print "Entropy Exclusion Ratio", inputVector[7]
  rate = matched/float(min(inLen,refLen))
  if rate < .6:
     print str(rate *100) + "<br>%  matched. This is low enough to suggest a problem"
  print "<br>"
  print "<br>"
  print "<br>"
  print "<br>"

def enoughShared(mix,ref,rawMix,rawRef):
  if len(mix) < 100 or len(ref) < 100:
     print "Content-Type: text/plain\n" 
     print "Error: only" + str(len(mix)-1) + \
     "genes matched between the reference and mixture"
     print "gene names in the mixture look like:"
     print "\t".join([vec[0] for vec in rawMix[:10]])
     print "gene names in the reference look like:"
     print "\t".join([vec[0] for vec in rawRef[:10]])
     return False
  return True

def Regression(scratchSpace, TissueNames, SampleNames, refFile, mixFile, strDescr):

  outFile = scratchSpace + "Out" 
  graphics = "NO"
  Rscript = "GLM_Decon.R"
  
  FNULL = open(os.devnull, "w")
  returnCode = subprocess.call(["Rscript", Rscript, mixFile, \
        refFile,outFile,strDescr],stdout=FNULL, stderr=FNULL)
  FNULL.close() 
  if not returnCode == 0:
     print "failed on first Deconvolution; exit code != 0" 
     print Rscript, mixFile, refFile, outFile
     return False

  predictions = MatrixTools.readMatrix(outFile + "_Predictions.tsv")
  return predictions

def trimMatrix(predictions, SigRef, numTissues, TissueNames):
    temp = [predictions[0]] + [line[1:] for line in predictions[1:]]
    goodCols = MatrixTools.getBestCols(temp, numTissues)
    TrimmedPredictions = MatrixTools.keepColumns(temp, goodCols)
    predictions = [[predictions[i][0]] + TrimmedPredictions[i] for i in range(len(TrimmedPredictions))]
    TrimmedRef = MatrixTools.keepColumns([TissueNames] + SigRef, [0] + [1+x for x in goodCols])
    return TrimmedRef

main()
