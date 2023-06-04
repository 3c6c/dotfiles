#
# ~/.bashrc
#
export PATH="/home/goku/.local/bin/:$PATH"
neofetch
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias bluec="bluetoothctl connect FD:98:82:65:39:91"
alias blued="bluetoothctl disconnect"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'
alias opencodedir=". ~/.config/sys-scripts/open-code-dir.sh && clear"

#ffplay -nodisp -autoexit /opt/project-x/project_x_sounds/Welcome-sir.mp3

#/usr/bin/pipewire &
#/usr/bin/pipewire-pulse &
#/usr/bin/pipewire-media-session &

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
