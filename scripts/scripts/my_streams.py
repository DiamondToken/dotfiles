#!/bin/python

import os


streams_list = ["https://www.twitch.tv/artifixofficial",
        "https://www.twitch.tv/speedrun"]

for stream in streams_list:
    os.system("streamlink %s" % stream)
