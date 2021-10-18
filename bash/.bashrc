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
export PATH="${PATH}:/home/diamond/scripts"
export QT_QPA_PLATFORMTHEME=qt5ct

GREEN="\[$(tput setaf 2)\]"
BLUE="\[$(tput setaf 1)\]"
RESET="\[$(tput sgr0)\]"

PS1="${BLUE}\w\[$tput\] ${GREEN}λ${RESET} "

alias al='la -lah'
alias cp="cp -iv"
alias dmenu="dmenu -H "${XDG_CACHE_HOME:-$HOME/.cache/}/dmenu_run.hist" "$@""
alias du='du -h'
alias emacs="emacsclient -c"
alias grep='grep --color=auto'
alias ka="killall"
alias la='ls -lah'
alias ls='ls --color=auto'
alias mkd="mkdir -pv"
alias mkd="mkdir -pv"
alias mv="mv -iv"
alias nnn='nnn -cC'
alias pc="sudo pacman -Syu && notify-send 'pacman is done'"
alias rm="rm -v"
alias rsh='redshift'
alias systemctl="sudo systemctl"
alias tsm="transmission-remote"
#set -o vi
#bind -P
alias sl="ls"
alias pacman="sudo pacman"
use_color=true
