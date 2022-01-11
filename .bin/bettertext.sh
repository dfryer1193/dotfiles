#!/bin/bash

#
# From https://snippets.martinwagner.co/2018-03-04/vim-anywhere
#

function setclip {
  xclip -sel c
}

function getclip {
  xclip -sel c -o
}

file=$(mktemp)
alacritty -t vimedit -e nvim ${file}

cat ${file} | setclip
rm ${file}

xdotool key ctrl+v
