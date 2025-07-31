# In this file you can overwrite default buildenv settings

# keep the default as was before
BASE = $(shell egrep "^\\\def([ ]*)\\\configName([ ]*){(.*)}" include/config.tex | tail -n1 | sed "s/[{}]/%/g" | cut -d "%" -f 2)
default: all

# hack: add own target even though this was not intended... :-)
minipaper: abstracts/minipaper.pdf

abstracts/minipaper.pdf: abstracts/minipaper.tex 
	(cd abstracts; pdflatex minipaper.tex;mv minipaper.pdf ${BASE}-minipaper.pdf)
        
minipaper-clean:
	cd abstracts; rm -f *.aux *.log *.out *.pdf

