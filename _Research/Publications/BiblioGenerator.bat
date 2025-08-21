set OPENOUT_ANY=r

ren bib2bib_exe bib2bib.exe
ren bibtex2html_exe bibtex2html.exe

bib2bib -ob bibliography.bib References.bib
bibtex2html -t "Bibliography" -s IEEETran -a -noabstract -nokeywords bibliography.bib
del bibliography.bib

bib2bib -ob mybibliography.bib References.bib -c "author : 'Sameni'"
bibtex2html -t "" -s IEEETran -d -r -noabstract -nokeywords mybibliography.bib
del mybibliography.bib

bib2bib -ob thesis.bib -c "author : 'Sameni'" -c "$type = 'PHDTHESIS' or $type = 'MASTERSTHESIS'" References.bib
bibtex2html -t "" -s IEEETran -d -r -noabstract -nokeywords thesis.bib
del thesis.bib

bib2bib -ob patents.bib -c "author : 'Sameni'" -c "$type = 'PATENT'" References.bib
bibtex2html -t "" -s IEEETran -d -r -noabstract -nokeywords patents.bib
del patents.bib

bib2bib -ob journals.bib -c "author : 'Sameni'" -c "$type = 'ARTICLE'" References.bib
bibtex2html -t "" -s IEEETran -d -r -noabstract -nokeywords journals.bib
del journals.bib

bib2bib -ob conferences.bib -c "author : 'Sameni'" -c "$type = 'INPROCEEDINGS' or $type = 'CONFERENCE'" References.bib
bibtex2html -t "" -s IEEETran -d -r -noabstract -nokeywords conferences.bib
del conferences.bib

bib2bib -ob reports.bib -c "author : 'Sameni'" -c "$type = 'TECHREPORT' or $type = 'UNPUBLISHED'" References.bib
bibtex2html -t "" -s IEEETran -d -r -noabstract -nokeywords reports.bib
del reports.bib

bib2bib -ob thsupervisions.bib -c "note : 'Dr. Reza Sameni'" -c "$type = 'MASTERSTHESIS' or $type = 'PHDTHESIS'" References.bib
bibtex2html -t "" -s IEEETran -d -r -noabstract -nokeywords thsupervisions.bib
del thsupervisions.bib

ren bib2bib.exe bib2bib_exe
ren bibtex2html.exe bibtex2html_exe

