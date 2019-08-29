#!/bin/bash

notify-send DUNST_COMMAND_PAUSE

i3lock -B 10 \
   -k \
   -n \
  --insidevercolor=dddddd55 \
  --insidewrongcolor=e84f4f55 \
  --insidecolor=66666655 \
  --ringvercolor=ccccccff \
  --ringwrongcolor=d23d3dff \
  --ringcolor=222222ff \
  --line-uses-inside \
  --keyhlcolor=dddddd22 \
  --bshlcolor=e84f4f22 \
  --timestr="%H:%M:%S" \
  --timepos="x+w-(1.5*r):y+h-(0.5*r)" \
  --timecolor=ccccccff \
  --time-font=monospace \
  --timesize=25 \
  --datestr=""

notify-send DUNST_COMMAND_RESUME
