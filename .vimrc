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
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'


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
set tw=80
set fo+=t
set splitbelow " new h splits go below
set splitright " new v splits go right
set foldmethod=syntax
set listchars=eol:\ ,tab:>\ ,trail:~

filetype plugin on
syntax on
filetype indent on

vmap Q gq
nmap Q gqap
nmap <leader>l :set list<CR>

nnoremap j gj
nnoremap <Down> gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <C-q> ,/ :nohlsearch<CR>
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j

command! Please execute 'w !sudo tee % > /dev/null'
command! -nargs=* Wrap setlocal tw=80 wrap linebreak nolist fo-=c
command! -nargs=* TNT NERDTreeTabsToggle

" vim-notes options
let g:notes_directories=[
      \ '~/AeroFS/School/MCC/',
      \ '~/AeroFS/DnD/5E_WORLD/',
      \ '~/doc'
      \ ]
let g:notes_suffix='.txt'
let g:notes_unicode_enabled=1

let g:nerdtree_tabs_open_on_console_startup=0
let NERDTreeDirArrows=1

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

" YCM popup color change
highlight Pmenu ctermfg=7 ctermbg=8 guifg=#ffffff guibg=#000000

if has("autocmd")
  autocmd FileType make set
        \ tabstop=8
        \ shiftwidth=8
        \ softtabstop=0
        \ noexpandtab
  autocmd BufRead,BufNewFile *.c,*.h set
        \ tabstop=4
        \ softtabstop=4
        \ shiftwidth=4
        \ filetype=c
        \ noexpandtab
  autocmd VimResized * :wincmd =
  autocmd! bufwritepost .vimrc source .vimrc
endif
