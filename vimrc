set nocompatible
set ignorecase smartcase
set incsearch
syntax on
set wildmode=longest,list,full

set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

set history=100

set backspace=indent,eol,start

set virtualedit=block

"set mouse=a

set laststatus=2 "Always a status line
set statusline=%f(%n)\ %h%r%m\ --\ l:%l\ (%p%%)\ c:%c

set spellsuggest=best,20

if v:version >= 700
    set completeopt=menu,longest
endif

filetype plugin indent on

" Options for C indenting
set cinoptions=g0,(0

let g:VM_SearchRepeatHighlight = 1
let g:is_bash = 1

set nohlsearch

function! CleverTab()
    if pumvisible()
        return "\<C-N>"
    endif
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        if &cindent || &smartindent
            return "\<C-F>"
        else
            return "\<C-I>"
        endif
    elseif &ft == 'cpp' || &ft == 'c'
        return "\<C-X>\<C-U>" " clang completion
        "return "\<C-N>"
    else
        return "\<C-N>"
    endif
endfunction 

let g:clang_complete_auto=0

set makeprg=scons\ -D\ -j5

"Custom commands
command -nargs=1 Match match MatchGroup <q-args>
   "I often type :W instead of :w
command W w
command Bd bn|bw # 

function! TextWidthToggle()
    if &tw > 0
        set tw=0
    else
        set tw=80
    endif
endfunction

map \tw :call TextWidthToggle()<CR>

"Keybindings
imap <Tab> <C-R>=CleverTab()<CR>
map \s :set hlsearch!<CR>
map zz zfaB
map \b :b#<CR>
imap <C-@> <C-o>@
map \* :exe "Match ".expand("<cword>")<CR>
map \S :match<CR>
map <S-Tab> :call NextField(' \{1,}',2,' ',0)<CR>
map! <S-Tab> <C-O>:call NextField(' \{2,}',2,' ',0)<CR>
" Enter accepts always a completion from the completion menu
" See also the help entry for ins-completion-menu
if v:version >= 700
    inoremap <CR> <C-R>=pumvisible() ? "\<lt>C-Y>" : "\<lt>CR>"<CR>
endif
" Emacs-like
imap <C-t> <Esc>xpi
imap <C-a> <C-o>^
imap <C-e> <C-o>$
"imap <C-y> <C-o>p
imap <M-BS> <Esc>dbxa
imap <C-d> <C-o>x
imap <C-k> <C-o>D
map <Tab> ==
map <M-C-Up> <C-y>
map <M-C-Down> <C-e>
imap <M-C-Up> <C-o><C-y>
imap <M-C-Down> <C-o><C-e>

map <M-Up> <C-w>k
map <M-Down> <C-w>j
map <M-Left> <C-w>h
map <M-Right> <C-w>l

map <M-k> <C-w>k
map <M-j> <C-w>j
map <M-h> <C-w>h
map <M-l> <C-w>l

imap <M-k> <C-w>k
imap <M-j> <C-w>j
imap <M-h> <C-w>h
imap <M-l> <C-w>l

map \\ :make 
map \n :cn<CR>
map \p :cp<CR>
"map \t :TlistToggle<CR>
imap <C-Space> <C-X><C-O>

set hidden

" standard vim seems to have problems detecting the background setting in urxvt
let bgCode=strpart($COLORFGBG, strridx($COLORFGBG, ";")+1)
if !strlen(bgCode) || (bgCode >= 0 && bgCode <= 6) || bgCode == 8
    set background=dark
else
    set background=light
endif

if &background == "dark"
    colorscheme greenOnBlack
    if v:version >= 700
        set cursorline
    endif
    if &term =~ "rxvt-unicode"
        "Set the cursor white in cmd-mode and orange in insert mode
        let &t_EI = "\<Esc>]12;white\x9c"
        let &t_SI = "\<Esc>]12;orange\x9c"
        "We normally start in cmd-mode
        silent !echo -e "\e]12;white\x9c" 
    endif
else
    colorscheme morning
endif

source $VIMRUNTIME/macros/matchit.vim 

" Open the quickfix window when there are errors compiling
if v:version >= 700
    au QuickFixCmdPost * cwindow
endif

"Asymptote stuff
augroup filetypedetect
    au BufNewFile,BufRead *.asy     setf asy
augroup END

"taglist settings
"let Tlist_File_Fold_Auto_Close=1
let Tlist_Enable_Fold_Column=0
let Tlist_Display_Tag_Scope=0
let Tlist_Use_Right_Window=0
let Tlist_Use_Horiz_Window = 1
let Tlist_WinWidth=50
let tlist_tex_settings   = 'latex;s:sections;g:graphics;l:labels'
let tlist_make_settings  = 'make;m:makros;t:targets'

"OmniCpp options
let OmniCpp_LocalSearchDecl = 1

"Change the directory to the one of the current open file
"autocmd BufEnter * cd %:p:h

" function: NextField 
" Args: fieldsep,minlensep,padstr,offset
"
" NextField checks the line above for field separators and moves the cursor on
" the current line to the next field. The default field separator is two or more
" spaces. NextField also needs the minimum length of the field separator,
" which is two in this case. If NextField is called on the first line or on a
" line that does not have any field separators above it the function echoes an
" error message and does nothing. 

func! NextField(fieldsep,minlensep,padstr,offset)
    let curposn = col(".")
    let linenum = line(".")
    let prevline = getline(linenum-1)
    let curline = getline(linenum)
    let nextposn = matchend(prevline,a:fieldsep,curposn-a:minlensep)+1
    let padding = ""

    if nextposn > strlen(prevline) || linenum == 1 || nextposn == 0
        echo "last field or no fields on line above"
        return
    endif

    echo ""

    if nextposn > strlen(curline)
        if &modifiable == 0
            return
        endif
        let i = strlen(curline)
        while i < nextposn - 1
            let i = i + 1
            let padding = padding . a:padstr
        endwhile
        call setline(linenum,substitute(curline,"$",padding,""))
    endif
    call cursor(linenum,nextposn+a:offset)
    return 
endfunc

" Python settings
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" LaTeX Suite
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let g:Tex_Folding = 0 
let g:Tex_MultipleCompileFormats = "dvi,pdf"
"let g:Tex_ViewRule_pdf = '$HOME/.vim/ftplugin/xpdfFname.sh'
let g:Tex_ViewRule_pdf = 'evince'
"let g:Tex_CompileRule_pdf="$HOME/.vim/ftplugin/pdflatexXpdf.sh $*"
let g:Tex_CompileRule_pdf="pdflatex -interaction nonstopmode --file-line-error $*"
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_IgnoreLevel = 3

func! TexPdfOverDVI()
    let g:Tex_FormatDependency_pdf='dvi,ps,pdf'
    let g:Tex_CompileRule_pdf="$HOME/.vim/ftplugin/ps2pdfXpdf.sh $*.ps"
endfunc
