#!/bin/bash

# Outputs JSON to i3bar
# Inspired by https://github.com/Joe-Dowd/dots/blob/master/.i3/status.sh

# Color defs
BLACK="#222222"
RED="#e84f4f"
GREEN="#b7ce42"
BLUE="#66aabb"
MAGENTA="#b7416e"
CYAN="#6d878d"
WHITE="#dddddd"

# count, for not doing things every second
# resetTime, time when count resets
count=0
resetTime=$(( 4 * 3600 ))
updatecount=$(~/.bin/updatecount)

process_json() {
  raw_json=$1
  button_name=$(echo ${raw_json} | jshon -e name)
  button_name=$(echo ${button_name} | sed 's/\"//g')
  click_type=$(echo ${raw_json} | jshon -e button)
  case $button_name in
    volume)
      /bin/bash ~/.bin/soundctrl ${click_type} &>/dev/null
      ;;
    mediastate)
      /bin/bash ~/.bin/mediactrl ${click_type} &>/dev/null
      ;;
  esac
}

# send JSON header
echo '{ "version": 1, "click_events": true }'

# Begin an endless array
echo '['

# send empty blocks to make it simple
echo '[]'

#
# Send blocks with info forever
#
while :; do
  echo ",["
    # Status
    # disk info
    echo '{'
      echo "\"name\":\"disk\","
      echo "\"border\":\"$RED\","
      echo "\"border_left\":0,"
      echo "\"border_right\":0,"
      echo "\"border_top\":0,"
      echo "\"background\":\"$BLACK\","
      echo "\"full_text\":\" $(/usr/lib/i3blocks/disk | head -n 1) \""
    echo "}"
    # how many updates?
    # runs every hour
    echo ',{'
      echo "\"name\":\"updates\","
      echo "\"border\":\"$GREEN\","
      echo "\"border_left\":0,"
      echo "\"border_right\":0,"
      echo "\"border_top\":0,"
      echo "\"background\":\"$BLACK\","
      echo "\"full_text\":\" ${updatecount} \""
    echo "}"
    # temperature 
    echo ',{'
      echo "\"name\":\"temperature\","
      echo "\"border\":\"$BLUE\","
      echo "\"border_left\":0,"
      echo "\"border_right\":0,"
      echo "\"border_top\":0,"
      echo "\"background\":\"$BLACK\","
      echo "\"full_text\":\" $(~/.bin/temperature) \""
    echo "}"
    # volume
    echo ',{'
      echo "\"name\":\"volume\","
      echo "\"border\":\"$WHITE\","
      echo "\"border_left\":0,"
      echo "\"border_right\":0,"
      echo "\"border_top\":0,"
      echo "\"background\":\"$BLACK\","
      echo "\"full_text\":\" $(~/.bin/soundstate) \""
    echo "}"
    # media state
    echo ',{'
      echo "\"name\":\"mediastate\","
      echo "\"border\":\"$RED\","
      echo "\"border_left\":0,"
      echo "\"border_right\":0,"
      echo "\"border_top\":0,"
      echo "\"background\":\"$BLACK\","
      echo "\"full_text\":\" $(~/.bin/getmediastate) \""
    echo "}"
    # date
    echo ',{'
      echo "\"name\":\"date\","
      echo "\"border\":\"$GREEN\","
      echo "\"border_left\":0,"
      echo "\"border_right\":0,"
      echo "\"border_top\":0,"
      echo "\"background\":\"$BLACK\","
      echo "\"full_text\":\" $(date '+%a %m.%d.%y') \""
    echo "}"
    # time
    echo ',{'
      echo "\"name\":\"time\","
      echo "\"border\":\"$BLUE\","
      echo "\"border_left\":0,"
      echo "\"border_right\":0,"
      echo "\"border_top\":0,"
      echo "\"background\":\"$BLACK\","
      echo "\"full_text\":\" $(date '+%H.%M.%S') \""
    echo "}"
    # battery (if present)
    battery=$(~/.bin/batstatus)
    if [[ ! -z ${battery} ]]; then
      echo ',{'
        echo "\"name\":\"battery\","
        echo "\"border\":\"$WHITE\","
        echo "\"border_left\":0,"
        echo "\"border_right\":0,"
        echo "\"border_top\":0,"
        echo "\"background\":\"$BLACK\","
        echo "\"full_text\":\" $(~/.bin/batstatus) \""
      echo "}"
    fi
  echo "]"
  # update updatecount every hour
  if [[ $(( count % 3600 )) -eq 0 ]]; then
    updatecount="$(~/.bin/updatecount)"
  fi
  # Reset the count every $resetTime seconds. This is arbitrary, and probably
  # not necessary.
  if [[ $count -ge $resetTime ]]; then
    count=0
  else
    count=$(( count + 1 ))
  fi
  read -t 1 tmp <&0
  tmp=$(echo ${tmp} | sed 's/^,//')
  if [[ ! -z $tmp ]] && [[ "$tmp" != "[" ]]; then
    process_json $tmp
  fi
done
