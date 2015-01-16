set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set number
set autoindent
set mouse=a
filetype plugin on
syntax on
filetype indent on
command! -nargs=* Wrap setlocal tw=80 wrap linebreak nolist
if has("autocmd")
  autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif
