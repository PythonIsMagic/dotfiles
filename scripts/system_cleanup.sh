#!/bin/bash

# Author: lunatunez
# Date Created: Wed Nov  2 22:13:48 EDT 2016
# Purpose: Execute system clean for Linux Mint 19

# set -o pipefail
set -o xtrace
set -e
set -u


YELLOW="\033[1;33m"
RED="\033[0;31m"
ENDCOLOR="\033[0m"

if [ "$USER" != root ]; then
  echo -e "$RED Error: must be root"
  echo -e "$YELLOW Exiting... $ENDCOLOR"
  exit 0
fi

echo "Running System Cleanup."
echo "Date: "
echo "Host machine: "
echo "User: "

	
echo -e "$YELLOW Updating Packages...$ENDCOLOR"

# Package cleanup:
echo "Running sudo apt-get update && sudo apt-get upgrade"
sudo apt-get -y -qq update && sudo apt-get -y upgrade
echo ""

echo "Running sudo apt-get clean"
sudo apt-get -y autoclean
echo ""

echo -e "$YELLOW Cleaning up Packages...$ENDCOLOR"
echo "Running sudo apt-get autoremove"
sudo apt-get -y autoremove
echo ""

echo "Updating package lists and checking for broken dependencies"
sudo apt-get check
echo ""


echo -e "$YELLOW Clearing the thumbnail cache...$ENDCOLOR"
rm -f ~/.cache/thumbnails/normal/*
rm -v -f ~/.cache/thumbnails/*/*.png ~/.thumbnails/*/*.png
rm -v -f ~/.cache/thumbnails/*/*/*.png ~/.thumbnails/*/*/*.png


echo -e "$YELLOW Removing old config files...$ENDCOLOR"
OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
sudo aptitude -y purge "$OLDCONF"


# Clean the trash bin
echo -e "$YELLOW Taking out the Trash!...$ENDCOLOR"
sudo rm -rfv ~/.local/share/Trash/*
sudo rm -rfv /home/*/.local/share/Trash/*/** # For every user
sudo rm -rfv /root/.local/share/Trash/*/** 
echo ""
# Purge leftover config files:
aptitude purge ~c  # (CAREFUL WITH THIS)
echo ""
	
echo -e "$YELLOW Current Kernel...$ENDCOLOR"
echo "current kernel"
uname -r

echo -e "$YELLOW Installed Kernels....$ENDCOLOR"
dpkg --list | grep linux-image

echo -e "$YELLOW All available kernels for download....$ENDCOLOR"
apt-cache search linux-image

# To Remove an old kernel:
# $ sudo apt-get purge linux-image-x.x.x.x-generic

echo ""
echo -e "$YELLOW Updating grub2....$ENDCOLOR"
sudo update-grub2


echo ""
echo -e "$YELLOW Drive Space Used by Cached Files....$ENDCOLOR"
du -sh /var/cache/apt/archives
