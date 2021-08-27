import numpy as np
import pandas as pd
import seaborn as sns
from matplotlib import pyplot as plt
from matplotlib import ticker
from matplotlib.lines import Line2D
from sys import *
#export DISPLAY=:0.0
def main():
  df = open(argv[1], "r")#pd.read_csv(argv[1], sep = "\t")

  topDict = {}
  first = True
  for line in df:
    if first:
        first = False
        continue
    parts = line.strip().split("\t")
    tool = parts[1]
    batchSize = int(parts[2])
    value = float(parts[3])
    if tool not in topDict:
      topDict[tool] = {}
    botDict = topDict[tool]
    if batchSize not in botDict:
      botDict[batchSize] = []
    botDict[batchSize].append(value)


  AverageValues = []
  for Tool in topDict.keys():
     botD = topDict[Tool]
     for size in botD.keys():
        average = sum(botD[size])/len(botD[size])
        AverageValues.append([Tool, size, average])

  for el in AverageValues:
    print "\t".join([str(m) for m in el])
main()
