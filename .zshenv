export HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
export SAVEHIST=10000
export HISTSIZE=10000
if $(type nvim &>/dev/null) ; then
  export VISUAL=nvim visudo
  export EDITOR=nvim visudo
else
  export VISUAL=vim visudo
  export EDITOR=vim visudo
fi

export GOPATH="$HOME/go"
export PATH="$HOME/scripts:$HOME/.bin:$HOME/go/bin:$PATH:/opt/anaconda3/bin"
export GIT_FETCH_REMOTE_INFO=true
