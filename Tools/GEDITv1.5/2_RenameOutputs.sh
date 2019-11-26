for fname in predictions/*;
    do coreFname=$(echo $fname| cut -d "/" -f 2| cut -d "_" -f 1-2)
	    prefix="FinalPredictions/GEDIT_"
	    cp $fname $prefix$coreFname;
    done
