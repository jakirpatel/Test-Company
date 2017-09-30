#!/bin/bash
#Input file
processusage="/Users/jakirpatel/Desktop/Test/file.txt"

function remotessh(){    
     
     if sshpass -p $3 ssh $2@$1 -o StrictHostKeyChecking=no "echo SUCCESS;";then 
       echo "suceess"
       pidid=$(ps -A | grep -m1 $4 | awk '{print $1}')
       echo $pidid
       top -pid $pidid  -stats MEM -l 1 > process.txt
       memory=$(grep -A1 'MEM' process.txt | grep -v "MEM")
       echo $1 $4 $memory 
       exit	
     else
       echo "Could not establish connection"
     fi
     #var=$(sshpass -p $3 ssh $2@$1 ) 
     #echo $var 
}
#count=0

# If file exists 
#if [[ -f "$processusage" ]]
#then
    # read it
#	while IFS= read -r ip username password process
  #      do
   #       sshpass -p $password ssh $username@$ip ls 
          #remotessh $ip $username $password $process        
          #if [ sshpass -p $3 ssh $2@$1 "echo SUCCESS;" ];then
	   # echo "YES"
          #fi
 #         count=$((count+1))
#	  echo $count
 #       done <"$processusage"
#fi

while read ip user pass process <&3; do 
  #echo $ip $user $pass $process
  sshpass -p "$pass" ssh $user@$ip  -o StrictHostKeyChecking=no -T "
  case "$OSTYPE" in
  linux*)   echo $ip $process $(top -b -n1 | grep $process | head -1 | awk '{print $6}')"kb";;
  darwin*)  echo $ip $process $(top -pid $(ps -A | grep -m1 $process | awk '{print $1}') -stats MEM -l 1 | grep -A1 'MEM'| grep -v "MEM");;
  *)        echo "unknown" ;;
  esac
  "
done 3<file.txt
