require 'cocaine'
require 'kindlegen'
require 'pandoc-ruby'

module Paperback
  class Book
    module Formats
      EPUB = '.epub'
      HTML = '.html'
      MOBI = '.mobi'
      PDF = '.pdf'
    end

    def initialize(source)
      @source = source
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
      pdf = Paperback.build_root.join(source(Formats::PDF))

      if pdf.file?
        Cocaine::CommandLine.new('open', pdf).run
      end
    end

    private

    def pandoc(extension, flags, options)
      options.merge! output: source(extension)
      PandocRuby.allow_file_paths = true
      PandocRuby.convert source, *flags, options
    end

    def source(extension = nil)
      if extension
        File.basename(@source, File.extname(@source)) + extension
      else
        @source
      end
    end

    def to_epub
      flags = %w(toc)
      pandoc Formats::EPUB, flags, epub_cover_image: Paperback::Cover.generate
    end

    def to_html
      flags = %w(section_divs self_contained standalone toc)
      pandoc Formats::HTML, flags, to: 'html5'
    end

    def to_markdown
      Paperback::Markdown.new(source).generate
    end

    def to_mobi
      to_epub
      Kindlegen.run "#{source('.epub')} -o #{source(Formats::MOBI)}"
    end

    def to_pdf
      flags = %w(chapters toc)
      pandoc Formats::PDF, flags, data_dir: '..', template: 'pdf'
    end
  end
end
