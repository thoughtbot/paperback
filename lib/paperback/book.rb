require 'cocaine'
require 'kindlegen'
require 'pandoc-ruby'

module Paperback
  class Book
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

    private

    def pandoc(extension, flags, options)
      output = source(extension)
      options.merge! output: output
      PandocRuby.allow_file_paths = true
      PandocRuby.convert source, *flags, options
      output
    end

    def source(extension = nil)
      if extension
        File.basename(@source, File.extname(@source)) + extension
      else
        @source
      end
    end

    def to_epub
      pandoc '.epub', %w(toc), epub_cover_image: Paperback::Cover.generate
    end

    def to_html
      flags = %w(section_divs self_contained standalone toc)
      pandoc '.html', flags, to: 'html5'
    end

    def to_markdown
      Paperback::Markdown.new(source).generate
    end

    def to_mobi
      to_epub
      Kindlegen.run "#{source('.epub')} -o #{source('.mobi')}"
    end

    def to_pdf
      flags = %w(chapters toc)
      output = pandoc('.pdf', flags, data_dir: '..', template: 'pdf')
      Cocaine::CommandLine.new('open', output).run
    end
  end
end
