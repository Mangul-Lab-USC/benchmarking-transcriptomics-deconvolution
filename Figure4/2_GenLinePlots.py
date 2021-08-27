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

  ToolList = sorted(df.Tool.unique())
  colorList = ["cornflowerblue","indianred","black","m", "c","darkgreen","midnightblue", "deeppink","orange","silver","lightcoral","lime"]
  for i in range(len(ToolList)):
      print ToolList[i], colorList[i]
 
  fig, ax = plt.subplots()
  ax.grid(axis="y", linestyle = "--")
  ax.set_yscale('log')
  ax.set_xscale('log')
  ax.set_xlim(5,7000)
  ax.set_ylim(0.05,1000000)
  ax.yaxis.tick_right()
  plt.tick_params(axis='x',which='minor',bottom=False,labelbottom=False)
  plt.tick_params(axis='x',which='major',labelbottom=False)
  plt.tick_params(axis='y',which='minor',right=False,labelright=False, left = False, labelleft = False)
  plt.tick_params(axis='y',which='major',labelright=False, labelleft=False)
  plt.xticks([10,50,100,500,1000,2526,5052])
  plt.yticks([.1,1,10,100,1000,10000,100000])
  for i in range(len(ToolList)):
      curTool = ToolList[i]
      curObs = df[df["Tool"] == curTool]
      plt.plot('Size','Time', data=curObs, color = colorList[i], label = curTool, markerSize = 5, marker = "o", markerfacecolor = colorList[i])
  plt.legend(bbox_to_anchor=(1.05,1))
  fig.tight_layout()
  plt.savefig(argv[2],dpi=300)

  #leg = ax.legend(ToolList)#legendList, loc="lower left",prop={'family': 'DejaVu Sans Mono'})
main() 
