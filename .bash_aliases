#!/bin/bash
#
# ~/.bash_aliases
#

alias ls='ls -lvh --group-directories-first --color=always'
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
