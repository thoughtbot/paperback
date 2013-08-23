# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paperback/version'

Gem::Specification.new do |gem|
  gem.name = 'paperback'
  gem.version = Paperback::VERSION
  gem.authors = ['thoughtbot']
  gem.email = ['support@thoughtbot.com']
  gem.description = %q{
    Paperback makes it easy to generate ebooks in many formats (pdf, html, epub
    and mobi) from Markdown files.

    It combines Pandoc with some custom Markdown extensions which make it easy
    to pull in code samples from a bundled example application.
  }

  gem.summary = %q{Standardize and streamline ebook production.}

  gem.homepage = 'http://github.com/thoughtbot/paperback'
  gem.license = 'MIT'

  gem.files = `git ls-files`.split($/)
  gem.executables = gem.files.grep(%r{^bin/}) {|f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'activesupport', '~> 4.0.0'
  gem.add_dependency 'aws-sdk', '~> 1.10.0'
  gem.add_dependency 'climate_control', '~> 0.0.3'
  gem.add_dependency 'cocaine', '~> 0.5.1'
  gem.add_dependency 'coderay', '~> 1.0.9'
  gem.add_dependency 'dotenv', '~> 0.7.0'
  gem.add_dependency 'kindlegen', '~> 2.7.0'
  gem.add_dependency 'mime-types', '~> 1.23'
  gem.add_dependency 'nokogiri', '~> 1.5.9'
  gem.add_dependency 'pdf-reader', '~> 1.3.2'
  gem.add_dependency 'redcarpet', '~> 2.2.2'
  gem.add_dependency 'rmagick', '~> 2.13.1'
  gem.add_dependency 'terminal-table', '~> 1.4.5'
  gem.add_dependency 'thor', '~> 0.16.0'

  gem.add_development_dependency 'aruba', '~> 0.5.1'
  gem.add_development_dependency 'aruba-doubles', '~> 1.2.1'
  gem.add_development_dependency 'bourne', '~> 1.3.0'
  gem.add_development_dependency 'rake', '~> 10.0.3'
  gem.add_development_dependency 'rspec', '~> 2.12.0'
end
