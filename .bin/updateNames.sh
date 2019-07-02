#!/bin/bash

if [[ -z $CHECKUPDATES_DB ]]; then
  CHECKUPDATES_DB="${TMPDIR:-/tmp}/checkup-db-${USER}"
fi

yay -Qu --dbpath "$CHECKUPDATES_DB" 2> /dev/null
