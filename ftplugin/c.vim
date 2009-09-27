map <buffer> \h :call SwitchToHeader()<CR>
map <buffer> <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <buffer> \] <Esc>:exe "ptjump " . expand("<cword>")<Esc>

set tags+=~/extSW/STLtags

" The standard % motions do not work
let b:match_words='{:},(:),[:],/\*:\*/'

if exists("g:c_ftplugin_functions_defined")
    finish
endif

function SwitchToHeader()
    if expand("%:e") == "hh"
        execute "edit " . expand("%:r").".cc"
    elseif expand("%:e") == "cc"
        execute "edit " . expand("%:r").".hh"                                      
    endif
endfunction

let g:c_ftplugin_functions_defined = 1
