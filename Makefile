all: paper

# If you decide to go with pandoc-citeproc
#	pandoc -s -F pandoc-crossref -F pandoc-citeproc meta.yaml --data-dir=data-dir --template=mytemplate.tex -N \
#	-f markdown -t latex+raw_tex+tex_math_dollars+citations -o main.pdf main.md

# You can still use pandoc-crossref to easily reference figures with [@fig:label]

paper:
	@pandoc -s -F pandoc-crossref --natbib meta.yaml -N \
	 -f markdown+raw_tex+tex_math_dollars+citations -t latex -o main.tex main.md
	@pdflatex main.tex
	@bibtex main
	@pdflatex main.tex
	@bibtex main
	@pdflatex main.tex
	@rm main.{aux,log,out,bbl,blg,tex}
