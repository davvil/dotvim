#!/bin/bash

filename=$(basename `echo -- $* | sed 's/.*\s\(\S*.tex\).*/\1/'` .pdf)
xpdf -remote vimlatex-$filename $*
