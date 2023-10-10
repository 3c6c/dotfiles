#
# ~/.bashrc
#
export PATH="/home/goku/.local/bin/:$PATH"
#neofetch
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la="ls -la --color=auto"
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# User Alias Start
alias bluec="bluetoothctl connect 74:D7:13:7E:53:00"
alias blued="bluetoothctl disconnect"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'
alias opendir=". ~/.config/sys-scripts/opendir.sh"
alias pyenv='source ~/Documents/codeplayground/Django/projects/BlogWebsite/pyenv/bin/activate'
alias anon-term='''echo "current I.P: $(curl ifconfig.me;printf '\n')" && sudo systemctl start tor && . torsocks on && echo "Tor IP: $(curl ifconfig.me;printf '\n')"'''
alias ovpnthm='sudo openvpn ~/GokuBlack69.ovpn'
alias nikto="perl /opt/git/nikto/program/nikto.pl"
alias fclear="python3 /opt/git/cli-fun/fclear.py"
alias nm-r="sudo systemctl restart Network-Manager"
alias sys-s-p="sudo systemctl start postgresql"

## Docker
alias c-dfile="touch Dockerfile"

# User Alias End

#ffplay -nodisp -autoexit /opt/project-x/project_x_sounds/Welcome-sir.mp3

#/usr/bin/pipewire &
#/usr/bin/pipewire-pulse &
#/usr/bin/pipewire-media-session &

colorscript random
HISTSIZE=20000
