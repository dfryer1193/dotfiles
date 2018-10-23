set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

" UI Changes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Version Control Info
Plug 'airblade/vim-gitgutter'

" Various utilities
Plug 'tpope/vim-surround'
Plug 'atweiden/vim-dragvisuals'
  Plug 'vim-scripts/Align'
  Plug 'vim-scripts/cecutil'
  Plug 'vim-scripts/vis'

" Themes
Plug 'dikiaap/minimalist'
Plug 'AlessandroYorba/Sierra'
Plug 'jacoborus/tender.vim'

" Nonstandard syntax highlighting
Plug 'mboughaba/i3config.vim'

" Nonstandard Language support
Plug 'fatih/vim-go'

call plug#end()

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set number
set cursorline
set autoindent
set title
set pastetoggle=<F2>
set mouse=a
set t_Co=256
set laststatus=2
set colorcolumn=81
set textwidth=80
set formatoptions=tcrqn2blj
set splitbelow
set splitright
"set listchars=eol:\,tab:>\ ,trail:~

filetype plugin on
syntax on
filetype indent on

vmap Q gq
nmap Q gqap
nmap <F3> :set list!<CR>

nnoremap j gj
nnoremap <Down> gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <C-q> ,/ :nohlsearch<CR>

nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j

command! Please :execute ':w suda://%'

" Theme
colorscheme sierra
" Force transparent bg
hi Normal guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE

" Highlight merge conflict markers
match Todo '\v^(\<|\=|\>){7}([^=].+)?$'

" Jump to next/previous merge conflict marker
nnoremap <silent> ]c /\v^(\<\|\=\|\>){7}([^=].+)?$<CR>
nnoremap <silent> [c ?\v^(\<\|\=\|\>){7}([^=].+)\?$<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-airline options                                                        ""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline_theme='distinguished'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
"" Dragvisuals Settings                                                       ""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS=1

" Move blocks of code
vmap  <expr> <C-Left> DVB_Drag('left')
vmap  <expr> <C-Right> DVB_Drag('right')
vmap  <expr> <C-Down> DVB_Drag('down')
vmap  <expr> <C-Up> DVB_Drag('up')

" Filetype-specific stuff
if has("autocmd")
  autocmd FileType make set
        \ tabstop=8
        \ shiftwidth=8
        \ softtabstop=0
        \ noexpandtab
  autocmd BufRead,BufNewFile *.c,*.h,*.cpp,*.C set
        \ tabstop=4
        \ softtabstop=4
        \ shiftwidth=4
        \ filetype=c
        \ noexpandtab
  autocmd BufRead,BufNewFile *.java set
        \ tabstop=8
        \ softtabstop=4
        \ shiftwidth=4
        \ filetype=java
        \ noexpandtab
  autocmd FileType go set
        \ tabstop=8
        \ shiftwidth=8
        \ softtabstop=0
        \ noexpandtab
  autocmd BufNewFile,BufReadPost *.md set
        \ filetype=markdown.pandoc
  autocmd BufRead,BufNewFile *.i3/config set
        \ filetype=i3config
  autocmd VimResized * :wincmd =
  autocmd! bufwritepost .vimrc source ~/.vimrc
endif
