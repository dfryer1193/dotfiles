#!/bin/bash

create_msg() { echo "[ CREATE ] $@"; }

exists_msg() { echo "[ EXISTS ] $@"; }

makelink() {
  fname=$1

  if [[ ! -e $HOME/$fname ]]; then
    ln -s $HOME/dotfiles/$fname $HOME/$fname
    create_msg "$fname"
  else
    exists_msg "$fname"
  fi
}

makelink .bashrc
makelink .vimrc
makelink .config/aurgetrc
