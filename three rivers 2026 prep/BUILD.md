The updated .tex also has a one-line fix: \setmainfont now pins the font to the TTF files with an explicit Path= option, because xdvipdfmx (xelatex's PDF driver) can't embed .woff web fonts — it needs .ttf or .otf. You'll need that same fix if compiling on a machine where fontconfig resolves the family name to woff files.

xelatex songs2.tex   # run twice so TOC page numbers are correct
xelatex songs2.tex

---

# With Quarto installed:
quarto render songs.qmd --to pdf

# Or directly with pandoc (what Quarto uses under the hood):
pandoc songs.qmd \
  --from=markdown+bracketed_spans+native_divs+fenced_divs \
  --pdf-engine=xelatex \
  -V mainfont="EBGaramond12-Regular" \
  -V mainfontoptions="Path=/path/to/fonts/,Extension=.ttf,UprightFont=EBGaramond12-Regular,BoldFont=EBGaramond12-Bold,ItalicFont=EBGaramond12-Italic" \
  -V monofont="DejaVu Sans Mono" \
  -V geometry="margin=2.5cm" \
  -o songs.pdf
