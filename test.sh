#!/bin/bash     
# 2018-03-03 - Scans manifest directory and removes spaces from files
     
RUN_DATE=$(date +%Y-%m-%d)
LOGFILE=./manifest-space-remover-"$RUN_DATE".log

#regex pattern for a space
REGEX_PATTERN=" |'"

exec 3>&1 4>&2
exec 1>>"$LOGFILE" 2>&1

function traverse_manifests() {
    for file in "$1"/*
    do
        if [ ! -d "${file}" ] 
        then
            [ -e "$file" ] || continue 
            echo "$(date "+%Y-%m-%d %T") : Checking file - $file" 
            #check if file has a space, if so rename
            if [[ "$file" =~ $REGEX_PATTERN ]]
            then
                echo "$(date "+%Y-%m-%d %T") : $file contains a space, so will remove and rename."
                mv "$file" "${file// /}"
                echo "$(date "+%Y-%m-%d %T") : $file has been renamed with the space removed."
            fi
        else
            echo "$(date "+%Y-%m-%d %T") : Traversing to: ${file}"
            traverse_manifests "${file}"
        fi
    done
}

function main() {
    echo "$(date "+%Y-%m-%d %T") : Starting rename check in directory: $1" 
    traverse_manifests "$1"
}

main "$1"
echo "$(date "+%Y-%m-%d %T") : Rename process complete."
