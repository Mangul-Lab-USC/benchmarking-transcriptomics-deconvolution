Most tools can be run here.
The exceptions are xCell and EPIC, which were run using their online interfaces. The outputs are included.

Each tool directory contains:
	The 0_GenCommands.sh script generates the commands for all combinations of mixture and reference/signature gene list.
        The 1_Command.sh script contains the list of these commands
        The files to run each tool
        A wrapper script, which calls the respective tool taking the format
                ./WrapperScript  $Mix  $Ref  $OutputFile
        The predictions are written to the predictions/ subdirectory
               the naming scheme for output files is:
                     $Tool_$Mixture_$Reference
                 
In the case of DCQ, an extra prefix is adde to each sample name.
This is removed by the script 3A_ReformatDCQ.py, and looped using the 3_ReformatOutput.sh script