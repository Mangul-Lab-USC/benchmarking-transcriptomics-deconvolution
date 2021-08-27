command=$(sed $SGE_TASK_ID'q;d' 1_Commands.sh)

echo $command
$command
