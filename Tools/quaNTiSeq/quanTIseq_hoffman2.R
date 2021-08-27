library(dplyr)
library(ggplot2)
library(tidyr)
library(immunedeconv)
library(tibble)

install.packages("remotes")
remotes::install_github("icbi-lab/immunedeconv")

# Run quanTIseq deconvolution.
results <- deconvolute_quantiseq.default(
  mix.mat, # Mixture matrix.
  arrays = FALSE, # set arrays to TRUE if using microarray data.
  signame = "TIL10",
  tumor = FALSE,
  mRNAscale = TRUE,
  method = "lsei",
  )

write.table(results, file = "quanTIseq_results.txt", sep = "\t")