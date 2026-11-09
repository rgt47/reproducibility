-- LaTeX cannot break a long inline code token such as
-- `analysis/scripts/simulate_cohort.R`, so in the PDF such tokens ran
-- past the page edge. For LaTeX output only, this filter rewrites
-- plain inline code longer than 20 characters as \texttt{} with a
-- break opportunity (no hyphen, so nothing is added to what a reader
-- copies) after each '/', '_', '(', ',', '=', and '::'. Inline code
-- with a class (syntax-highlighted) is left to Pandoc.

local MIN_LENGTH = 20

local escapes = {
  ['\\'] = '\\textbackslash{}', ['{'] = '\\{', ['}'] = '\\}',
  ['$'] = '\\$', ['&'] = '\\&', ['#'] = '\\#', ['^'] = '\\^{}',
  ['_'] = '\\_', ['%'] = '\\%', ['~'] = '\\textasciitilde{}',
  ["'"] = '\\textquotesingle{}', ['`'] = '\\textasciigrave{}',
  ['<'] = '\\textless{}', ['>'] = '\\textgreater{}',
  ['-'] = '-{}', ['"'] = '\\textquotedbl{}',
}

local BREAK_AFTER = { ['/'] = true, ['_'] = true, ['('] = true,
                      [','] = true, ['='] = true }

local function breakable(text)
  local out = {}
  local n = #text
  local i = 1
  while i <= n do
    local ch = text:sub(i, i)
    if ch == ':' and text:sub(i + 1, i + 1) == ':' then
      out[#out + 1] = '::\\allowbreak{}'
      i = i + 2
    else
      out[#out + 1] = escapes[ch] or ch
      if BREAK_AFTER[ch] and i < n then
        out[#out + 1] = '\\allowbreak{}'
      end
      i = i + 1
    end
  end
  return table.concat(out)
end

function Code(el)
  if not FORMAT:match('latex') then
    return nil
  end
  if #el.classes > 0 or #el.text <= MIN_LENGTH then
    return nil
  end
  return pandoc.RawInline('latex', '\\texttt{' .. breakable(el.text) .. '}')
end
