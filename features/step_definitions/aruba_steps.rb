Given(/^a fixture file named "([^"]*)"$/) do |file_name|
  fixture_file_path = File.join("spec", "fixtures", file_name)
  aruba_file_path = File.join(aruba.config.working_directory, file_name)

  Aruba.platform.mkdir(File.dirname(file_name))
  File.binwrite(
    aruba_file_path,
    File.read(fixture_file_path, mode: "rb")
  )
end
