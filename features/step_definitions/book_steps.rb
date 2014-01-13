Then /^the TOC from "(.*?)" should reference "(.*?)"$/ do |path, reference|
  check_reference(path, reference, true)
end

Then /^the TOC from "(.*?)" should not reference "(.*?)"$/ do |path, reference|
  check_reference(path, reference, false)
end
