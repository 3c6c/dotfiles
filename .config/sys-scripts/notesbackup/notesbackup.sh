#!/bin/bash

#To be executed by cron job.

printf "\nScript executed at $(date)\n" >> /home/goku/.config/sys-scripts/notesbackup/logfile.log


cd ~/Notes
ls -l | awk 'NR>1 {print $6, $7, $8, $9}' > ~/.config/sys-scripts/notesbackup/tempstate.txt


if diff /home/goku/.config/sys-scripts/notesbackup/currentstate.txt /home/goku/.config/sys-scripts/notesbackup/tempstate.txt >/dev/null; then
    printf "The files are identical.\n"
    printf " -----------------------------------------------\n"
    notify-send -u low -t 0 "Notes Backup Reminder" "<span font='9'>There have been no changes to notes directory. (Padh le bsdk!)</span>"
else
    printf "The files are different.\n" # Dunst notification (This file has been changed make sure to push it to github to avoid data loss dumbass!.)
    printf " -----------------------------------------------\n"
    notify-send -u critical -t 0 "Notes Backup Reminder" "<span font='9'>Notes folder has been changed. Make sure to push it to github to avoid data loss!!.</span>"
fi

