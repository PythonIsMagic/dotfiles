#!/bin/bash
# File: make.sh
# Description: This script creates symlinks from the home directory to any desired dotfiles in dotfiles.txt
# Author: Erik Lunna

ROOTUID=0							# Only users w/ $UID 0 have root priv.
E_NOTROOT=87						# Non-root exit error.

dir=~/Documents/dotfiles			# Dotfiles directory
olddir=$dir/dotfiles_old			# Old dotfiles backup directory
FILELIST=$dir/dotfiles.txt
TIME=$(date +"%x %r %Z")

function errorcheck() {
    # Check for super user
    if [ "$UID" -ne "$ROOTUID" ]; then
        echo "Must be root to run this script!"
        exit $E_NOTROOT
    fi

    # Create dotfiles_old in homedir
    mkdir -p $olddir

    # Check for dotfiles directory
    if [ ! -d "$dir" ]; then
        echo "$dir does not exist!"
        exit 1
    fi

    # Check for dotfiles archive directory
    if [ ! -d "$olddir" ]; then
        echo "$olddir does not exist! Creating."
        mkdir $olddir
    fi
}


function main() {
    # Move any existing dotfiles in homedir to the dotfiles_old directory,
    # then create symlinks from the homedir to any files in the dotfiles
    # directory specified in $files

    # Process the files one-by-one
    while IFS= read -r f; do
        # A better (and safer) way is to use Bash parameter expansion
        file="${f/#\~/$HOME}"
        filename=$(basename "$file")

        if [ ! -f "$file" ]; then
			if [ -f "$dir/$filename" ]; then
				# We have the file, so we'll just link it.
				ln --symbolic --verbose "$dir"/"$filename" "$file"
			else
				echo "We don't have $filename..."
			fi

        elif [ -L "$file" ]; then
            echo "$file is already a symbolic link -- Updating pointer"
            ln --symbolic --verbose --interactive "$dir"/"$filename" "$file"
        else
            # We'll add the time the file was moved as a backup feature.
            sudo mv --verbose "$file" "$olddir""$TIME" 2>/dev/null
            ln --symbolic --verbose "$dir"/"$filename" "$file"
        fi
        echo ""
        echo "..."
    done < "$FILELIST"
}

# Make .custom_functions and .custom_aliases if they don't exist
fun=.custom_functions
ali=.custom_aliases

if [ ! -f "$dir/$fun" ]; then
	touch ~/"$dir/$fun"
fi

if [ ! -f "$dir/$ali" ]; then
	touch ~/"$dir/$ali"
fi

echo "DOTFILES setup tool. Version 2.0. Erik Lunna (eslunna@gmail.com)"
echo "Performing error checks..."
echo "----------------------------------------------------------------"
errorcheck

echo ""
echo "Backing up existing config files and creating links to dotfiles."
echo "----------------------------------------------------------------"
main

