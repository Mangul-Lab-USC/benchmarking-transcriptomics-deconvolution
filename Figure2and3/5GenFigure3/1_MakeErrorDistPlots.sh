#This was necessary (along with Xming) on my machine, which is using windows subsystem in Linux (WSL)
export DISPLAY=:0.0

python 1A_MakeErrorDistPlot.py Unrolled_Normed_AllPBMC.tsv ErrorDistPlots/AllPBMC.png ErrorDistPlots/Legends/AllPBMC.png > ErrorDistPlots/AUCs/AllPBMC.tsv
python 1A_MakeErrorDistPlot.py Unrolled_Normed_CellMix.tsv ErrorDistPlots/CellMix.png ErrorDistPlots/Legends/CellMix.png > ErrorDistPlots/AUCs/CellMix.tsv
python 1A_MakeErrorDistPlot.py Unrolled_Normed_Fram.tsv ErrorDistPlots/Fram.png ErrorDistPlots/Legends/Fram.png > ErrorDistPlots/AUCs/Fram.tsv
python 1A_MakeErrorDistPlot.py Unrolled_Normed_Stromal.tsv ErrorDistPlots/Stromal.png ErrorDistPlots/Legends/Stromal.png > ErrorDistPlots/AUCs/Stromal.tsv

#Make separate plots for PBMC1 and PBMC2, not used in final paper
#python 1A_MakeErrorDistPlot.py Unrolled_Normed_PBMC1.tsv ErrorDistPlots/PBMC1.png ErrorDistPlots/Legends/PBMC1.png > ErrorDistPlots/AUCs/PBMC1.tsv
#python 1A_MakeErrorDistPlot.py Unrolled_Normed_PBMC2.tsv ErrorDistPlots/PBMC2.png ErrorDistPlots/Legends/PBMC2.png > ErrorDistPlots/AUCs/PBMC2.tsv
