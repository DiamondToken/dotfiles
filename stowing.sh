#!/usr/bin/env sh


stash() {
    rm -rf .vim
    rm -rf .viminfo

    cd stash
    stow -t ~ *
}

root(){
    echo -e "\nSTOWING_ROOT...\n"

    rm /etc/pacman.conf

    cd root
    sudo stow -t / *
}

unroot(){
    echo -e "\nUNSTOWING_ROOT...\n"

    cd root
    sudo stow --delete -t / *
}

$1
