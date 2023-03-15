#!/bin/sh

dd bs=4M if=ff.so of=/dev/sdX conv=fsync oflag=direct status=progress
