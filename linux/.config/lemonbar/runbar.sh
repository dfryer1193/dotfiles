#!/bin/bash

# bar config
. ~/.config/lemonbar/bar_config

# get the workspace from i3
ws() {
  while read line; do
    if [ "$line" = true ]; then
      break
    else
      workspace="$line"
    fi
  done < <(i3-msg -t get_workspaces | jshon -a -e num -u -p -e focused -u)
  workspace=$(( $workspace - 1 ))
  array=(${WORKSPACES})
  for i in ${!array[@]}; do
    if [ "$workspace" -eq "$i" ]; then
      ret=$ret"%{F$RED}${array[i]} "
    else
      ret=$ret"%{B$BG}%{F$FG}${array[i]} "
    fi
  done
  echo $ret
}

# cpu temp
temp() {
  temp=$(sensors | awk '/Physical id 0:/ {print $4}')
  echo "CPU: ${temp}"
}

# clock
clock() {
  clock=$(date "+%a %m.%d.%y %H.%M.%S")
  echo $clock
}

# media state
mus() {
  . ~/.bin/getmediastate
}

# networking
net() {
  echo $(hostname -i)
}

# disk space
disk() {
  space=($(/usr/lib/i3blocks/disk))
  echo ${space[0]}
}

# volume
vol() {
  . ~/.bin/soundstate
}

while :; do
  echo "// $(ws) // %{c}// $(mus) // %{Sl}%{r}// $(disk) // $(net) // $(temp) // %{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:} $(vol)% %{A}%{A} // $(clock) //"
  sleep 0.5
done | lemonbar -g ${PW}x${PH}+${PWO}+${PO} -f $FONT1 -B "$BG" -F "$FG" -d -p | \
  while read line; do eval "$line"; done &
