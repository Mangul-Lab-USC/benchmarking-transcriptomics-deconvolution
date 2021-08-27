#after copying results files to 1PoolPredictions/PooledPredictions/

#if desired clear intermediate files from previous run
#rm 2ReformatPredictions/ReformattedPredictions/*

#Reformat tool outputs, such that cell type labels
#match those in the corresponding true propotions file

cd 2ReformatPredictions/
#if files have changed (e.g. adding now tools or datasets), regenerate commands
#./1_GenCommands.sh > 2_ReformatCommands.sh
./2_ReformatCommands.sh



#Combine tool outputs from many matrix .tsv files into a single file of format:
#Tool  Reference  SampleName   CellType Prediction Answer Error SqError
#One line for each prediction, tab separated. One file for each test mixture

cd ../3CombineAndUnroll/
./0_UnrollAll.sh
#This also combines 2 sets of PBMC mixtures into 1 file


#Generate Figures

cd ../4GenFigures/
Rscript 1_GenFigure1.R
