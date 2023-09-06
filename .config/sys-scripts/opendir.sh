#!/bin/bash

ctfslocation=~/Documents/ctfs/
codeplayground=~/Documents/codeplayground/


function main() {
	printf "1) CTFS\n2) CODEPLAYGROUND\n"
	read choice
	case $choice in
	    1) printf "Changing directory now" && cd $ctfslocation || printf "Directory does not exist";;   
	    2) printf "Changing directory now" && cd $codeplayground || printf "Directory does not exist";;
	    *) printf "No Such Directory"
	esac
	printf "\n"
}
main
