# Aliases to make daily life easier.

alias ls='ls -lvhBFG'
alias tree='tree -C'
alias plz='sudo $(fc -ln -1)'
if $(type nvim &>/dev/null) ; then
  alias vim='nvim'
  alias vimdiff='nvim -d'
  alias vimwiki='nvim -c "VimwikiIndex"'
  alias today='nvim -c "VimwikiMakeDiaryNote"'
  alias vw='vimwiki'
  alias vwt='today'
  alias vwi='nvim -c "VimwikiDiaryIndex"'
else
  alias vimwiki='vim -c "VimwikiIndex"'
  alias vw='vimwiki'
fi
