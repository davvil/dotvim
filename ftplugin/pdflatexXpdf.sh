#!/bin/bash

pdflatex -interaction nonstopmode -file-line-error-style $*
pgrep -f "xpdf -remote vimlatex" >& /dev/null && xpdf -remote vimlatex -reload
