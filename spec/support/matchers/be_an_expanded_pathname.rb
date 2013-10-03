RSpec::Matchers.define :be_an_expanded_pathname do |expected|
  match do |actual|
    actual == Pathname.new(expected).expand_path
  end
end
