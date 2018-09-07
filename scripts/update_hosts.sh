#!/bin/bash
# Author: Erik Lunna
# Date Created: 2014
# Purpose: # Using the extensive HOSTS file from someonewhocares.org, updates
# the hosts file on this computer. Combine with an entry on your crontab 
# schedule to always have an up-to-date hosts file.
# Note: You may have to change the location of your backup and hosts file for
# your system.

BACKUPFILE=~/bak/hosts.bak
HOSTFILE=/etc/hosts

function backuphosts() {
    # Options:Backup the old hosts file.
    cp /etc/hosts "$BACKUPFILE"
}

function gethosts() {
    # Download the new hosts file.
    curl http://someonewhocares.org/hosts/hosts > "$HOSTFILE"

    # Alternative way...
    #wget -P ~/Downloads/ http://someonewhocares.org/hosts/hosts 

    # Alternative: Overwrite new hosts file
    # sudo cp "$_file" /etc/hosts
}

function main() {
    # backuphosts
    gethosts
}

main


# MIT License

# Copyright (c) [2016] [Erik S. Lunna]

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
