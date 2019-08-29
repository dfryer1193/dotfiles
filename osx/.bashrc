# Added by nex: https://git.hubteam.com/HubSpot/nex
. ~/.hubspot/shellrc

if [[ -e ~/.bash_aliases ]]; then
  . ~/.bash_aliases
fi

if [[ -e ~/.bash_colors ]]; then
  . ~/.bash_colors
fi

export HISTSIZE=10000
if $(type nvim &>/dev/null) ; then
  export VISUAL=nvim visudo
  export EDITOR=nvim visudo
else
  export VISUAL=vim visudo
  export EDITOR=vim visudo
fi
export PATH="$HOME/scripts:$HOME/.bin:$PATH"
export GIT_FETCH_REMOTE_INFO=true

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

#
# better tab completion
#

# ignore case
bind "set completion-ignore-case on"

# - == _
bind "set completion-map-case on"


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

type todo.sh &>/dev/null && (todo.sh pull &>/dev/null; todo.sh ls)

PROMPT_COMMAND='set_prompt'
