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
makelink .Xdefaults
makelink .i3blocks.conf
makelink .i3status.conf
makelink .vim/autoload/airline/themes/murmur_modified.vim

for file in .config/*; do
  makelink $file
done

for file in .bin/*; do
  makelink $file
done

for file in .i3/*; do
  makelink $file
done

for file in .ncmpcpp/*; do
  makelink $file
done

for file in .todo.actions.d/*; do
  makelink $file
done
