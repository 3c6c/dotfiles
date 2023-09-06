#!/bin/bash

codelocation=~/Documents/codeplayground/
function main() {
 echo "Enter a directory from below:"
 ls $codelocation
 read choice
 cd $codelocation"$choice"
}
main
