set guicursor+=i-c-ci:block-lCursor,r:hor25-lCursor,a:blinkon0
colorscheme greenOnBlack
if !has("gui_gtk2")
    " set guifont=-misc-fixed-medium-r-normal-*-18-*-*-*-*-*-iso10646-*
    set guifont=-*-terminus-medium-r-normal-*-16-*-*-*-*-*-iso10646-*
else
   "set guifont="xft:Bitstream Vera Sans Mono:size=8"
   set guifont=Monospace\ 8
endif

" Remove toolbar 
set guioptions-=T
" Remove menu
set guioptions-=m
" Remove left scrollbar
set guioptions-=L
" and right scrollbar
set guioptions-=r

set cmdheight=1

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" cursorline produces a slow refresh in gvim :(
set nocursorline
