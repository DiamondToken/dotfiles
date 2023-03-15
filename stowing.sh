#!/usr/bin/env sh


stowing_stash() {
    cd stash
    stow -t ~ *
}

stowing_root(){
    echo -e "\nSTOWING_ROOT...\n"

    cd root
    sudo stow -t / *
}

unstowing_root(){
    echo -e "\nUNSTOWING_ROOT...\n"

    cd root
    sudo stow --delete -t / *
}

$1
