#./0_GenCommands.sh > 1_Commands.sh
#rm predictions/*
qsub -cwd -V -N EPIC -pe shared 4 -l h_data=32G,h_rt=72:00:00 -m a -t 1-5:1 B2_RunIthCommand.sh
#qsub -cwd -V -N Cibersort -pe shared 9 -l h_data=32G,h_rt=72:00:00,highp -m ea -t 1-11:1 2_RunIthCommand.sh
