autoload -U colors && colors

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$HOME/cargo/env":$PATH
export DISPLAY=:0.0
#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
export LC_CTYPE=en_US.UTF-8
export BROWSER="firefox"
export EDITOR="vim"
export VISUAL="vim"
# export QT_QPA_PLATFORMTHEME=qt5ct

export PROMPT_EOL_MARK=""

export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000
# setopt appendhistory
setopt SHARE_HISTORY

set -o emacs
bindkey -e
# PROMPT="%F{red}%~%F{cyan} λ%f "

setopt autocd
setopt correctall
setopt extendedglob
# completion
autoload -U compinit
compinit
_comp_option+=(globdots)
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
# zmodload zsh/complist

# autoload -U promptinit
function wg_ip()
{
    ip_string="$(ip -brief address | awk '{if ($1 == "home") print $3}')"
    echo "${ip_string%/*}"
}

[ -n "$SSH_TTY" -o -n "$SSH_CLIENT" ] && {
    PROMPT="%F{magenta}ÉĈÉÀ_SSH: %f %F{blue}%~ %F"
} || {
    PROMPT="%F{magenta}✦%f %F{blue}%~ %F{yellow}%m%f %F{red}$(wg_ip)%f %F{cyan}λ%f "
}

# promptinit
# alias dmenu="dmenu -H ${XDG_CACHE_HOME}/dmenu_run.hist"
# # [ -f "${HOME}/.aliases" ] && . "${HOME}/.aliases"
# export XDG_CACHE_HOME=$HOME/.cache/

alias al='la -lah'
alias la='ls -lah'
alias ll='ls -lah'
alias ls='ls --color=auto'
alias sl="ls"
alias cp="cp -iv"
alias dmenu="dmenu -H "${XDG_CACHE_HOME:-$HOME/.cache/}/dmenu_run.hist" "$@""
alias du='du -h'
alias df='df -h'
alias dnf="sudo dnf"
alias emacs="emacsclient -c"
alias grep='grep --color=auto'
alias ka="killall"
alias mkdir="mkdir -pv"
alias mv="mv -iv"
alias nnn='nnn -cC'
alias pc="sudo pacman -Syu && notify-send 'pacman is done'"
alias pacman="sudo pacman"
alias iptables="sudo iptables"
alias iptables-save="sudo iptables-save"
alias ip="ip --color=auto"
alias apt="sudo apt"
alias rm="rm -v"
alias rsh='redshift'
alias systemctl="sudo systemctl"
alias tsm="transmission-remote"
#set -o vi
#bind -P

function pasters() {
    local file=${1:-/dev/stdin}
    curl --data-binary @${file} https://paste.rs | tr -d "\n" | xclip -selection clipboard
}

autoload -U select-word-style
select-word-style bash
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ubuntu-style
