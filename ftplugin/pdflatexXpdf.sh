#!/bin/bash

filename=$(basename `echo -- $* | sed 's/.*\s\(\S*.tex\).*/\1/'` .tex)
pdflatex -interaction nonstopmode --file-line-error $*
pgrep -f "xpdf -remote vimlatex-$filename" >& /dev/null && xpdf -remote vimlatex-$filename -reload
