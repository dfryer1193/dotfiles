#!/bin/bash

create_msg() { echo "[ CREATE ] $@"; }

exists_msg() { echo "[ EXISTS ] $@"; }

makelink() {
  fname=$HOME/$1
  if [[ ! -e $fname ]]; then
    if [[ ! -e ${fname%/*} ]]; then
      mkdir -p ${fname%/*}
    fi
    ln -s $HOME/dotfiles/${fname##*/} $fname
    create_msg "$fname"
  else
    exists_msg "$fname"
  fi
}

makelink .bashrc
makelink .vimrc
makelink .config/aurgetrc
makelink .config/compton.conf
