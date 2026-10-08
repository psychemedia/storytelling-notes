-- strike-pdf.lua
-- Renders elements tagged with the "cut" class as struck-through text
-- when the output format is LaTeX/PDF. Has no effect on HTML output
-- (which keeps using the .cut rule in songs.css instead).

local function is_latex()
  return FORMAT:match('latex') or FORMAT:match('beamer')
end

local function wrap_sout(inlines)
  local out = {}
  table.insert(out, pandoc.RawInline('latex', '\\sout{'))
  for _, i in ipairs(inlines) do table.insert(out, i) end
  table.insert(out, pandoc.RawInline('latex', '}'))
  return out
end

function Span(el)
  if is_latex() and el.classes:includes('cut') then
    return wrap_sout(el.content)
  end
end

-- \sout can't contain a blank-line paragraph break (LaTeX "Runaway
-- argument"), so rather than wrapping the whole cut div in one
-- \sout{...}, walk into it and wrap each paragraph/line individually.
-- walk_block recurses into nested divs (e.g. .bracket-group inside
-- .verse) too, so a verse struck with {.verse .cut} gets every line
-- struck through, chords included.
function Div(el)
  if is_latex() and el.classes:includes('cut') then
    return pandoc.walk_block(el, {
      Para = function(p) return pandoc.Para(wrap_sout(p.content)) end,
      Plain = function(p) return pandoc.Plain(wrap_sout(p.content)) end,
    })
  end
end
