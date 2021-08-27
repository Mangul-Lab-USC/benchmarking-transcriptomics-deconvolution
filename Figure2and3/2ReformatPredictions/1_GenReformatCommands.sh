for fname in ../1PooledPredictions/*_CellMix*;
do newFname=$(basename $fname)
   echo "python A_FormatPredictions.py $fname ../../TrueProportions/TruePropsCellMix.tsv > ReformattedPredictions/$newFname";
   done

for fname in ../1PooledPredictions/*_PBMC1NormMix*;
do newFname=$(basename $fname)
   echo "python A_FormatPredictions.py $fname ../../TrueProportions/TruePropsPBMC1.tsv > ReformattedPredictions/$newFname";
   done

for fname in ../1PooledPredictions/*_PBMC2NormMix*;
do newFname=$(basename $fname)
   echo "python A_FormatPredictions.py $fname ../../TrueProportions/TruePropsPBMC2.tsv > ReformattedPredictions/$newFname";
   done

for fname in ../1PooledPredictions/*_StromalNormMix*;
do newFname=$(basename $fname)
   echo "python A_FormatPredictions.py $fname ../../TrueProportions/TruePropsStromal.tsv > ReformattedPredictions/$newFname";
   done

for fname in ../1PooledPredictions/*_Fram*;
do newFname=$(basename $fname)
   echo "python B_FormatFram.py $fname ../../TrueProportions/TruePropsFram.tsv > ReformattedPredictions/$newFname";
   done

