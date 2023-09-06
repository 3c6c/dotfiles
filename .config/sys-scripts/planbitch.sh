#!/bin/bash

# Variables
plandir="~/.config/sys-scripts/plans/"
planfile="~/.config/sys-scripts/plans/plans.txt"
echo "What would you like bitch! \n 1. See your plans \n 2. Add another plan \n 3. Delete a plan \n 4. edit a plan"

read choice
echo "Checking your plans"
if [ ! -s "$planfile" ]; then
	echo "There are no plans currently"
else
	
