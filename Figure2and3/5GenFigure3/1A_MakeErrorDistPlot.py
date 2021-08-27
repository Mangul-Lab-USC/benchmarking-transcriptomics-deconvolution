import numpy as np
import pandas as pd
import seaborn as sns
from matplotlib import pyplot as plt
from matplotlib import ticker
from matplotlib.lines import Line2D
from sys import *
#export DISPLAY=:0.0
def main():
  df = pd.read_csv(argv[1], sep = "\t")
  
  fig, ax = plt.subplots()
  ToolList = sorted(df.Tool.unique())
  #print ToolList
  colorList = ["cornflowerblue","indianred","black","m", "c","darkgreen","midnightblue", "deeppink","orange","silver","lightcoral","lime"]
  AUCs = [] 
  for i in range(len(ToolList)):
    Tool = ToolList[i]
    myColor = colorList[i]
    print Tool, myColor
    counts, bins, patches = GenLine(df,Tool, myColor,fig, ax)
    AUCs.append(CalcAUC(counts,bins))

  legendList = []
  for i in range(len(ToolList)):
      entry = ToolList[i] + " "*(13-len(ToolList[i])) + "AUC=" + str(round(AUCs[i],2))
      legendList.append(entry)
  ax.set_xlim(.75,0)
  ax.set_ylim(-0.1,1.1)
  ax.yaxis.set_major_formatter(ticker.PercentFormatter(1))


  #leg = ax.legend(ToolList)#legendList, loc="lower left",prop={'family': 'DejaVu Sans Mono'})
 
  ax.set_ylabel("Percentage of Accurate Predictions")
  ax.set_xlabel("Error Rate")
  plt.savefig(argv[2],dpi = 400)

  BestOrder = np.argsort(AUCs)[::-1]

  figure = plt.figure()
  ax = plt.subplot(111)
  for i in BestOrder:
     ax.plot(0,0,label = ToolList[i], color = colorList[i])

  leg = ax.legend(handlelength = 0, handletextpad = 0)
  i = 0
  for text in leg.get_texts():
    text.set_color(colorList[BestOrder[i]])
    i += 1
  plt.savefig(argv[3],dpi=400)
  print "\t".join(ToolList)
  print "\t".join([str(m) for m in AUCs])
      
def GenLine(df,Tool,myColor, fig, ax):

  curErrors = df.loc[df['Tool'] == Tool, 'Error']
  curErrors = curErrors.to_numpy(curErrors)
  curErrors = curErrors.astype(np.float64)
  counts, bins, patches = ax.hist(curErrors, cumulative = True, histtype="step",\
              bins = [x/100000.0 for x in range(0,110000)], density=True, linewidth=1, color = myColor)
  return counts, bins, patches

def CalcAUC(counts, bins):
  Total = sum(counts) * len(bins)
  area = 0
  curCount = 0
  for i in range(len(counts)):
     curCount += counts[i]
     area += curCount
  aoc = area/float(Total)
  return float(aoc)

main()
