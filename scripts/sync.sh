#!/bin/bash

#Author: Erik Lunna,,,
#Date Created: Fri Feb 20 10:43:06 CST 2015
#Purpose: Use rsync to backup scripts
#File: sync.sh

##############################
# Checks to add...
# Check all directories exist.
# Check for room on the destination?
# Check that the log file exists. And that we successfully wrote it.

# set -o pipefail
# set -o xtrace
set -e
set -u

TIMESTAMP=$(date)
_log=~/Documents/logs/rsync.log"$TIMESTAMP"
STORAGE=/media/zeus
EXTERNAL="/media/lunatunez/My Passport"

if [ ! -e "$_log" ]; then
	touch "$_log";
fi

# Append a header to the same file.
echo "################################################################################" | tee -a  "$_log"
echo "RSYNC LOG FOR $TIMESTAMP" | tee -a  "$_log"
echo "" | tee -a  "$_log"

# Also logs the activity to ~/logs/rsync.log

# RSYNC note:
# rsync SOURCE DESTINATION
# -a is recursive
# -v is verbose
# Remember the trailing directory slashes (/) are necessary

# Backup important files to local /bak
rsync -av --delete ~/Documents/dev/ ~/Documents/bak/rsync_dev/ | tee -a "$_log"
rsync -av --delete ~/Documents/dotfiles/ ~/Documents/bak/rsync_dotfiles/ | tee -a "$_log"
rsync -av --delete ~/Documents/scripts/ ~/Documents/bak/rsync_scripts/ | tee -a "$_log"
rsync -av --delete ~/Documents/wiki/ ~/Documents/bak/rsync_wiki/ | tee -a "$_log"
rsync -av --delete ~/Documents/biz/ ~/Documents/bak/rsync_biz/ | tee -a "$_log"
rsync -av --delete ~/Documents/projects/ ~/Documents/bak/rsync_projects/ | tee -a "$_log"
rsync -av --delete ~/Documents/hpc/ ~/Documents/bak/rsync_hpc/ | tee -a "$_log"


# Backup Documents directory to secondary hard drive
rsync -av --delete ~/ "$STORAGE"/"$USER"/Documents/ | tee -a "$_log"


# Backup Documents directory to external HD
if mount | grep Passport > /dev/null; then
    echo "$EXTERNAL mounted; syncing home directory and multimedia."

    # Backup media files to an external HD from the secondary HD
    rsync -av --delete "$STORAGE"/multimedia/ "$EXTERNAL"/multimedia/ | tee -a "$_log"

    # Backup $HOME to external HD
    rsync -av --delete ~/ "$EXTERNAL"/"$USER"/Documents/ | tee -a "$_log"

else
    echo "$EXTERNAL not mounted" | tee -a "$_log"
fi

exit 0;
