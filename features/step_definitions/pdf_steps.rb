Then /^"(.*?)" should embed appropriate screen fonts$/ do |pdf_path|
  expect(embedded_fonts(pdf_path)).to match_array(PdfInfo::SCREEN_FONTS)
end

Then /^"(.*?)" should have page sizes for a book$/ do |pdf_path|
  expect(page_sizes(pdf_path)).to eq([PdfInfo::PAGE_SIZE_6_BY_9_INCHES])
end
