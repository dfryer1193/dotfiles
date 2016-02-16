#!/bin/bash

scrot /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x7 /tmp/screenshotblur.png
i3lock -i /tmp/screenshotblur.png
