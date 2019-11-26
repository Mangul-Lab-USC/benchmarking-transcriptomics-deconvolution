for fname in ../2ReformatPredictions/ReformattedPredictions/*;
  do newFname=$(basename $fname)
	    echo "python B_NormFile.py $fname > NormedPredictions/$newFname";
    done
