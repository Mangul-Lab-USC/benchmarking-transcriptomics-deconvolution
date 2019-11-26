for fname in ../SAVANTFormat/*;
do  fnameHead=$(basename $fname)
    python 6_ConvertToEPIC.py $fname > ../EPICFormat/$fnameHead;
    done
