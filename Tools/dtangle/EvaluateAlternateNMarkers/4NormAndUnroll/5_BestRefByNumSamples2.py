from sys import *

def CountBestRef(ObsSet):
    ResultsD = {}
    for parts in ObsSet:
      Ref = parts[1]
      Sample = parts[2]
      Error = parts[6]
      if Sample not in ResultsD:
        ResultsD[Sample] = {}
      if Ref not in ResultsD[Sample]:
        ResultsD[Sample][Ref] = []
      ResultsD[Sample][Ref].append(float(Error))

    #rint ResultsD.keys() 
    votesPerRef = {}
    for ref in ResultsD[Sample]:
        votesPerRef[ref] = 0
    refList = votesPerRef.keys()
    #rint votesPerRef

    for sample in ResultsD:
       AvgErrorList = []
       for Ref in ResultsD[sample]:
            AvgErrorList.append(sum(ResultsD[sample][Ref]))
       bestChoice = refList[AvgErrorList.index(min(AvgErrorList))]
       votesPerRef[bestChoice] += 1

    return votesPerRef

first = True
inMat = []
for line in open(argv[1],"r"):
    if first:
        first = False
        continue
    inMat.append(line.strip().split("\t"))

byTool = {}
for parts in inMat:
    Tool = parts[0]
    if Tool not in byTool:
        byTool[Tool] = []
    byTool[Tool].append(parts)
first = True
for Tool in byTool:
    Counts = CountBestRef(byTool[Tool])
    #print Tool, Counts
    if first:
       print Tool + "\t" + "\t".join([str(m) for m in Counts])
       first = False
    #print Tool + "\t" + "\t".join([str(m) for m in Counts])
    print Tool + "\t" + "\t".join([str(m) for m in Counts.values()])
    #print Counts

