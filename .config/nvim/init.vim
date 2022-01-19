set nocompatible

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Linting
Plug 'w0rp/ale'

" UI Changes
Plug 'vim-airline/vim-airline'

" Version Control Info
Plug 'airblade/vim-gitgutter'

" Various utilities
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'atweiden/vim-dragvisuals'
  Plug 'vim-scripts/Align'
  Plug 'vim-scripts/cecutil'
  Plug 'vim-scripts/vis'
Plug 'jiangmiao/auto-pairs'
Plug 'lambdalisue/suda.vim'
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vimwiki/vimwiki'
Plug 'preservim/nerdtree'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Nonstandard syntax highlighting
Plug 'mboughaba/i3config.vim'

" Nonstandard Language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make' }

Plug 'ryanoasis/vim-devicons'
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
set listchars=tab:>-,trail:~,nbsp:%

filetype plugin on
syntax on
filetype indent on

xmap ga <Plug>(EasyAlign)

vmap Q gq

nmap ga <Plug>(EasyAlign)
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
command! Json :execute '%!python -m json.tool'

" Theme
set termguicolors
colorscheme dfryer

" Highlight merge conflict markers
match Todo '\v^(\<|\=|\>){7}([^=].+)?$'

" Jump to next/previous merge conflict marker
nnoremap <silent> ]c /\v^(\<\|\=\|\>){7}([^=].+)?$<CR>
nnoremap <silent> [c ?\v^(\<\|\=\|\>){7}([^=].+)\?$<CR>

" Better Tags
map <A-]> :vsplit <CR>:exec("tag ".expand("<cword>"))<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-airline options                                                        ""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-airline options                                                        ""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline_theme='dfryer_airline'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vimwiki Settings                                                           ""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path':'~/vimwiki/','syntax':'markdown','ext':'.md'}]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" User-defined Functions                                                     ""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-go settings                                                            ""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ale linting options                                                        ""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '!'
let g:airline#extensions#ale#enabled = 1

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
        \ noexpandtab
        \ filetype=c
  autocmd BufRead,BufNewFile *.java set
        \ tabstop=8
        \ softtabstop=4
        \ shiftwidth=4
        \ filetype=java
        \ noexpandtab
  autocmd FileType go set
        \ tabstop=4
        \ shiftwidth=4
        \ softtabstop=4
        \ noexpandtab
  autocmd BufNewFile,BufReadPost *.md set
        \ filetype=markdown.pandoc
  autocmd BufRead,BufNewFile *i3/config set
        \ filetype=i3config
  autocmd VimResized * :wincmd =
  autocmd! bufwritepost .vimrc source ~/.vimrc
endif
