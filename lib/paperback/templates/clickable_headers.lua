function Header (h)
  -- if AST object is header type, it is passed through this function

  -- update the content
  if h.level > 2 then
    h.content = pandoc.Link(h.content, '#' .. h.identifier)
  end
  return h
end
