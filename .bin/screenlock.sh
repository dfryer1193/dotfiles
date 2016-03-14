#!/bin/bash

scrot /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x7 /tmp/screenshotblur.png
rm -f /tmp/screenshot.png

i3lock-color -i /tmp/screenshotblur.png \
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
