#!/bin/bash

pdflatex -interaction nonstopmode --file-line-error $*
pgrep -f "xpdf -remote vimlatex" >& /dev/null && xpdf -remote vimlatex -reload
