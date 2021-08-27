./0_GenCommands.sh > 1_Commands.sh
qsub -cwd -V -N DCQ -l h_data=16G,h_rt=5:00:00 -m a -t 1-70:1 2_RunIthCommand.sh
