#after copying results files to 1PoolPredictions/PooledPredictions/

cd 2ReformatPredictions/
./1_GenCommands.sh > 2_Commands.sh
./2_Commands.sh

cd ../3Unroll/
./0_UnrollAll.sh

cd ../4NormPredictions/
./1_GenNormCommands.sh > 2_NormCommands.sh
./2_NormCommands.sh

cd ../5UnrollNormed/
./0_UnrollAll.sh
cd ..
