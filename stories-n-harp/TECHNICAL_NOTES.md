# TECHNICAL NOTES

Markdown to PDF:

The following include styling markdown to remove page number (? also in cli: -V  ?)

---
fontsize: 12pt
geometry: margin=0.7in
header-includes:
  - \pagenumbering{gobble}
---

pandoc unforeseen-traveling-set-storynotes.md -o quickout.pdf


pandoc -o vf-2024-ireland-wales.pdf -V papersize:a5 stories-n-harp/vf-2024-ireland-wales.md

quarto render stories-n-harp/vf-2024-ireland-wales.md --to pdf

quarto render stories-n-harp/vf-2024-ireland-wales.md 

Quarto header yaml

```yaml
---
format:
  pdf:
    papersize: a5
    pagestyle: empty
---
```


Extracting youtube audio:

`yt-dlp -x --audio-format mp3 -o eddie_lenihan_fisherman_wife_yt-Dik4otXJ7sQ.mp3 "https://www.youtube.com/watch?v=Dik4otXJ7sQ"`

Extracting transcript with whisper:

brew install whisper-cpp