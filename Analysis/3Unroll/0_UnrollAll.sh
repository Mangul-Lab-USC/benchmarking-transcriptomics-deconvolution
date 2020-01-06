ls ../2ReformatPredictions/ReformattedPredictions/*_CellMix* > FileLists/CellMix.txt
ls ../2ReformatPredictions/ReformattedPredictions/*_PBMC1Norm* > FileLists/PBMC1.txt
ls ../2ReformatPredictions/ReformattedPredictions/*_PBMC2Norm* > FileLists/PBMC2.txt
ls ../2ReformatPredictions/ReformattedPredictions/*_StromalNorm* > FileLists/Stromal.txt
ls ../2ReformatPredictions/ReformattedPredictions/*_Fram* > FileLists/Fram.txt


python A_Unroll.py FileLists/CellMix.txt ../../TrueProportions/TruePropsCellMix.tsv > Unrolled_CellMix.tsv
python A_Unroll.py FileLists/PBMC1.txt ../../TrueProportions/TruePropsPBMC1.tsv > Unrolled_PBMC1.tsv
python A_Unroll.py FileLists/PBMC2.txt ../../TrueProportions/TruePropsPBMC2.tsv > Unrolled_PBMC2.tsv
python A_Unroll.py FileLists/Stromal.txt ../../TrueProportions/TruePropsStromal.tsv > Unrolled_Stromal.tsv
python A_Unroll.py FileLists/Fram.txt ../../TrueProportions/TruePropsFram.tsv > Unrolled_Fram.tsv
