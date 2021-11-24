autoload -U colors && colors

export LC_CTYPE=en_US.UTF-8
export BROWSER="brave"
export EDITOR="emacsclient -c"
export QT_QPA_PLATFORMTHEME=qt5ct

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

function pasters() {
    local file=${1:-/dev/stdin}
    curl --data-binary @${file} https://paste.rs | tr -d "\n" | xclip -selection clipboard
}

[ -f "${HOME}/.aliases" ] && . "${HOME}/.aliases"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
