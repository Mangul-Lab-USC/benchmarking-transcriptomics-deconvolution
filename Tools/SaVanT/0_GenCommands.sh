tsv=".tsv"
for mix in ../../Inputs/Mixes/*;
   do for ref in ../../Inputs/SignatureLists/SAVANTFormat/*;
      do mixCore=$(basename $mix | cut -d "." -f 1)
      refCore=$(basename $ref | cut -d "." -f 1)
      sep=_
      outFile="predictions/Savant_$mixCore$sep$refCore"
      echo "./WrapperSAVANT.sh $mix $ref $outFile$tsv";
      done; done
