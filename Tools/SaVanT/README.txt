sample command:

python simpleSAVANT.py Swindell_HumanSkin.csv SaVanT_Signatures_Release01.tab.tsv 50 > myOutFile.txt

generalized format:


python simpleSAVANT.py samples.tsv signatures.tsv N > myOutFile.txt

samples is a tab or comma separated matrix of expression values 
                          (genes are rows, samples are columns)

signatures contains a list of signatures in .tsv format, one row per signature.
Each line is the name of the signature, followed by any number of genes belonging to that signature

N is the number of genes to be taken per signature
