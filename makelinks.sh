#!/bin/bash

boldYellow='\e[1;33m'
boldGrn='\e[1;32m'
reset='\e[0m'

create_msg() { echo -e "[ ${boldGrn}CREATE${reset} ] $@"; }

exists_msg() { echo -e "[ ${boldYellow}EXISTS${reset} ] $@"; }

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

makelink .gitignore
git config --global core.excludesfile ~/.gitignore
makelink .bashrc
makelink .bash_aliases
makelink .bash_colors
makelink .tmux.conf
makelink .zshrc
makelink .zshenv
makelink .zsh_aliases

for file in .config/*; do
  makelink $file
done

for file in .bin/*; do
  makelink $file
done
