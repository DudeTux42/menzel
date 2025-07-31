BASE = $(shell egrep "^\\\def([ ]*)\\\configName([ ]*){(.*)}" config.tex | tail -n1 | sed "s/[{}]/%/g" | cut -d "%" -f 2)

all: clean pdf

images:  $(patsubst %.svg,%.png,$(shell find ./images -type f -name "*.svg"))
%.png: %.svg; LC_ALL=C inkscape -o $(patsubst  %.svg,%.png,$<) -d 300 -D $<

pdf: images
	pdflatex kundendoku
	makeglossaries kundendoku
	pdflatex kundendoku
	makeglossaries kundendoku
	pdflatex kundendoku
ifeq ($(DRM),)
	mv kundendoku.pdf $(BASE).pdf
else
	pdftk kundendoku.pdf output kundendoku-drm.pdf owner_pw someSecret encrypt_128bit allow printing
	mv kundendoku-drm.pdf ${BASE}.pdf
endif

pdf_personal: images
	pdflatex kundendoku.tex
	pdflatex kundendoku.tex
	mv kundendoku.pdf $(BASE).pdf	


ifeq ($(PERSONALMSG),)
personal:
	@echo "PERSONALMSG ist nicht gesetzt, Aufruf ist:"
	@echo "make personal PERSONALMSG=\"John Doe (doe@b1-systems.de)\""
else
personal: pdf_personal
	sed -e "s/B1 Systems - Internal use only/$(PERSONALMSG)/;" < internal_use_stamp.svg \
		> internal_use_stamp_personal.svg
	inkscape -d 300 -D -o internal_use_stamp_personal.png internal_use_stamp_personal.svg
	convert internal_use_stamp_personal.png internal_use_stamp_personal.pdf
	pdftk ${BASE}.pdf stamp internal_use_stamp_personal.pdf output ${BASE}_personal.pdf
	rm ${BASE}.pdf 
	@rm internal_use_stamp_personal.png internal_use_stamp_personal.pdf internal_use_stamp_personal.svg
ifeq ($(DRM),1)
	pdftk $(BASE)_personal.pdf output ${BASE}_personal-drm.pdf owner_pw someSecret encrypt_128bit allow printing 
	mv ${BASE}_personal-drm.pdf ${BASE}.pdf
else
endif
endif

internal_use_stamp.pdf: internal_use_stamp.svg
	inkscape -d 300 -D -o internal_use_stamp.png internal_use_stamp.svg
	convert internal_use_stamp.png internal_use_stamp.pdf
	@rm internal_use_stamp.png
	
internal: pdf_personal internal_use_stamp.pdf
	pdftk ${BASE}.pdf stamp internal_use_stamp.pdf output ${BASE}_internal.pdf
	rm ${BASE}.pdf 	
ifeq ($(DRM),1)
	pdftk $(BASE)_internal.pdf output ${BASE}_internal-drm.pdf owner_pw someSecret encrypt_128bit allow printing 
	mv ${BASE}_internal-drm.pdf ${BASE}.pdf
else
endif

draft_stamp.pdf: draft_stamp.svg
	inkscape -d 300 -D -o draft_stamp.png draft_stamp.svg
	convert draft_stamp.png draft_stamp.pdf
	@rm draft_stamp.png
	
draft: pdf_personal draft_stamp.pdf
	pdftk ${BASE}.pdf stamp draft_stamp.pdf output ${BASE}_draft.pdf
	rm ${BASE}.pdf
ifeq ($(DRM),1)
	pdftk $(BASE)_draft.pdf output ${BASE}_draft-drm.pdf owner_pw someSecret encrypt_128bit allow printing 
	mv ${BASE}_draft-drm.pdf ${BASE}.pdf
else
endif
	
clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.txt *.vrb *.bak *.ilg *.pla *.syn *.ind *.backup
	rm -f *.acn *.acr *.alg *.glg *.glo *.gls *.ist *.lof *.lol *.lot
	rm -f chapters/*.aux chapters/*.log chapters/*.nav chapters/*.out chapters/*.pdf chapters/*.snm chapters/*.toc chapters/*.vrb chapters/*.bak chapter/*.backup


