require 'aruba/cucumber'
require 'aruba-doubles/cucumber'

# Add custom gem.bindir to path
ENV['PATH'] = [File.expand_path('exe'), ENV['PATH']].join(File::PATH_SEPARATOR)
