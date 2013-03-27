Then /^"(.*?)" should embed appropriate screen fonts$/ do |pdf_path|
  fonts = embedded_fonts(pdf_path).should match_array(PdfInfo::SCREEN_FONTS)
end

Then /^"(.*?)" should use an appropriate page size for an eBook$/ do |pdf_path|
  page_sizes(pdf_path).should eq [PdfInfo::PAGE_SIZE_6_BY_9_INCHES]
end

