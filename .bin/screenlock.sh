#!/bin/bash

DUNST_STATE=$(dunstctl is-paused)

dunstctl set-paused true

i3lock -B 10 \
   -k \
   -n \
  --insidever-color=dddddd55 \
  --insidewrong-color=e84f4f55 \
  --inside-color=66666655 \
  --ringver-color=ccccccff \
  --ringwrong-color=d23d3dff \
  --ring-color=222222ff \
  --line-uses-inside \
  --keyhl-color=dddddd22 \
  --bshl-color=e84f4f22 \
  --time-str="%H:%M:%S" \
  --time-pos="x+w-(1.5*r):y+h-(0.5*r)" \
  --time-color=ccccccff \
  --time-font=monospace \
  --time-size=25 \
  --date-str=""

dunstctl set-paused $DUNST_STATE
