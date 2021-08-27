command=$(sed $SGE_TASK_ID'q;d' B_FramCommands.sh)

echo $command
$command
