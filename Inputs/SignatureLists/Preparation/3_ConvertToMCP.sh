for fname in ../SAVANTFormat/*;
do  fnameHead=$(basename $fname) 
   python 4_ConvertToMCP.py $fname > ../MCPCounterFormat/$fnameHead;
    done
