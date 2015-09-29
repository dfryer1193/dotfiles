set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'Align'
Plugin 'cecutil'
Plugin 'vis'

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'tpope/vim-endwise'
Plugin 'rstacruz/vim-closer'
Plugin 'atweiden/vim-dragvisuals'
Plugin 'keith/tmux.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set number
set cursorline
set autoindent
set pastetoggle=<F2>
set title
set exrc
set mouse=a
set t_Co=256
set timeoutlen=50
set laststatus=2
set colorcolumn=81
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set splitbelow " new h splits go below
set splitright " new v splits go right

filetype plugin on
syntax on
filetype indent on

vmap Q gq
nmap Q gqap

nnoremap j gj
nnoremap <Down> gj 
nnoremap k gk
nnoremap <Up> gk
nnoremap <C-q> ,/ :nohlsearch<CR>
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j

command! Fuck execute 'w !sudo tee % > /dev/null'
command! -nargs=* Wrap setlocal tw=80 wrap linebreak nolist fo-=c
command! -nargs=* TNT NERDTreeTabsToggle

" vim-notes options
let g:notes_directories=['~/AeroFS/School/MCC/','~/AeroFS/DnD/5E_WORLD/']
let g:notes_suffix='.txt'
let g:notes_unicode_enabled=0

let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeDirArrows=0

let g:molokai_original=1

let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline_theme='murmur_modified'

" Highlight merge conflict markers
match Todo '\v^(\<|\=|\>){7}([^=].+)?$'

" Jump to next/previous merge conflict marker
nnoremap <silent> ]c /\v^(\<\|\=\|\>){7}([^=].+)?$<CR>
nnoremap <silent> [c ?\v^(\<\|\=\|\>){7}([^=].+)\?$<CR>

highlight Search ctermbg=000

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1

vmap  <expr> <C-Left> DVB_Drag('left')
vmap  <expr> <C-Right> DVB_Drag('right')
vmap  <expr> <C-Down> DVB_Drag('down')
vmap  <expr> <C-Up> DVB_Drag('up')

if has("autocmd")
  autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
  autocmd VimResized * :wincmd =
  autocmd! bufwritepost .vimrc source .vimrc
endif
