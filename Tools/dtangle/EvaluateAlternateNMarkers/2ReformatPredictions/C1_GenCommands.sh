for fname in ../1PoolPredictions/PooledPredictions/*_CellMix*;
do newFname=$(basename $fname)
   echo "python C_FormatBoth.py $fname ../../TrueProportions/TruePropsCellMix.tsv > ReformattedPredictions/$newFname";
   done

for fname in ../1PoolPredictions/PooledPredictions/*_PBMC1NormMix*;
do newFname=$(basename $fname)
   echo "python C_FormatBoth.py $fname ../../TrueProportions/TruePropsPBMC1.tsv > ReformattedPredictions/$newFname";
   done

for fname in ../1PoolPredictions/PooledPredictions/*_PBMC2NormMix*;
do newFname=$(basename $fname)
   echo "python C_FormatBoth.py $fname ../../TrueProportions/TruePropsPBMC2.tsv > ReformattedPredictions/$newFname";
   done

for fname in ../1PoolPredictions/PooledPredictions/*_StromalNormMix*;
do newFname=$(basename $fname)
   echo "python C_FormatBoth.py $fname ../../TrueProportions/TruePropsStromal.tsv > ReformattedPredictions/$newFname";
   done

for fname in ../1PoolPredictions/PooledPredictions/*_Fram*;
do newFname=$(basename $fname)
   echo "python C_FormatBoth.py $fname ../../TrueProportions/TruePropsFram.tsv > ReformattedPredictions/$newFname";
   done

