HTML=$(shell ls */README.md | sed 's/README.md/index.html/')
HTML+=index.html
PANDOC_HTMLOPT=--mathjax -t html
PANDOC_TEXOPT=--highlight-style tango --latex-engine=lualatex -V documentclass=ltjarticle -V geometry:margin=1in -H ../mytemplate.tex
TARGET=$(HTML)

all: $(HTML)

index.md: README.md
	sed 's/README.md/index.html/' $< > $@

index.html: index.md
	pandoc -s $< -o $@ $(PANDOC_HTMLOPT) --template=template
	rm -f index.md 

%/index.html: %/README.md
	pandoc -s $< -o $@ $(PANDOC_HTMLOPT) --template=template

clean:
	rm -f $(TARGET) index.html