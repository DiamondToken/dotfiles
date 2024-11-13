export PATH=$HOME/scripts/:$PATH
export PATH=$HOME/.local/bin/:$PATH
export EDITOR="emacsclient -c"
alias nnn="nnn -C"

GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx

GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus


[ -n "$SSH_TTY" -o -n "$SSH_CLIENT" ] && {
    return
}

startx
xset m 0 0
