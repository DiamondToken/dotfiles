#!/bin/bash

com='setxkbmap -model pc61 -layout'

lang_list=("$com us" "$com ru,us" "$com ca,us -variant fr," )

for i in 0 1 2; do
	echo "${lang_list[$i]}"
done

${lang_list[2]}
