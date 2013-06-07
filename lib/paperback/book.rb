require 'cocaine'
require 'kindlegen'

module Paperback
  class Book
    def initialize(package)
      @package = package
    end

    def generate
      to_markdown

      Paperback.in_build_dir do
        to_html
        to_mobi
        to_pdf
        to_toc
      end
    end

    def preview
      to_markdown

      Paperback.in_build_dir do
        to_pdf
        Cocaine::CommandLine.new('open', @package.target(:pdf)).run
      end
    end

    def stats
      to_markdown

      Paperback.in_build_dir do
        to_pdf
        Stats.new(@package.target(:pdf))
      end
    end

    private

    def pandoc
      @pandoc ||= Pandoc.new(@package)
    end

    def to_epub
      pandoc.to_epub
    end

    def to_html
      pandoc.to_html
    end

    def to_markdown
      Markdown.new(
        @package.source,
        @package.target(:markdown)
      ).generate
    end

    def to_mobi
      to_epub
      Kindlegen.run "#{@package.target(:epub)} -o #{@package.target(:mobi)}"
    end

    def to_pdf
      pandoc.to_pdf
    end

    def to_toc
      TableOfContents.generate @package
    end
  end
end
