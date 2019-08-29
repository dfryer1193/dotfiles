#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bash_aliases
. ~/.bash_colors

if [[ -e ~/.bash_workstuff ]]; then
  . ~/.bash_workstuff
fi

export HISTSIZE=10000
if $(type nvim &>/dev/null) ; then
  export VISUAL=nvim visudo
  export EDITOR=nvim visudo
else
  export VISUAL=vim visudo
  export EDITOR=vim visudo
fi
export STEAM=$HOME/.local/share/Steam/SteamApps/common
export GOPATH="$HOME/go"
export PATH="$HOME/scripts:$HOME/.bin:$GOPATH/bin:$PATH"
export GIT_FETCH_REMOTE_INFO=true
export BAT_THEME="1337"

#export TERM=xterm-256color

#
# For git+ssh
#

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

#
# Functions
#

# launch programs from CLI
launch(){
  $@ &>/dev/null & disown
}

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

unpack(){
  file=$1

  case $file in
    *.zip)
      unzip $file
      ;;
    *.tar.*|*.tbz2|*.tgz|*.txz)
      tar -xf $file
      ;;
    *.rar)
      unrar x $file
      ;;
    *.7z)
      7za x $file
      ;;
    *)
      echo "I don't know this archive"
      ;;
  esac

}

set_prompt(){
  last_cmd=$?

  # Set window title properly
  PS1="$(echo -ne '\[\033]2;\u@\h:\w\007\]')"

  if [[ $last_cmd == 0 ]]; then
    color=$GREEN_BOLD
    textcolor=$RESET_COLOR
    #last_cmd_stat=$check
	else
    color=$RED_BOLD
    textcolor=$RED
    #last_cmd_stat=$wrong
  fi

  # current dir
  PS1=$PS1"$color[$textcolor\w"
  PS1=$PS1"$color]$RESET_COLOR"

  # TODO: Make this deal with git remote being down

  # git stuff
  if [[ ! -z $GIT_FETCH_REMOTE_INFO ]]; then
    if git rev-parse &>/dev/null; then
      $(git remote update &>/dev/null)
      gitstring=$(~/.bin/gitstatus)
      if [[ ! -z ${gitstring// } ]]; then
        PS1=$PS1"$color[$textcolor${gitstring}$color]"
      fi
    fi
  fi

  PS1=$PS1"$RESET_COLOR "
}

################################################################################
################################################################################
#####                                                                     ######
#####                  Execute before displaying prompt.                  ######
#####                                                                     ######
################################################################################
################################################################################

# always update window size
shopt -s checkwinsize

# trim long paths in prompt
#PROMPT_DIRTRIM=2

#
# better tab completion
#

# ignore case
bind "set completion-ignore-case on"

# - == _
bind "set completion-map-case on"

#
# tmux stuff
#

if which tmux >/dev/null 2>&1; then
  sessions=($(tmux list-sessions  | \
    awk '{print $1}'              | \
    sed 's/://'                   | \
    grep -oE "[0-9]{1,}"))
  # if not in tmux session, and no session exists, start a new session
  test -z "$TMUX" && (tmux attach-session -t ${sessions[0]} || tmux)
fi

# If not in tmux, set the terminal type.
if [[ -z "${TMUX}" ]]; then
  export TERM=xterm-256color
fi

#type wego &>/dev/null && wego 1

type todo.sh &>/dev/null && (todo.sh pull &>/dev/null; todo.sh ls)

PROMPT_COMMAND='set_prompt'

#PS1='[\u@\h \W]\$ '
