#!/bin/bash

#Author: Erik Lunna,,,
#Date Created: Mon Feb  9 20:59:41 CST 2015
#Purpose: Daily log of system and network info.

set -e
set -u

LOGDATE=$(date +%Y-%m-%d-T%H.%M)
_FILE=~/Documents/logs/systemlogs$LOGDATE.log


function label() {
    echo "" >> $_FILE
    echo "################################################################################" >> $_FILE
    echo "$1" >> $_FILE
    echo "################################################################################" >> $_FILE
    echo "" >> $_FILE
}

function main(){
    # Create a new log file.
    touch $_FILE 

    # Put a timestamp on the first line
    echo "$LOGDATE" >> $_FILE
    echo "################################################################################" >> $_FILE

    label "UPTIME"
    uptime >> $_FILE 

    label "Disk Space: df -h"
    df -h >> $_FILE

    label "vmstat - Virtual Memory Statistics"
    vmstat >> $_FILE

    label "/PROC/MEMINFO"
    cat /proc/meminfo >> $_FILE 

    label "ps auxf -- AUXF"
    ps auxf >> $_FILE 

    label "lsof -i  -- Lists open files"
    lsof -i # list open files
}

main
