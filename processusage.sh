#!/bin/bash

processusage="file.txt"
function getUsage(){

    if [[ -f "$1" ]]
    then 
      while read ip user pass process <&3; do
        #echo $ip $user $pass $process
        sshpass -p "$pass" ssh $user@$ip  -o StrictHostKeyChecking=no -T " 
        case "$OSTYPE" in
        linux*)
            echo $ip $process $(top -b -n1 | grep $process | head -1 | awk '{print $6}')"kb"
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
