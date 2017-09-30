#!/bin/bash

processusage="/Users/jakirpatel/Desktop/Test/file.txt"
function getUsage(){

    if [[ -f "$1" ]]
    then 
      while read ip user pass process <&3; do
        #echo $ip $user $pass $process
        sshpass -p "$pass" ssh $user@$ip  -o StrictHostKeyChecking=no -T " 
        case "$OSTYPE" in
        darwin*)  
            echo $ip $process $(top -pid $(ps -A | grep -m1 $process | awk '{print $1}') -stats MEM -l 1 | grep -A1 'MEM'| grep -v "MEM")
            exit 1
            ;;
        linux*)
            echo $ip $process $(ps -p $process -F --no-headers | awk '{print $6}')"kb"
            exit 1
	    ;;
        *)
            echo "unknown"
            exit 1
            ;;
          esac
        "
    done 3<$1
    else
      echo "File not found"
    fi
}
getUsage $processusage
