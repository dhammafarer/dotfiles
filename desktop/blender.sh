#!/bin/bash

/usr/bin/sxhkd -c /home/pl/.config/sxhkd/blender.sxhkdrc /home/pl/.config/sxhkd/sxhkdrc &
notify-send "Blender mappings"

/home/pl/Apps/blender-3.4.0-linux-x64/blender $@
