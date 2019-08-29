#!/bin/bash

if [[ "$#" -ne 1 ]]; then
	echo "Must be called with one of {linux,osx}."
	exit 1
fi

OS=$1

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

if [[ x"$OS" == "xlinux" ]]; then
	cd ${OS}
	makelink .gitignore
	git config --global core.excludesfile ~/.gitignore
	makelink .bashrc
	makelink .bash_aliases
	makelink .bash_colors
	makelink .vimrc
	makelink .Xdefaults
	makelink .tmux.conf
	makelink .i3blocks.conf
	makelink .i3status.conf
	makelink .vim/autoload/airline/themes/murmur_modified.vim
	makelink .todo.cfg
	makelink .cliconkyrc

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

	for file in .weechat/*; do
		makelink $file
	done
fi
