tsv=".tsv"
ref="default"
for mix in ~/Benchmarking/Inputs/Mixes/*;
      do mixCore=$(echo $mix | cut -d "/" -f 9 | cut -d "." -f 1)
      sep=_
      outFile="predictions/MCP_$mixCore$sep$ref$tsv"
      mixHead=$(echo $mixCore | head -c 7)
      echo "Rscript WrapperMCP.R $mix $outFile";
      done
