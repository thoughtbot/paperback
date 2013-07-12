require 'cocaine'

module Paperback
  class Pandoc
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

    def pandoc(format, *args)
      args += [
        "--output=#{@package.target(format)}",
        '--toc'
      ]

      Cocaine::CommandLine.new(
        'pandoc',
        "#{args.join(' ')} #{@package.target(:markdown)}"
      ).run
    end

    def pdf_latex_template_path
      File.expand_path '../templates/pdf.latex', __FILE__
    end
  end
end
