#!/bin/bash

printf "Aliases present in the .bashrc file:\n" 

grep -E '^alias' ~/.bashrc 


