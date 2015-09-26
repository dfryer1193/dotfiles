#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -lv --color=auto'
alias less='less -Rr'
alias clc='clear'
alias qq='exit'
alias aursearch='aurget -Ss'
alias aurinst='aurget -Sy --deps --noedit --noconfirm'
alias aurbuild='aurget -Sb --deps --noedit --noconfirm  --nodiscard'
alias aurupgr='aurget -Syu --deps --noedit --noconfirm'
alias ksp='$STEAM/Kerbal\ Space\ Program/KSP.x86_64'
alias cd..='cd ..'
alias pamcan='pacman'
alias upgrade='sudo pacman -Syu; aurupgr'
alias update='upgrade'
alias tree='tree -C'
alias noblank='xset s off -dpms; xset s noblank'
alias sudo='sudo '
alias spclient='ncmpcpp -p 6601'
alias todo='todo.sh'
alias t='todo.sh'

export HISTSIZE=10000
export EDITOR=vim visudo
export STEAM=$HOME/.local/share/Steam/SteamApps/common
export PATH="$HOME/scripts:$HOME/.bin:$PATH"

function aa_256 ()  {
  local o= i= x=`tput op` cols=`tput cols` y= oo= yy=;
  y=`printf %$(($cols-6))s`;
  yy=${y// /=};
  for i in {0..256}; do
    o=00${i};
    oo=`echo -en "setaf ${i}\nsetab ${i}\n"|tput -S`;
    echo -e "${o:${#o}-3:3} ${oo}${yy}${x}";
  done;
}

# For git+ssh
env=~/.ssh/agent.env

agent_is_running() {
  if [ "$SSH_AUTH_SOCK" ]; then
    # ssh-add returns:
    #   0 = agent running, has keys
    #   1 = agent running, no keys
    #   2 = agent not running
    ssh-add -l >/dev/null 2>&1 || [ $? -eq 1 ]
  else
    false
  fi
}

agent_has_keys() {
  ssh-add -l >/dev/null 2>&1
}

agent_load_env() {
  . "$env" >/dev/null
}

agent_start() {
  (umask 077; ssh-agent >"$env")
  . "$env" >/dev/null
}

ssh_add() {
  if [[ -e $1 ]]; then
    ssh-add $1 >/dev/null
  fi
}

if ! agent_is_running; then
  agent_load_env
fi

if ! agent_is_running; then
  agent_start
  ssh-add
  #try adding github key
  ssh_add ~/.ssh/github_id_rsa
elif ! agent_has_keys; then
  ssh-add
  #try adding github key
  ssh_add ~/.ssh/github_id_rsa
fi

unset env

# make git PS1 available
source /usr/share/git/git-prompt.sh
# allow git-prompt.sh to show git statuses
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUPSTREAM=auto

get_sha(){
  git rev-parse --short HEAD 2>/dev/null
}

battery_status(){
  BATTERY=/sys/class/power_supply/BAT1
 
  CHARGE=`cat $BATTERY/capacity`
  BATSTATE=`cat $BATTERY/status`
  # Colors for humans
  NON='\033[00m'
  BLD='\033[01m'
  RED='\033[01;31m'
  GRN='\033[01;32m'
  YEL='\033[01;33m'
 
  COLOUR="$RED"
 
  case "${BATSTATE}" in
     'Charged')
     BATSTT="$BLD=$NON"
     ;;
     'Charging')
     BATSTT="$BLD+$NON"
     ;;
     'Discharging')
     BATSTT="$BLD-$NON"
     ;;
  esac
 
  # prevent a charge of more than 100% displaying
  if [ "$CHARGE" -gt "99" ]
  then
     CHARGE=100
  fi
 
  # prevent an error if the battery is not in the laptop (e.g. you have two and take out the primary)
  STATE=`cat $BATTERY/present`
   if [ "$STATE" == '0' ]
  then
          echo -e "${RED}nobat"
  exit
  fi
 
  if [ "$CHARGE" -gt "15" ]
  then
     COLOUR="$YEL"
  fi
 
  if [ "$CHARGE" -gt "30" ]
  then
     COLOUR="$GRN"
  fi
  echo -e "${BATSTT}${COLOUR}${CHARGE}%${NON}"
}

set_prompt(){
  last_cmd=$?
  boldRed='\[\e[1;31m\]'
  boldGrn='\[\e[1;32m\]'
  txtRed='\[\e[0;31m\]'
  reset='\[\e[0m\]'
  topLCorner='\342\224\214'
  midLside='\342\224\234'
  btmLCorner='\342\224\224'
  btmDash='\342\224\200'
  check='\342\234\223'
  wrong='\342\234\227'
  bold='\[\e[1;'
  red='31m\]'
  grn='32m\]'
  color=$grn
  last_cmd_stat=$check
  textcolor=$reset
	if [[ $last_cmd == 0 ]]; then
    color=$grn
    textcolor=$reset
    last_cmd_stat=$check
	else
    color=$red
    textcolor=$txtRed
    last_cmd_stat=$wrong
  fi
  
  gitstring=$(__git_ps1 "(%s $(get_sha))")

  PS1="$(echo -ne '\033]2;\u@\h:\w\007')"
  #PS1=""
  PS1=$PS1"$textcolor$topLCorner$bold$color[\u@\h \!]$textcolor\n"
  PS1=$PS1"$midLside$reset`if [ -e /sys/class/power_supply/BAT1 ]; then echo $(battery_status);fi;` $textcolor\A \w\n"
  if [[ ! -z ${gitstring// } ]]; then
    PS1=$PS1"$midLside${gitstring}\n"
  fi
  PS1=$PS1"$btmLCorner$btmDash($bold$color$last_cmd_stat$textcolor)\#\$>$reset "
}

# tmux stuff
if which tmux >/dev/null 2>&1; then
  # if not in tmux session, and no session exists, start a new session
  test -z "$TMUX" && (tmux attach || tmux)
fi

if [[ ! $(type wego &> /dev/null) ]]; then
  wego 1
fi

if [[ ! $(type todo.sh &> /dev/null) ]]; then
  todo.sh pull &>/dev/null
  todo.sh ls
fi

PROMPT_COMMAND='set_prompt'

#PS1='[\u@\h \W]\$ '
