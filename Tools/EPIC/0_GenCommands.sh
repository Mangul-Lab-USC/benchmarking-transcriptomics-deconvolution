tsv=".tsv"
for mix in ~/Benchmarking/Inputs/Mixes/*;
   do for ref in ~/Benchmarking/Inputs/RefMats/*;
      do mixCore=$(basename $mix | cut -d "." -f 1)
      refCore=$(basename $ref)
      sep="_"
      sigFile="~/Benchmarking/Inputs/SignatureLists/EPICFormat/"$refCore
      refCore=$(echo $refCore | cut -d "." -f 1)
      outFile="predictions/EPIC_$mixCore$sep$refCore"
      
      echo "Rscript WrapperEPIC.R $mix $ref $sigFile $outFile$tsv";
      done; done
