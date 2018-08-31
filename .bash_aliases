#!/bin/bash
#
# ~/.bash_aliases
#

if $(type exa &>/dev/null) ; then
  alias ls='exa -l --group-directories-first --color=always --git'
else
  alias ls='ls -lvh --group-directories-first --color=always'
fi
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
alias plz='sudo $(fc -ln -1)'
alias dd='dd status=progress'
alias kc='kubectl'
if $(type nvim &>/dev/null) ; then
  alias vim='nvim'
fi

if $(type bat &>/dev/null) ; then
  alias cat='bat'
fi
# from https://salferrarello.com/improve-git-log/
alias gl='git log --graph --pretty=format:"%h - %d %s (%cr) <%an>" | vim -R \
  -c "set hidden nowrap keywordprg=:enew\ \|\ terminal\ \git\ --no-pager\ show |
  nnoremap q :bd!<cr>" -'
