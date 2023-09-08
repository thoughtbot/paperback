function Header (h)
  -- if AST object is header type, it is passed through this function

  -- update the content
  h.content = pandoc.Link(h.content, '#' .. h.identifier)
  return h
end
