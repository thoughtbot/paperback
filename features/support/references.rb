module ReferenceSupport
  def check_reference(file_name, reference, expected)
    check_file_content(file_name, <<-HTML.strip, expected)
      <li><a href="##{reference}">
    HTML
  end
end

World(ReferenceSupport)
