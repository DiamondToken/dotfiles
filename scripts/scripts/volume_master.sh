#!/usr/bin/sh

amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }'
