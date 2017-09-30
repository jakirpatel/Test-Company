#!/bin/bash
#Input file
processusage="/Users/jakirpatel/Desktop/Test/file.txt"

function remotessh(){    
     echo "Arguments"
     echo $1 $2 $3 $4 
     var=$(sshpass -p $3 ssh $2@$1 ) 
     echo $var 
}

# If file exists 
if [[ -f "$processusage" ]]
then
    # read it
	while IFS='|' read -r processdata
    do
        echo $processdata
        a=($processdata)
        remotessh ${a[0]} ${a[1]} ${a[2]} ${a[3]}
    done <"$processusage"
fi
