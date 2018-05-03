#!/bin/bash     
# 2018-03-03 - Scans manifest directory and removes spaces 
     
MANIFEST_DIR=Data
MANIFEST_EXT=.txt
RUN_DATE=$(date +%Y-%m-%d)
LOGFILE=/Users/christopherbautista/src/sandbox-bash/test-"$RUN_DATE".log
exec 3>&1 4>&2
exec 1>>"$LOGFILE" 2>&1

echo "$(date "+%Y-%m-%d %T") : Starting rename check in directory: $MANIFEST_DIR " 
for file in "$MANIFEST_DIR"/*"$MANIFEST_EXT"; do
    [ -e "$file" ] || continue
    echo "$(date "+%Y-%m-%d %T") : Checking file - $file" 

    #check if file has a space, if so rename
    if [[ "$file" =~ \ |\' ]] 
    then
        echo "$(date "+%Y-%m-%d %T") : $file contains a space, so will rename." 
        mv "$file" "${file// /}"
    fi
done
echo "$(date "+%Y-%m-%d %T") : Rename process complete."
