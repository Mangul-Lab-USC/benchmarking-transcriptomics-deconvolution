#./0_GenCommands.sh > 1_Commands.sh
rm predictions/*
numTasks=$(cat 1_Commands.sh| wc -l)
qsub -cwd -V -N EPIC -l h_data=16G,h_rt=48:00:00,highp -m a -t 1-$numTasks:1 2_RunIthCommand.sh
