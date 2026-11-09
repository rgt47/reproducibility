-- Decision D23. In the PDF a collapsed callout cannot hide anything,
-- so every check printed its answer directly beneath the question and
-- the retrieval attempt became optional. For PDF output only, this
-- filter lifts each check's nested 'Answer' callout out of the check,
-- numbers the checks within each numbered chapter, and prints the
-- answers together at the end of that chapter, before its cheat sheet.
-- Page references join each question to its answer and back. HTML
-- output is untouched: there the answer stays folded inside the check.

local PREFIX = 'Check your understanding:'

local function is_callout(div)
  return div.classes:includes('callout-note')
end

local function first_header(div)
  local b = div.content[1]
  if b and b.t == 'Header' then
    return b
  end
  return nil
end

-- The header's inlines after the 'Check your understanding:' prefix,
-- keeping any code or emphasis in the title.
local function strip_prefix(inlines)
  local text = ''
  for i, el in ipairs(inlines) do
    text = text .. pandoc.utils.stringify(el)
    if text == PREFIX then
      local rest = pandoc.List()
      for j = i + 1, #inlines do
        rest:insert(inlines[j])
      end
      while #rest > 0 and rest[1].t == 'Space' do
        rest:remove(1)
      end
      return rest
    end
    if #text > #PREFIX then
      return nil
    end
  end
  return nil
end

local function latex(s)
  return pandoc.RawInline('latex', s)
end

function Pandoc(doc)
  if not FORMAT:match('latex') then
    return nil
  end
  local out = pandoc.List()
  local pending = pandoc.List()
  local in_numbered_chapter = false
  local k = 0
  local serial = 0

  local function flush()
    if #pending == 0 then
      return
    end
    out:insert(pandoc.Header(
      2, 'Answers to the checks',
      pandoc.Attr('', { 'unnumbered', 'unlisted' })
    ))
    out:extend(pending)
    pending = pandoc.List()
  end

  local function lift(div)
    if not in_numbered_chapter or not is_callout(div) then
      return nil
    end
    local h = first_header(div)
    if not h then
      return nil
    end
    local rest = strip_prefix(h.content)
    if not rest then
      return nil
    end
    local kept = pandoc.List()
    local answer = nil
    for _, b in ipairs(div.content) do
      local bh = (b.t == 'Div') and first_header(b) or nil
      if not answer and bh and is_callout(b)
          and pandoc.utils.stringify(bh) == 'Answer' then
        answer = b
      else
        kept:insert(b)
      end
    end
    if not answer then
      return nil
    end

    k = k + 1
    serial = serial + 1
    local q = 'check-q-' .. serial
    local a = 'check-a-' .. serial

    local title = pandoc.List({ pandoc.Str('Check'), pandoc.Space(),
                                pandoc.Str(k .. ':'), pandoc.Space() })
    title:extend(rest)
    kept[1] = pandoc.Header(h.level, title, h.attr)
    kept:insert(pandoc.Para({
      latex('\\label{' .. q .. '}'),
      pandoc.Emph({ pandoc.Str('The'), pandoc.Space(), pandoc.Str('answer'),
                    pandoc.Space(), pandoc.Str('is'), pandoc.Space(),
                    pandoc.Str('on'), pandoc.Space(), pandoc.Str('page'),
                    pandoc.Space(), latex('\\pageref{' .. a .. '}'),
                    pandoc.Str('.') })
    }))
    div.content = kept

    local lead = pandoc.List({
      latex('\\label{' .. a .. '}'),
      pandoc.Strong({ pandoc.Str('Check'), pandoc.Space(),
                      pandoc.Str(k .. '.') }),
      pandoc.Space()
    })
    lead:insert(pandoc.Emph(rest:clone()))
    lead:extend({ pandoc.Space(), pandoc.Str('(page'), pandoc.Space(),
                  latex('\\pageref{' .. q .. '}'), pandoc.Str(')') })
    pending:insert(pandoc.Para(lead))
    for i = 2, #answer.content do
      pending:insert(answer.content[i])
    end
    return div
  end

  for _, block in ipairs(doc.blocks) do
    if block.t == 'Header' and block.level == 1 then
      flush()
      in_numbered_chapter = not block.classes:includes('unnumbered')
      k = 0
      out:insert(block)
    elseif block.t == 'Header' and block.level == 2 and pending and
        (pandoc.utils.stringify(block):match('^Cheat sheet') or
         pandoc.utils.stringify(block):match('^Further reading')) then
      flush()
      out:insert(block)
    else
      -- walk() visits a block's children, not the block itself, so a
      -- check at the top level is lifted explicitly afterwards.
      local b = block:walk({ Div = lift })
      if b.t == 'Div' then
        b = lift(b) or b
      end
      out:insert(b)
    end
  end
  flush()
  doc.blocks = out
  return doc
end
