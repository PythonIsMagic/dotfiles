#!/bin/bash

#Author: Erik Lunna,,,
#Date Created: Mon Mar 16 21:11:47 CDT 2015
#Purpose: Recompile the source for YouCompleteMe
#File: compile_ycm

set -e
set -u

cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer
exit 0;
