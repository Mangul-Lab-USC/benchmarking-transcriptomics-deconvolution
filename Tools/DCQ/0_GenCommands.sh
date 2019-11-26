tsv=".tsv"
for mix in ../../Inputs/Mixes/*;
   do for ref in ../../Inputs/RefMats/*;
      do mixCore=$(basename $mix | cut -d "." -f 1)
      refCore=$(basename $ref | cut -d "." -f 1)
      sep=_
      outFile="predictions/DCQ_$mixCore$sep$refCore"
      echo "./WrapperDCQ.sh $mix $ref $outFile$tsv";
      done; done
