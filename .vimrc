set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai'

call vundle#end()

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set number
set autoindent
set mouse=a
set t_Co=256
set timeoutlen=50
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

filetype plugin on
syntax on
filetype indent on

command! -nargs=* Wrap setlocal tw=80 wrap linebreak nolist
command! -nargs=* TNT NERDTreeTabsToggle

let g:nerdtree_tabs_open_on_console_startup=1

let g:molokai_original=1

let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline_theme='murmur'

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

if has("autocmd")
  autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif
