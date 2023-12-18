#
# ~/.bashrc
#

########################################################################################
#### Setting local paths
########################################################################################
export PATH="/home/goku/.local/bin/:$PATH"
export EDITOR="/usr/bin/nvim"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la="ls -la --color=auto"
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

########################################################################################
#### User Alias Start
########################################################################################
alias bluec="bluetoothctl connect 74:D7:13:7E:53:00"
alias blued="bluetoothctl disconnect"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'
alias notes="/usr/bin/git --git-dir=$HOME/Documents/PrivateNotes.git --work-tree=$HOME/Notes"
alias opendir=". ~/.config/sys-scripts/opendir.sh"
alias pyenv='source ~/Documents/codeplayground/Django/projects/BlogWebsite/pyenv/bin/activate'
alias anon-term='''echo "current I.P: $(curl ifconfig.me;printf '\n')" && sudo systemctl start tor && . torsocks on && echo "Tor IP: $(curl ifconfig.me;printf '\n')"'''
alias ovpnthm='sudo openvpn ~/GokuBlack69.ovpn'
alias nikto="perl /opt/git/nikto/program/nikto.pl"
alias fclear="python3 /opt/git/cli-fun/fclear.py"
alias nm-r="sudo systemctl restart Network-Manager"
alias sys-s-p="sudo systemctl start postgresql"
alias vim="nvim"
## Docker
alias c-dfile="touch Dockerfile"

########################################################################################
#### User Alias End
########################################################################################


########################################################################################
#### Setting History Size
########################################################################################
HISTSIZE=20000
