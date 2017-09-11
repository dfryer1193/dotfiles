#!/bin/bash

if $(type i3lock &>/dev/null); then
  locker=i3lock
else
  locker=i3lock-color
fi

scrot /tmp/screenshot.png
if [ -e ~/.bin/stackblur ] ; then
  ~/.bin/stackblur \
    -in /tmp/screenshot.png \
    -out /tmp/screenshotblur.png \
    -radius 7 &> /dev/null
else
  convert /tmp/screenshot.png -blur 0x7 /tmp/screenshotblur.png
fi
rm -f /tmp/screenshot.png

$locker -i /tmp/screenshotblur.png \
  --insidevercolor=dddddd55 \
  --insidewrongcolor=e84f4f55 \
  --insidecolor=66666655 \
  --ringvercolor=ccccccff \
  --ringwrongcolor=d23d3dff \
  --ringcolor=222222ff \
  --textcolor=00000000 \
  --keyhlcolor=dddddd22 \
  --bshlcolor=e84f4f22

# cleanup
rm -f /tmp/screenshotblur.png
