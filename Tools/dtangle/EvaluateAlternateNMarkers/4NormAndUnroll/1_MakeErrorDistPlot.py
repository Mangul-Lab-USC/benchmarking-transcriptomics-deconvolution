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
  print ToolList
  colorList = ["cornflowerblue","indianred","black","m", "c","darkgreen","midnightblue", "deeppink","orange","silver","lightcoral"]
  print len(ToolList), len(colorList)
  for i in range(len(ToolList)):
    Tool = ToolList[i]
    myColor = colorList[i]
    GenLine(df,Tool, myColor,fig, ax)
    #custom_lines = [Line2D([0],[0],color=myColor, lw = 4),\
    #               Line2D([0],[0],color=myColor, lw = 4),\
    #               Line2D([0],[0],color=myColor, lw = 4),\
    #               Line2D([0],[0],color=myColor, lw = 4),\
    #               Line2D([0],[0],color=myColor, lw = 4)\
    #        ]
  ax.set_xlim(1.1,-0.1)
  ax.set_ylim(-0.1,1.1)
  ax.yaxis.set_major_formatter(ticker.PercentFormatter(1))
  ToolList[1] = "DeconRNASeq"
  ax.legend(ToolList, loc="lower left")
  ax.set_ylabel("Percent of Predictions Within Error Range")
  ax.set_xlabel("Error Allowed")
  plt.savefig(argv[2])

      
def GenLine(df,Tool,myColor, fig, ax):

  curErrors = df.loc[df['Tool'] == Tool, 'Error']
  curErrors = curErrors.to_numpy(curErrors)
  curErrors = curErrors.astype(np.float64)
  counts, bins, patches = ax.hist(curErrors, cumulative = True, histtype="step",\
              bins = [x/100000.0 for x in range(0,110000)], density=True, linewidth=1, color = myColor)




  return
main()
