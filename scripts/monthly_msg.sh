#!/bin/bash

#Author: Erik Lunna,,,
#Date Created: Wed Mar  4 11:07:31 CST 2015
#Purpose: Sends a monthly email about monthly maintenence.
#File: monthlyclean.sh

trap cleanup INT TERM

function main() {
    mail -s "Monthly Maintenance Report" eslunna@gmail.com < ~/Documents/dotfiles/scripts/msg.txt 
}

main
exit
