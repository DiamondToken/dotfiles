#!/bin/bash

dict=$(echo -e "en\nfr" | dmenu -i -p "choose a dict")

endict="/home/diamond/Documents/${dict}/words"

word=$(echo -e "" | dmenu -p "what a word?")


if [ $(grep -ic $word $endict) -eq 0 ]; then
    echo "$word" >> $endict
    notify-send "$word added to $endict"
else
    notify-send "$endict includes $word"
fi
