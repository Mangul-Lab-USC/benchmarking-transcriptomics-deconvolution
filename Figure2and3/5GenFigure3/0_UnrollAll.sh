ls ../2ReformatPredictions/ReformattedPredictions/*_CellMix* > FileLists/CellMix.txt
ls ../2ReformatPredictions/ReformattedPredictions/*_PBMC1* > FileLists/PBMC1.txt
ls ../2ReformatPredictions/ReformattedPredictions/*_PBMC2* > FileLists/PBMC2.txt
ls ../2ReformatPredictions/ReformattedPredictions/*_Stromal* > FileLists/Stromal.txt
ls ../2ReformatPredictions/ReformattedPredictions/*_Fram* > FileLists/Fram.txt

python A_NormAndUnroll.py FileLists/CellMix.txt ../../TrueProportions/TruePropsCellMix.tsv > Unrolled_Normed_CellMix.tsv
python A_NormAndUnroll.py FileLists/PBMC1.txt ../../TrueProportions/TruePropsPBMC1.tsv > Unrolled_Normed_PBMC1.tsv
python A_NormAndUnroll.py FileLists/PBMC2.txt ../../TrueProportions/TruePropsPBMC2.tsv > Unrolled_Normed_PBMC2.tsv
python A_NormAndUnroll.py FileLists/Stromal.txt ../../TrueProportions/TruePropsStromal.tsv > Unrolled_Normed_Stromal.tsv
python A_NormAndUnroll.py FileLists/Fram.txt ../../TrueProportions/TruePropsFram.tsv > Unrolled_Normed_Fram.tsv


awk 'FNR==1 && NR!=1 { while (/Tool/) getline; } 1 {print}      ' Unrolled_Normed_PBMC*.tsv > Unrolled_Normed_AllPBMC.tsv

#export DISPLAY=:0.0

#python 1_MakeErrorDistPlot.py Unrolled_Normed_AllPBMC.tsv ErrorDistPlots/AllPBMC.png ErrorDistPlots/Legends/AllPBMC.png > ErrorDistPlots/AUCs/AllPBMC.tsv
#python 1_MakeErrorDistPlot.py Unrolled_Normed_CellMix.tsv ErrorDistPlots/CellMix.png ErrorDistPlots/Legends/CellMix.png > ErrorDistPlots/AUCs/CellMix.tsv
#python 1_MakeErrorDistPlot.py Unrolled_Normed_Fram.tsv ErrorDistPlots/Fram.png ErrorDistPlots/Legends/Fram.png > ErrorDistPlots/AUCs/Fram.tsv
#python 1_MakeErrorDistPlot.py Unrolled_Normed_PBMC1.tsv ErrorDistPlots/PBMC1.png ErrorDistPlots/Legends/PBMC1.png > ErrorDistPlots/AUCs/PBMC1.tsv
#python 1_MakeErrorDistPlot.py Unrolled_Normed_PBMC2.tsv ErrorDistPlots/PBMC2.png ErrorDistPlots/Legends/PBMC2.png > ErrorDistPlots/AUCs/PBMC2.tsv
#python 1_MakeErrorDistPlot.py Unrolled_Normed_Stromal.tsv ErrorDistPlots/Stromal.png ErrorDistPlots/Legends/Stromal.png > ErrorDistPlots/AUCs/Stromal.tsv
