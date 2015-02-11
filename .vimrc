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
Plugin 'tpope/vim-surround'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'tpope/vim-fugitive'

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
set laststatus=2
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
let g:airline_theme='murmur_modified'

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" disable AutoComplPop
let g:acp_enableAtStartup=0
" use neocomplcache on startup, comment if vim < 7.3 || -lua
let g:neocomplcache#enable_at_startup=1
" use smartcase
let g:neocomplcache#enable_smart_case=1
let g:neocomplcache#sources#syntax#min_keyword_length=3
let g:neocomplcache#lock_buffer_name_pattern='\*ku\*'

" Define dictionary.
let g:neocomplcache#sources#dictionary#dictionaries={
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions'
  \}

if !exists('g:neocomplcache#keyword_patterns')
  let g:neocomplcache#keyword_patterns={}
endif
let g:neocomplcache#keyword_patterns['default']='\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  " return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache#sources#omni#input_patterns')
  let g:neocomplcache#sources#omni#input_patterns={}
endif
"let g:neocomplcache#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplcache#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache#sources#omni#input_patterns.perl='\h\w*->\h\w*\|\h\w*::'

if has("autocmd")
  autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif
