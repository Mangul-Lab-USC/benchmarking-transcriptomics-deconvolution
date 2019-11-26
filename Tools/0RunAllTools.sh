cd Cibersort/
./0_GenCommands.sh > 1_Commands.sh
./1_Commands.sh
cd ../DCQ
./0_GenCommands.sh > 1_Commands.sh
./1_Commands.sh
./2_ReformatOutput.sh
cd ../DeconRNASeq/
./0_GenCommands.sh > 1_Commands.sh
./1_Commands.sh
cd ../GEDITv1.5/
./0_GenCommands.sh > 1_Commands.sh
./1_Commands.sh
./2_RenameOutputs.sh
cd ../SaVanT/
./0_GenCommands.sh > 1_Commands.sh
./1_Commands.sh
cd ../dtangle
./0_GenCommands.sh > 1_Commands.sh
./1_Commands.sh
cd ..
