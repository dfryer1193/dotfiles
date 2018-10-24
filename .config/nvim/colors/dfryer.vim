"AUTHOR: Alessandro Yorba
"UPDATED: Oct 3, 2018
"
" SUPPORT:
" 256 color terminals, Gui versions of vim, and Termguicolors versions of vim
"

set background=dark

highlight clear
if exists("syntax_on")
	syntax reset
endif

let g:colors_name="dfryer"

"COMMON COLORS AND SETTINGS
highlight PreProc guifg=#fea63c guibg=NONE gui=NONE ctermfg=003 ctermbg=NONE cterm=NONE
highlight Function guifg=#66aabb guibg=NONE gui=NONE ctermfg=004 ctermbg=NONE cterm=NONE
highlight Identifier guifg=#e84f4f guibg=NONE gui=NONE ctermfg=001 ctermbg=NONE cterm=NONE
highlight Statement guifg=#e84f4f guibg=NONE gui=NONE ctermfg=001 ctermbg=NONE cterm=NONE
highlight Constant guifg=#b7ce42 guibg=NONE gui=NONE ctermfg=002 ctermbg=NONE cterm=NONE
highlight Type guifg=#fea63c guibg=NONE gui=NONE ctermfg=003 ctermbg=NONE cterm=NONE
highlight Number guifg=#6d878d guibg=NONE gui=NONE ctermfg=002 ctermbg=NONE cterm=NONE
highlight Label guifg=#b7ce42 guibg=NONE gui=NONE ctermfg=002 ctermbg=NONE cterm=NONE
highlight String guifg=#bde077 guibg=NONE gui=NONE ctermfg=010 ctermbg=NONE cterm=NONE
highlight Special guifg=#66aabb guibg=NONE gui=NONE ctermfg=004 ctermbg=NONE cterm=NONE
highlight Operator guifg=#cccccc guibg=NONE gui=NONE ctermfg=015 ctermbg=NONE cterm=NONE
highlight Title guifg=#fea63c guibg=NONE gui=NONE ctermfg=003 ctermbg=NONE cterm=NONE
highlight Conditional guifg=#b7416e guibg=NONE gui=NONE ctermfg=005 ctermbg=NONE cterm=NONE
highlight StorageClass guifg=#66aabb guibg=NONE gui=NONE ctermfg=004 ctermbg=NONE cterm=NONE
highlight htmlStatement guifg=#66aabb guibg=NONE gui=NONE ctermfg=004 ctermbg=NONE cterm=NONE
highlight htmlItalic guifg=#fea63c guibg=NONE gui=NONE ctermfg=003 ctermbg=NONE cterm=NONE
highlight htmlArg guifg=#666666 guibg=NONE gui=NONE ctermfg=008 ctermbg=NONE cterm=NONE
highlight cssTagName guifg=#66aabb guibg=NONE gui=NONE ctermfg=004 ctermbg=NONE cterm=NONE
highlight cssClassName guifg=#fea63c guibg=NONE gui=NONE ctermfg=003 ctermbg=NONE cterm=NONE
highlight cssIdentifier guifg=#fea63c guibg=NONE gui=NONE ctermfg=003 ctermbg=NONE cterm=NONE

"DIFF
highlight DiffAdd guifg=#e84f4f guibg=NONE gui=reverse ctermfg=002 ctermbg=NONE cterm=reverse
highlight DiffText guifg=#e84f4f guibg=NONE gui=NONE ctermfg=002 ctermbg=NONE cterm=NONE
highlight DiffChange guifg=#b7416e guibg=NONE gui=reverse ctermfg=003 ctermbg=NONE cterm=reverse
highlight DiffDelete guifg=#b7ce42 guibg=NONE gui=reverse ctermfg=001 ctermbg=NONE cterm=reverse
"SPELLING
highlight SpellBad guifg=#d23d3d guibg=NONE gui=undercurl ctermfg=009 ctermbg=NONE cterm=undercurl
highlight SpellLocal guifg=#dddddd guibg=NONE gui=undercurl ctermfg=007 ctermbg=NONE cterm=undercurl
highlight SpellCap guifg=#aaccbb guibg=NONE gui=undercurl ctermfg=012 ctermbg=NONE cterm=undercurl
highlight SpellRare guifg=#ffe863 guibg=NONE gui=undercurl ctermfg=011 ctermbg=NONE cterm=undercurl

"WINDOW UI
highlight MoreMsg guifg=#b7ce42 guibg=NONE gui=NONE ctermfg=002 ctermbg=NONE cterm=NONE
highlight SpecialComment guifg=#6d878d guibg=NONE gui=reverse ctermfg=006 ctermbg=NONE cterm=reverse
highlight VimCommentTitle guifg=#666666 guibg=NONE gui=reverse ctermfg=008 ctermbg=NONE cterm=reverse
highlight Underlined guifg=#e84f4f guibg=NONE gui=NONE ctermfg=001 ctermbg=NONE cterm=NONE
highlight FoldColumn guifg=#66aabb guibg=NONE gui=NONE ctermfg=004 ctermbg=NONE cterm=NONE
highlight Todo guifg=#fea63c guibg=#666666 gui=reverse ctermfg=003 ctermbg=008 cterm=reverse
highlight Visual guifg=#cccccc guibg=#666666 gui=NONE ctermfg=015 ctermbg=008 cterm=NONE
highlight Question guifg=#42717b guibg=NONE gui=NONE ctermfg=014 ctermbg=NONE cterm=NONE
highlight Search guifg=#bde077 guibg=NONE gui=reverse ctermfg=010 ctermbg=NONE cterm=reverse
highlight MatchParen guifg=#fea63c guibg=#666666 gui=underline ctermfg=003 ctermbg=008 cterm=underline
highlight Error guifg=#e84f4f guibg=NONE gui=reverse ctermfg=001 ctermbg=NONE cterm=reverse
highlight ErrorMsg guifg=#e84f4f guibg=NONE gui=NONE ctermfg=001 ctermbg=NONE cterm=NONE
highlight WarningMsg guifg=#fea63c guibg=NONE gui=NONE ctermfg=003 ctermbg=NONE cterm=NONE
highlight netrwExe guifg=#fea63c guibg=NONE gui=NONE ctermfg=003 ctermbg=NONE cterm=NONE
highlight Directory guifg=#66aabb guibg=NONE gui=NONE ctermfg=004 ctermbg=NONE cterm=NONE
highlight Cursor guifg=#222222 guibg=#dddddd gui=NONE ctermfg=000 ctermbg=007 cterm=NONE
highlight CursorLineNr guifg=#dddddd guibg=NONE gui=reverse ctermfg=007 ctermbg=NONE cterm=reverse
highlight WildMenu guifg=#b7416e guibg=NONE gui=reverse ctermfg=005 ctermbg=NONE cterm=reverse
highlight ModeMsg guifg=#b7ce42 guibg=NONE gui=NONE ctermfg=002 ctermbg=NONE cterm=NONE
highlight SignColumn guifg=#666666 guibg=NONE gui=NONE ctermfg=008 ctermbg=NONE cterm=NONE

"DEFAULT:
"COLORS
highlight Normal guifg=#cccccc guibg=NONE gui=NONE ctermfg=015 ctermbg=NONE cterm=NONE
highlight Comment guifg=#666666 guibg=NONE gui=NONE ctermfg=008 ctermbg=NONE cterm=NONE

"WINDOW UI
highlight StatusLine guifg=#cccccc guibg=#222222 gui=NONE ctermfg=015 ctermbg=000 cterm=NONE
highlight StatusLineNC guifg=#666666 guibg=#222222 gui=NONE ctermfg=008 ctermbg=000 cterm=NONE
highlight StatusLineTerm guifg=#cccccc guibg=#222222 gui=NONE ctermfg=015 ctermbg=000 cterm=NONE
highlight StatusLineTermNC guifg=#666666 guibg=#222222 gui=NONE ctermfg=008 ctermbg=000 cterm=NONE
highlight Pmenu guifg=#cccccc guibg=#666666 gui=NONE ctermfg=015 ctermbg=008 cterm=NONE
highlight PmenuSel guifg=#222222 guibg=#cccccc gui=NONE ctermfg=000 ctermbg=015 cterm=NONE
highlight PmenuSbar guifg=#dddddd guibg=#666666 gui=NONE ctermfg=007 ctermbg=008 cterm=NONE
highlight PmenuThumb guifg=#cccccc guibg=#000000 gui=NONE ctermfg=015 ctermbg=016 cterm=NONE
highlight TabLine guifg=#666666 guibg=#222222 gui=NONE ctermfg=008 ctermbg=000 cterm=NONE
highlight TabLineSel guifg=#b7ce42 guibg=#222222 gui=NONE ctermfg=002 ctermbg=000 cterm=NONE
highlight TabLineFill guifg=NONE guibg=#222222 gui=NONE ctermfg=NONE ctermbg=000 cterm=NONE
highlight CursorLine guifg=NONE guibg=#222222 gui=NONE ctermfg=NONE ctermbg=000 cterm=NONE
highlight CursorColumn guifg=NONE guibg=#222222 gui=NONE ctermfg=NONE ctermbg=000 cterm=NONE
highlight ColorColumn guifg=NONE guibg=#666666 gui=NONE ctermfg=NONE ctermbg=008 cterm=NONE
highlight Folded guifg=#666666 guibg=NONE gui=NONE ctermfg=008 ctermbg=NONE cterm=NONE
highlight VertSplit guifg=#666666 guibg=#222222 gui=NONE ctermfg=008 ctermbg=000 cterm=NONE
highlight LineNr guifg=#666666 guibg=NONE gui=NONE ctermfg=008 ctermbg=NONE cterm=NONE
highlight NonText guifg=#666666 guibg=NONE gui=NONE ctermfg=008 ctermbg=NONE cterm=NONE
highlight SpecialKey guifg=#666666 guibg=NONE gui=NONE ctermfg=008 ctermbg=NONE cterm=NONE
