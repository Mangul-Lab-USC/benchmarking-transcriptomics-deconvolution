
library(DeconRNASeq)
## multi_tissue: expression profiles for 10 mixing samples from multiple tissues 
data(multi_tissue)  
  
datasets <- x.data[,2:11]
signatures <- x.signature.filtered.optimal[,2:6]
proportions <- fraction

DeconRNASeq(datasets, signatures, proportions, checksig=FALSE, known.prop = TRUE, use.scale = TRUE, fig = TRUE)

#if the true proportions are known, we can estimate the confidence interval for the fraction estimation.
# We used the bootstrapping 100s by selecting the specific number of differentially expressed genes defined by the users and recorded the deconvolution results. 
# We computed the mean proportions for all the tissues we estimated and calculated the confidence interval of the estimated proportions using a t-test.

bootstrap.results <- decon.bootstrap(datasets, signatures, 500, 100)

##########Example 2: For microarray data, GSE19830#########################

data(rat_liver_brain)

datasets <- all.datasets

proportions <- array.proportions

### From two tissue types, we take the mean to generate the signature matrix
liver_means <- rowMeans(array.signatures[,1:3])
brain_means <- rowMeans(array.signatures[,4:6])
mean_signature <- cbind(liver_means, brain_means)
signatures <- as.data.frame(mean_signature)

## For microarray data, sometimes it is better to use the expression data directly. 
## Here, we set use.scale = F to avoid center and/or scale the columns of our data.
DeconRNASeq(datasets, signatures, proportions, checksig=FALSE, known.prop = TRUE, use.scale = FALSE, fig = TRUE)



