#./0_GenCommands.sh > 1_Commands.sh
#rm predictions/*
#qsub -cwd -V -N AbsCibersort -l h_data=16G,h_rt=24:00:00 -m a -t 1-56:1 2_RunIthCommand.sh
qsub -cwd -V -N AbsCibersortFram -pe shared 4 -l h_data=32G,h_rt=48:00:00 -m a 2_RunIthCommand.sh
