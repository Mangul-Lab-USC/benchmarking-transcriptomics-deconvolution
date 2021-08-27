tsv=".tsv"
for mix in ~/Benchmarking/Inputs/Mixes/*;
   do for ref in ~/Benchmarking/Inputs/RefMats/*;
      do mixCore=$(echo $mix | cut -d "/" -f 9 | cut -d "." -f 1)
      refCore=$(echo $ref | cut -d "/" -f 9 | cut -d "." -f 1)
      sep=_
      outFile="predictions/AbsCibersort_$mixCore$sep$refCore"
      mixHead=$(echo $mixCore | head -c 7)
      refHead=$(echo $refCore | head -c 9)
      echo "Rscript WrapperAbsCibersort.R $mix $ref $outFile$tsv";
      done; done
