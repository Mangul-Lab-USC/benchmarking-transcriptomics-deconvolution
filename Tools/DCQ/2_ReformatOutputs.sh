for fname in predictions/*;
    do coreFname=$(basename $fname)
	    python 2A_ReformatDCQ.py $fname >FinalPredictions/$coreFname;
    done
