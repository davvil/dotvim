" Vim color file
" Maintainer:	David Vilar
" Last Change:	2007 June 11
" green on black

" started from "torte"

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
"colorscheme default
let g:colors_name = "greenOnBlack"

" GUI
highlight Normal       guifg=palegreen  guibg=Black
highlight Search       guifg=Black      guibg=lightseagreen  gui=bold
highlight Visual       guibg=#0000CD
highlight Cursor       guifg=Black      guibg=gray80	     gui=NONE
highlight lCursor      guifg=Black      guibg=#FFA500	     gui=NONE
highlight Special      guifg=Orange
highlight Comment      guifg=#FF7F24
highlight Statement    guifg=#00FFFF		             gui=NONE
highlight Type	          			             gui=NONE
highlight CursorLine                    guibg=#1A1A1A
highlight Include      guifg=#B0C4DE
highlight String       guifg=#FFA07A
highlight Type         guifg=#00FFFF
highlight PreProc      guifg=yellow
highlight Pmenu        guifg=black      guibg=gray60
highlight PmenuSel     guifg=white      guibg=gray30
highlight Boolean      guifg=#7FFFD4
highlight StatusLine   guifg=gray75     guibg=black
highlight StatusLineNC guifg=#505B67    guibg=black
highlight Folded       guifg=gray70     guibg=black          gui=bold
highlight helpNote     guifg=yellow
highlight htmlItalic   guifg=green                           gui=None
highlight shShellVariables guifg=#EEDD82
highlight MyTagListFileName guifg=white guibg=black          gui=bold
highlight Title        guifg=gray50     guibg=black          gui=bold
highlight VertSplit    guifg=#505B67    guibg=black
highlight MatchGroup   guifg=black      guibg=yellow
highlight TagListTagName guifg=darkgreen guibg=NONE          gui=bold
highlight SpellBad     guifg=red        guibg=gray18         gui=NONE


" terminal, needs 88 color support (e.g. xterm, urxvt)
highlight Search       ctermfg=Black    ctermbg=30           cterm=bold
highlight Visual       ctermbg=19
highlight Special      ctermfg=52
highlight Comment      ctermfg=52
highlight Statement    ctermfg=31	                     cterm=NONE
highlight Type	          			             cterm=NONE
highlight Constant     ctermfg=69
highlight CursorLine                    ctermbg=80           cterm=NONE
highlight Include      ctermfg=38
highlight String       ctermfg=69
highlight Type         ctermfg=31
highlight PreProc      ctermfg=yellow
highlight Pmenu        ctermfg=black    ctermbg=87
highlight PmenuSel     ctermfg=white    ctermbg=83
highlight Boolean      ctermfg=42
highlight StatusLine   ctermfg=85       ctermbg=black
highlight StatusLineNC ctermfg=81       ctermbg=85
highlight Folded       ctermfg=79       ctermbg=black       cterm=bold
highlight helpNote     ctermfg=yellow
highlight htmlItalic   ctermfg=green                        cterm=None
highlight TabLineFill  ctermfg=80
highlight TabLineSel   ctermfg=black    ctermbg=82
highlight TabLine      ctermfg=black    ctermbg=81          cterm=None
highlight MyTagListFileName ctermfg=15  ctermbg=black
highlight Title        ctermfg=86       ctermbg=black
highlight VertSplit    ctermfg=81       ctermbg=black
highlight MatchGroup   ctermfg=black    ctermbg=yellow
