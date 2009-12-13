set guicursor+=i-c-ci:block-lCursor,r:hor25-lCursor,a:blinkon0
colorscheme greenOnBlack

if $HOSTNAME == "drizzt"
    highlight Normal guifg=White
endif

if !has("gui_gtk2")
    " set guifont=-misc-fixed-medium-r-normal-*-18-*-*-*-*-*-iso10646-*
    set guifont=-*-terminus-medium-r-normal-*-14-*-*-*-*-*-iso10646-*

    if $HOSTNAME == "drizzt"
        set guifont=fixed
    endif
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

" Deactivate alt-x keybindings for menus (which we do not display)
set winaltkeys=no

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" cursorline produces a slow refresh in gvim :(
set nocursorline
