#!/bin/bash

DUNST_STATE=$(dunstctl is-paused)

dunstctl set-paused true

swaylock \
   --daemonize \
   --screenshots \
   --effect-blur 10x5 \
   --clock \
   --indicator \
   --font "monospace" \
   --timestr "%H.%M.%S" \
   --datestr "%Y.%m.%d" \
   --indicator-radius 100 \
   --indicator-thickness 5 \
   --ring-color 16161633 \
   --ring-caps-lock-color ffe863ff \
   --text-color cccccc \
   --text-clear-color cccccc \
   --text-ver-color cccccc \
   --text-wrong-color cccccc \
   --key-hl-color b7ce42 \
   --ring-ver-color 66aabb \
   --inside-color 161616 \
   --inside-ver-color 161616 \
   --inside-wrong-color 161616 \
   --inside-clear-color 161616

dunstctl set-paused $DUNST_STATE
