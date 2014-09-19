# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)

unless $LOAD_PATH.include?(lib)
  $LOAD_PATH.unshift lib
end

require 'paperback/version'

Gem::Specification.new do |gem|
  gem.name = 'paperback'
  gem.version = Paperback::VERSION
  gem.authors = ['thoughtbot']
  gem.email = 'support@thoughtbot.com'
  gem.description = 'Standardize and streamline ebook production.'
  gem.summary = "paperback-#{Paperback::VERSION}"
  gem.homepage = 'http://github.com/thoughtbot/paperback'
  gem.license = 'MIT'

  gem.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.bindir = 'exe'
  gem.executables = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'activesupport'
  gem.add_dependency 'asset_sync'
  gem.add_dependency 'cocaine'
  gem.add_dependency 'coderay'
  gem.add_dependency 'dotenv'
  gem.add_dependency 'kindlegen'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'pdf-reader'
  gem.add_dependency 'redcarpet'
  gem.add_dependency 'rmagick'
  gem.add_dependency 'terminal-table'
  gem.add_dependency 'thor'

  gem.add_development_dependency 'aruba'
  gem.add_development_dependency 'aruba-doubles'
  gem.add_development_dependency 'bundler-audit'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rubocop'
end
