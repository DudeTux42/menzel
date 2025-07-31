BASE = $(shell grep -E "^\\\def([ ]*)\\\configName([ ]*){(.*)}" include/config.tex | tail -n1 | sed "s/[{}]/%/g" | cut -d "%" -f 2)
LANG = $(shell grep -E "^\\\def([ ]*)\\\configLang([ ]*){(.*)}" include/config.tex | tail -n1 | sed "s/[{}]/%/g" | cut -d "%" -f 2)
CLEAN = "*.aux" "*.log" "*.nav" -o -name "*.out" -o -name "*.pdf" -o -name "*.snm" -o -name "*.toc" -o -name "*.txt" -print
PAGESDIR = "pages/"

all: presentation presentation-169 handout-plain

presentation: images
	pdflatex presentation.tex
	pdflatex presentation.tex
	mv presentation.pdf ${BASE}-presentation.pdf


presentation-169: images
	sed -e 's/preamble-presentation-talks/preamble-presentation169/g' presentation.tex > presentation169.tex
	pdflatex presentation169.tex
	pdflatex presentation169.tex
	mv presentation169.pdf ${BASE}-presentation169.pdf


handout: images
	sed -e 's/preamble-presentation-talks/preamble-presentation-handout/g' presentation.tex > presentation-handout.tex
	pdflatex presentation-handout.tex
	pdflatex presentation-handout.tex
	mv presentation-handout.pdf ${BASE}-presentation-pages.pdf
	[ -d pages ] || mkdir pages
	pdfseparate ${BASE}-presentation-pages.pdf pages/${BASE}%d.pdf
#	Or if you prefer pdftk
#	pdftk ${BASE}-presentation-pages.pdf burst output pages/${BASE}%01d.pdf
	rm ${BASE}-presentation-pages.pdf
	pdflatex handout.tex
	pdflatex handout.tex
	mv handout.pdf ${BASE}-handout.pdf


handout-plain: handout
	pdfjam --nup 1x1 --frame true --noautoscale false --scale 0.8 --landscape $(shell find pages/*.pdf | sort --version-sort) --offset '0 0' --outfile ${BASE}-handout-plain.pdf
	pdfjam ${BASE}-handout.pdf 1 ${BASE}-handout-plain.pdf --outfile ${BASE}-handout-plain-title.pdf


clean:
	rm -f *.aux *.log *.nav *.out *.pdf *.snm *.toc *.txt *.vrb *.bak
	rm -f chapters/*.aux chapters/*.log chapters/*.nav chapters/*.out chapters/*.pdf chapters/*.snm chapters/*.toc chapters/*.vrb chapters/*.bak
	rm -f include/*.aux include/*.log include/*.nav include/*.out include/*.pdf include/*.snm include/*.toc include/*.txt include/*.vrb include/*.bak
	rm -f pages/*
	rm -f common/artwork/internal_use_stamp.pdf
	rm -f common/artwork/internal_use_personal.pdf
	rm -f common/artwork/draft_stamp.pdf
	rm -f notes.tex
	rm -f presentation169.tex
	rm -f presentation-handout.tex

###### ASPELL #########################################################################

# Map latex language values to aspell language abbrevations
lang:
ifeq ($(LANG), ngerman)
ASPELL_LANG = de_DE
else
ASPELL_LANG = en
endif

ASPELL_ARGS = "--encoding=utf-8"

spellpattern:
ifeq ($(S),)
ASPELL_PATTERN = $(shell find -type f -name "*.tex" ! -path "./common*")
else
ASPELL_PATTERN = $(S)
endif

spellcheck: lang spellpattern
	for file in $(ASPELL_PATTERN); do \
		aspell $(ASPELL_ARGS) \
		--add-filter tex \
		--lang=$(ASPELL_LANG) \
		--personal=./`/bin/echo $$file | cut -d "." -f1`.dict \
		check $$file; \
	done

newwords: lang spellpattern
	for file in $(ASPELL_PATTERN); do \
		aspell $(ASPELL_ARGS) \
		--add-filter tex \
		--lang=$(ASPELL_LANG) \
		--extra-dicts="./common/aspell/b1_aspell_$(ASPELL_LANG).rws" \
		list < $$file | sort | uniq; \
	done

############################################### END OF ASPELL #########################


###### IMAGES #########################################################################
images: artwork $(patsubst %.svg,%.png,$(shell find ./images -type f -name "*.svg"))
%.png: %.svg; LC_ALL=C inkscape -o $(patsubst  %.svg,%.png,$<) -d 300 -D $<

artwork:  $(patsubst %.svg,%.png,$(shell find ./common/artwork -type f -name "*.svg"))
%.png: %.svg; LC_ALL=C inkscape -o $(patsubst  %.svg,%.png,$<) -d 300 -D $<



############################################### EOF IMAGES ############################
