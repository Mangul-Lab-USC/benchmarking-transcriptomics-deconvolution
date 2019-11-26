1PoolPredictions:
    The outputs for each combination of tool, mixture and reference are copied here.
    File names are in the format:
         $Tool_$Mixture_$Reference

    These are matrix .tsv or .csv files. First column is samples, first column is cell types.
    Potentially contains extra fields or cell types, depending on the tool and reference used.

2ReformattedOutputs:
    .tsv matrix format, first column is samples, first column is cell types. 
    Cell type names have been converted to match names in respective answer key, and extra fields have been removed

3Unroll:
    Converts and combines matrix outputs for each mixture into format that looks like:
            Tool	Reference	Sample	CellType	Prediction	Answer	Error
e.g.:
            DCQ	BluePrint-Blood.tsv	Mix_1	B Cells		0	0.114803625	0.114803625


4NormPredictions:

     Takes output in 2_ and normalizes each set of predictions, such that the predicted cell types sum to 1.0


	B Cells 	CD4 T Cells	CD8 T Cells	Endo	Fibroblast	Macrophages	Mast Cell
Mix_1	0.00041   	0.1620    	0.4095    	0	0        	0.0259   	0.0383  (sum = .64)

to

	B Cells		CD4 T Cells	CD8 T Cells	Endo	Fibroblast	Macrophages	Mast Cell	
Mix_1	0.00065 	0.2547   	0.6436  	0	0       	0.04070 	0.06022   (sum = 1.0)


5UnrollNormed:
    Same as 3_Unroll, except operates on the normalized outputs in directory 4_NormPredictions/NormedPredictions/
 

TrueProportions:

	Known true proportions for each set of mixtures    