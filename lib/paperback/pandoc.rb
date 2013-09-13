require 'cocaine'

module Paperback
  class Pandoc
    CLI_DEPENDENCY = Gem::Dependency.new('pandoc', '>= 1.11.1')

    def initialize(package)
      @package = package
    end

    def to_html
      pandoc(
        :html,
        '--section-divs',
        '--self-contained',
        '--standalone',
        '--to=html5'
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
      version = cli('--version').lines.first.split.last
      CLI_DEPENDENCY.match? CLI_DEPENDENCY.name, version
    end

    def pandoc(format, *args)
      unless cli_dependency_match?
        raise "Please install #{CLI_DEPENDENCY}"
      end

      args += ["--output=#{@package.target(format)}", '--toc']
      cli "#{args.join(' ')} #{@package.target(:markdown)}"
    end

    def pdf_latex_template_path
      File.expand_path '../templates/pdf.latex', __FILE__
    end
  end
end
