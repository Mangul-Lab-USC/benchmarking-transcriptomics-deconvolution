for fname in TempPredictions/*;
    do coreFname=$(basename $fname)
	    python 4A_ReformatDCQ.py $fname > predictions/$coreFname;
    done
