#!/bin/bash

pactl load-module module-null-sink sink_name=Virtual1
pactl load-module module-loopback source=alsa_input.usb-GN_Netcom_A_S_Jabra_EVOLVE_20_MS_000559B712DE0A-00.mono-fallback sink=Virtual1
pactl load-module module-loopback source=Virtual1.monitor sink=alsa_output.usb-GN_Netcom_A_S_Jabra_EVOLVE_20_MS_000559B712DE0A-00.analog-stereo
