for fname in RefMatsWithWhichToMakeSigs/*;
  do fnameHead=$(echo $fname | cut -d "/" -f 2)
    python 2_ConvertToSAVANT.py $fname > ../SAVANTFormat/$fnameHead;
    done
