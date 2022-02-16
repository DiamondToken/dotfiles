autoload -U colors && colors

export LC_CTYPE=en_US.UTF-8
export BROWSER="firefox"
export EDITOR="emacsclient -c"
# export QT_QPA_PLATFORMTHEME=qt5ct

# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=ibus
# export XMODIFIERS=@im=ibus
 
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=2000
export SAVEHIST=2000
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
# promptinit
PROMPT="%F{red}%~%F{cyan} λ%f "

# alias ls="ls --color=always"
# alias la="ls -lah"
# alias rsh="redshift"
# alias grep="grep --color=always"
# alias ka="killall"
# alias pc="sudo pacman -Syu"
# alias nnn="nnn -C"
# alias dmenu="dmenu -H ${XDG_CACHE_HOME}/dmenu_run.hist"
# alias tsm="transmission-remote"
# # [ -f "${HOME}/.aliases" ] && . "${HOME}/.aliases"
# export XDG_CACHE_HOME=$HOME/.cache/

alias al='la -lah'
alias la='ls -lah'
alias ls='ls --color=auto'
alias sl="ls"
alias cp="cp -iv"
alias dmenu="dmenu -H "${XDG_CACHE_HOME:-$HOME/.cache/}/dmenu_run.hist" "$@""
alias du='du -h'
alias emacs="emacsclient -c"
alias grep='grep --color=auto'
alias ka="killall"
alias mkdir="mkdir -pv"
alias mv="mv -iv"
alias nnn='nnn -cC'
alias pc="sudo pacman -Syu && notify-send 'pacman is done'"
alias pacman="sudo pacman"
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

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
