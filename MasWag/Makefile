standalone.pdf: standalone.saty bib.satyh local.satyh introduction.satyh automata.satyh lstar.satyh rnnlstar.satyh conclusion.satyh figs/mustHaveAA.pdf figs/evenDFA.pdf figs/evenDFAStep1.pdf figs/evenDFAStep2.pdf figs/evenTree.pdf figs/evenTreeMerged.pdf
	satysfi $<

deps: figs/mustHaveAA.pdf figs/evenDFA.pdf figs/evenDFAStep1.pdf figs/evenDFAStep2.pdf figs/evenTree.pdf figs/evenTreeMerged.pdf

bib.satyh: bib.xml
	xsltproc ../dblp2satysfi/dblp2satysfi.xsl $< | nkf -w | gsed '1i @import: local' > $@

%.satyh: markdown/%.md ./pandoc/satysfi.lua ./pandoc/%.template
	cat $< | sed 's/\\Sigma/\\alphabet/g;s/\\varepsilon/\\epsilon/g;s/\\not\\in/\\nin/g;s/\\Delta/\\mathrm{\\Delta}/g;' | pandoc -t ./pandoc/satysfi.lua --template ./pandoc/$(basename $(notdir $@)).template | sed 's/\\text\([ {]\)/\\text!\1/g;s/\\_/_/g' > $@

./pandoc/%.template: ./pandoc/satysfi.template.m4
	m4 -DVARNAME=$(basename $(notdir $@)) $< > $@

clean:
	$(RM) standalone.pdf introduction.satyh automata.satyh lstar.satyh ./pandoc/introduction.template ./pandoc/automata.template ./pandoc/lstar.template

.PHONY: clean

figs/%.pdf: figs/%.tex
	cd $(dir $<) && pdflatex $(notdir $<)
