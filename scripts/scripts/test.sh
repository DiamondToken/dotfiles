#!/bin/bash

echo "enter a var's value"
read var

if [ $var -eq 7 ]
then
	echo "$var equal to 7"
else
	echo "not equal to seven"
fi
