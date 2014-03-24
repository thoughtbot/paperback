require 'cocaine'

module Paperback
  class Pandoc
    CLI_DEPENDENCY = Gem::Dependency.new('pandoc', '>= 1.11.1')

    module Regex
      CLI_VERSION = /pandoc (?<version>.*)/
    end

    def initialize(package)
      @package = package
    end

    def to_html
      pandoc(
        :html,
        '--section-divs',
        '--self-contained',
        '--to=html5',
        "--css=#{css_path}",
        "--include-in-header=#{typekit_path}"
      )
    end

    def to_epub
      pandoc(
        :epub,
        "--epub-cover-image=#{Cover.generate}"
      )
    end

    def to_pdf
      pandoc(
        :pdf,
        '--chapters',
        '--latex-engine=xelatex',
        "--template=#{pdf_latex_template_path}",
        '--variable=geometry:paperheight=9.0in',
        '--variable=geometry:paperwidth=6.0in',
        '--variable=mainfont:"Proxima Nova"',
        '--variable=monofont:Inconsolata'
      )
    end

    private

    def cli(args)
      Cocaine::CommandLine.new(CLI_DEPENDENCY.name, args).run
    end

    def cli_dependency_match?
      match_data = Regex::CLI_VERSION.match(cli('--version'))
      CLI_DEPENDENCY.match? CLI_DEPENDENCY.name, match_data[:version]
    end

    def pandoc(format, *args)
      unless cli_dependency_match?
        fail "Please install #{CLI_DEPENDENCY}"
      end

      args += ["--output=#{@package.target(format)}", '--toc']
      cli "#{args.join(' ')} #{@package.target(:markdown)}"
    end

    def pdf_latex_template_path
      File.expand_path '../templates/pdf.latex', __FILE__
    end

    def css_path
      File.expand_path '../assets/css/application.css', __FILE__
    end

    def typekit_path
      File.expand_path '../assets/typekit', __FILE__
    end
  end
end
