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
Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-surround'
Plugin 'Shougo/neocomplete.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'tpope/vim-endwise'
Plugin 'rstacruz/vim-closer'
Plugin 'atweiden/vim-dragvisuals'
Plugin 'keith/tmux.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

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
let g:notes_directories=['~/AeroFS/School/MCC/']
let g:notes_suffix='.txt'
let g:notes_unicode_enabled=0

let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeDirArrows=0

let g:molokai_original=1

let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline_theme='murmur_modified'

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" disable AutoComplPop
let g:acp_enableAtStartup=0
" use neocomplete on startup, comment if vim < 7.3 || -lua
let g:neocomplete#enable_at_startup=1
" use smartcase
let g:neocomplete#enable_smart_case=1
let g:neocomplete#sources#syntax#min_keyword_length=3
let g:neocomplete#lock_buffer_name_pattern='\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries={
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions'
  \}

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns={}
endif
let g:neocomplete#keyword_patterns['default']='\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  " return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns={}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl='\h\w*->\h\w*\|\h\w*::'

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
