#!/bin/bash

create_msg() { echo "[ CREATE ] $@"; }

exists_msg() { echo "[ EXISTS ] $@"; }

makelink() {
  lname=$1
  fname=$HOME/$lname
  if [[ ! -e $fname ]]; then
    if [[ ! -e ${fname%/*} ]]; then
      mkdir -p ${fname%/*}
    fi
    #echo $lname :: $fname 
    ln -s $HOME/dotfiles/$lname $fname
    create_msg "$fname"
  else
    exists_msg "$fname"
  fi
}

makelink .bashrc
makelink .vimrc
makelink .config/aurgetrc
makelink .config/compton.conf
makelink .vim/autoload/airline/themes/murmur_modified.vim

for file in .bin/*; do
  makelink $file
done

