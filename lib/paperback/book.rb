require 'cocaine'
require 'kindlegen'
require 'pandoc-ruby'

module Paperback
  class Book
    PDF_VARIABLES = {
      geometry: ['paperwidth=6.0in', 'paperheight=9.0in'],
      mainfont: 'Proxima Nova',
      monofont: 'Inconsolata'
    }

    def initialize(package)
      @package = package
    end

    def generate
      to_markdown

      Paperback.in_build_dir do
        to_html
        to_mobi
        to_pdf
      end
    end

    def preview
      to_markdown

      Paperback.in_build_dir do
        to_pdf
        Cocaine::CommandLine.new('open', @package.target(:pdf)).run
      end
    end

    private

    def pandoc(format, flags, options)
      options.merge! output: @package.target(format)
      variables = PandocConfig.new(options.delete(:variables) || {})
      PandocRuby.allow_file_paths = true
      PandocRuby.convert @package.target(:markdown), *flags, options, variables
    end

    def to_epub
      flags = %w(toc)
      pandoc :epub, flags, epub_cover_image: Paperback::Cover.generate
    end

    def to_html
      flags = %w(section_divs self_contained standalone toc)
      pandoc :html, flags, to: 'html5'
    end

    def to_markdown
      Paperback::Markdown.new(
        @package.source,
        @package.target(:markdown)
      ).generate
    end

    def to_mobi
      to_epub
      Kindlegen.run "#{@package.target(:epub)} -o #{@package.target(:mobi)}"
    end

    def to_pdf
      flags = %w(chapters toc)
      pandoc(
        :pdf,
        flags,
        data_dir: '..',
        latex_engine: 'xelatex',
        template: 'pdf',
        variables: PDF_VARIABLES
      )
    end
  end
end
