Given /^a fixture file named "([^"]*)"$/ do |file_name|
  file_path = File.join('spec', 'fixtures', file_name)
  write_file file_name, File.read(file_path, mode: 'rb')
end
