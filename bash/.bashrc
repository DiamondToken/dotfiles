#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# nnn

if [ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]; then
	source /usr/share/nnn/quitcd/quitcd.bash_zsh
fi


#PROMPT="%B[%F{magenta}%n%F{yellow}@%F{cyan}%M %F{white}%~]%F{green}$ %f%b"
export EDITOR="emacsclient -c"
export PATH="${PATH}:/home/diamond/.local/bin"
export QT_QPA_PLATFORMTHEME=qt5ct

GREEN="\[$(tput setaf 2)\]"
BLUE="\[$(tput setaf 1)\]"
RESET="\[$(tput sgr0)\]"

PS1="${BLUE}\w\[$tput\] ${GREEN}λ${RESET} "

alias emacs="emacsclient -c"
alias pc="sudo pacman -Syu && notify-send 'pacman is done'"
alias tsm="transmission-remote"
alias systemctl="sudo systemctl"
alias ka="killall"
alias cp="cp -iv"
alias mkd="mkdir -pv"
alias mv="mv -iv"
alias rm="rm -v"
alias mkd="mkdir -pv"
alias al='la -lah'
alias la='ls -lah'
alias ls='ls --color=auto'
alias du='du -h'
alias grep='grep --color=auto'
alias rsh='redshift'
alias nnn='nnn -cC'
#set -o vi
#bind -P
alias sl="ls"
alias pacman="sudo pacman"
use_color=true
