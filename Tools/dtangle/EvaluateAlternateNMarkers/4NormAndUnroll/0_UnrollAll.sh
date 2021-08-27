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


awk 'NR > 1 { print }' Unrolled_Normed_PBMC2.tsv | cat Unrolled_Normed_PBMC1.tsv > Unrolled_Normed_AllPBMC.tsv

#python 1_make error plots for each instance
#Rscript 2_MakeErrorTables.R
#Rscript 3_MakeGroupedBoxplots.R
#Rscript 4_MakePointRangePlots.R


python 5_BestRefByNumSamples.py Unrolled_Normed_CellMix.tsv > CountsBestRef/CellMix.tsv
python 5_BestRefByNumSamples.py Unrolled_Normed_PBMC2.tsv > CountsBestRef/PBMC2.tsv
python 5_BestRefByNumSamples.py Unrolled_Normed_PBMC1.tsv > CountsBestRef/PBMC1.tsv
python 5_BestRefByNumSamples.py Unrolled_Normed_Stromal.tsv > CountsBestRef/Stromal.tsv
python 5_BestRefByNumSamples.py Unrolled_Normed_AllPBMC.tsv > CountsBestRef/AllPBMC.tsv
python 5_BestRefByNumSamples.py Unrolled_Normed_Fram.tsv > CountsBestRef/Fram.tsv