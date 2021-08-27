### R code from vignette source 'DeconRNASeq.Rnw'

###################################################
### code chunk number 1: set_width
###################################################
options( width = 60 )


###################################################
### code chunk number 2: packageLoad
###################################################
library(DeconRNASeq)
## multi_tissue: expression profiles for 10 mixing samples from
## multiple tissues 
data(multi_tissue)  
  
datasets <- x.data[,2:11]
signatures <- x.signature.filtered.optimal[,2:6]
proportions <- fraction


###################################################
### code chunk number 3: mixing matrix
###################################################
proportions


###################################################
### code chunk number 4: Expression signature
###################################################
signatures <- x.signature.filtered.optimal[,2:6]
attributes(signatures)[c(1,2)]  


###################################################
### code chunk number 5: Deconolution
###################################################
DeconRNASeq(datasets, signatures, proportions, checksig=FALSE, 
			known.prop = TRUE, use.scale = TRUE, fig = TRUE)


###################################################
### code chunk number 6: Condition_num
###################################################
DeconRNASeq(datasets, signatures, proportions, checksig=TRUE, 
			known.prop = TRUE, use.scale = TRUE, fig = TRUE)


