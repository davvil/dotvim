" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" LaTeX aware paragraphs
omap <buffer> ap ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\\|\\item\\|\\\[\)?1<CR>//-1<CR>.<CR>

" control xpdf from withing vim
map <buffer> \lr :silent !xpdf -remote vimlatex -reload<CR>
map <buffer> \lp :silent !xpdf -remote vimlatex -exec prevPage<CR>
map <buffer> \ln :silent !xpdf -remote vimlatex -exec nextPage<CR>

" Re map the \\ key to compile latex.
" Probably it would be cleaner to call the corresponding function directly,
" but I do not know which one it is!
map <buffer> \\ \ll
