#!/bin/bash

filename=$(basename `echo -- $* | sed 's/.*\s\(\S*.ps\).*/\1/'` .ps)
ps2pdf $*
pgrep -f "xpdf -remote vimlatex-$filename" >& /dev/null && xpdf -remote vimlatex-$filename -reload
