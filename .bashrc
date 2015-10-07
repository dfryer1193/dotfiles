#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bash_aliases

export HISTSIZE=10000
if $(type nvim &>/dev/null) ; then
  alias vim='nvim'
  export VISUAL=nvim visudo
  export EDITOR=nvim visudo
else
  export VISUAL=vim visudo
  export EDITOR=vim visudo
fi
export STEAM=$HOME/.local/share/Steam/SteamApps/common
export PATH="$HOME/scripts:$HOME/.bin:$PATH"

. ~/.bash_colors

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

set_prompt(){
  last_cmd=$?
	
  #topLCorner='\342\224\214'
  #midLside='\342\224\234'
  #btmLCorner='\342\224\224'
  #btmDash='\342\224\200'
  #check='\342\234\223'
  #wrong='\342\234\227'

#  #PS1=""
#  PS1=$PS1"$textcolor$topLCorner$bold$color[\u@\h \!]$textcolor\n"
#  PS1=$PS1"$midLside$reset $textcolor\A \w\n"
#  if [[ ! -z ${gitstring// } ]]; then
#    PS1=$PS1"$midLside${gitstring}\n"
#  fi
#  PS1=$PS1"$btmLCorner$btmDash($bold$color$last_cmd_stat$textcolor)\#\$>$reset "

  # Set window title properly
  PS1="$(echo -ne '\033]2;\u@\h:\w\007')"

  if [[ $last_cmd == 0 ]]; then
    color=$GREEN_BOLD
    textcolor=$RESET_COLOR
    #last_cmd_stat=$check
	else
    color=$RED_BOLD
    textcolor=$RED
    #last_cmd_stat=$wrong
  fi

  # clear PS1
  PS1=""

  # todo.sh stuff
  numtasks=$(wc -l ~/.todo/todo.txt | grep -oE "[0-9]{1,}")
  if [[ ! -z ${numtasks} ]]; then
    PS1=$PS11"$color[$textcolor$numtasks$color]$RESET_COLOR"
  fi

  # git stuff
  gitstring=$(~/.bin/gitstatus)

  PS1=$PS1"$color[$textcolor\w"
  PS1=$PS1"$color]$RESET_COLOR"

  if [[ ! -z ${gitstring// } ]]; then 
    PS1=$PS1"$color[$textcolor${gitstring}$color]"
  fi

  PS1=$PS1"$RESET_COLOR "
}

# tmux stuff
if which tmux >/dev/null 2>&1; then
  # if not in tmux session, and no session exists, start a new session
  test -z "$TMUX" && (tmux attach || tmux)
fi

#type wego &>/dev/null && wego 1

type todo.sh &>/dev/null && (todo.sh pull &>/dev/null; todo.sh ls)

PROMPT_COMMAND='set_prompt'

#PS1='[\u@\h \W]\$ '
