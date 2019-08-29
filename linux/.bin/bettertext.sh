#!/bin/bash

#
# From https://snippets.martinwagner.co/2018-03-04/vim-anywhere
#

function setclip {
  xclip -selection c
}

function getclip {
  xclip -selection clipboard -o
}

file=$(mktemp)
termite -t vimedit -e "nvim '${file}'"

cat ${file} | setclip
#rm ${file}

xdotool key ctrl+v
