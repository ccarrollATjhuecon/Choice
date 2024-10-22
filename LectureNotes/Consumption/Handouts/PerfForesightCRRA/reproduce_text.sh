#!/bin/bash
export BSTINPUTS=@resources/texlive/texmf-local/bibtex/bst:$BSTINPUTS
export BIBINPUTS=@resources/texlive/texmf-local/bibtex/bst:$BIBINPUTS
pdflatex PerfForesightCRRA
bibtex PerfForesightCRRA
pdflatex PerfForesightCRRA
pdflatex PerfForesightCRRA
