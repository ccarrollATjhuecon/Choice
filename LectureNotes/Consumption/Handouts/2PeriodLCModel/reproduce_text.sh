#!/bin/bash
export BSTINPUTS=@resources/texlive/texmf-local/bibtex/bst:$BSTINPUTS
export BIBINPUTS=@resources/texlive/texmf-local/bibtex/bst:$BIBINPUTS
pdflatex 2PeriodLCModel
bibtex 2PeriodLCModel
pdflatex 2PeriodLCModel
pdflatex 2PeriodLCModel
