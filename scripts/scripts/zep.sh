#!/usr/bin/env bash

Xephyr -br -ac -reset -screen 1920x1080 :1 &
sleep 1s
export DISPLAY=:1

DISPLAY=:1 /home/diamond/repos/dwm/dwm &
DISPLAY=:1 st &
