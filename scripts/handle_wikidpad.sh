#!/bin/bash

#Date Created: Tue Nov 25 17:02:25 CST 2014
#Purpose: If WikidPad is open, close it. If lock files exist, delete them.
#File: handle_wikidpad

set -e  
set -u  
# set -o xtrace

trap cleanup INT TERM

function cleanup() {
	echo "Cleanup - handle_wikidpad program error. Aborted."
	exit 1;	
}
# The square brackets are useful to avoid the output of the grep command. 
# Without this the conditional will always return true, because the grep 
# command start a process with the same content of the searched string.

PROGRAM="[W]ikidPad"

# Consider using pgrep instead of grepping ps output.
if ps aux | grep "$PROGRAM" > /dev/null
then
    echo "$PROGRAM is Running"
	echo "Attempting to kill it"
	# This works but leaves the lock files.
	wmctrl -c "- Wikidpad" || true
	sleep 5s
	
	# check if it's still running, then kill it.
	
	if ps aux | grep "$PROGRAM" > /dev/null
	then
		echo "Program unsuccessfully close, attempting kill"
		#$(ps -ef | grep "$PROGRAM" | awk '{print $2}' | xargs kill) $(ps -ef | grep "$PROGRAM" | awk '{print $2}' | xargs kill) || true 
		sleep 5s	
	else
		echo "Program closed gracefully."
	fi
else
    echo "$PROGRAM is already stopped"
fi

echo "Searching for any lock files"
# Check for any lock files
#$(find ~/Dropbox/Wikis/EriksWiki -name *wiki.lock -exec rm {} \;)
find ~/Documents/wiki/ -name "*wiki.lock" -exec rm {} \;
find ~/.WikidPadGlobals -name "*.lock" -exec rm {} \;

#sleep 3s
exit 0;
