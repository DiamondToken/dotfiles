#!/usr/bin/env bash

Xephyr -br -ac -noreset -screen 720*480 :1 &
sleep 1s
export DISPLAY=:1

DISPLAY=:1 /home/diamond/myrepos/xlib_prog/core &
#DISPLAY=:1 st &
