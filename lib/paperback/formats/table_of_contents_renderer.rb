require "nokogiri"
require "redcarpet"

module Paperback
  module Formats
    class TableOfContentsRenderer < Redcarpet::Render::Base
      module Regex
        CHAPTER_STUB = /
          (?<=^\#\s)    # Positive lookbehind for Atx-style H1 headers
          (.+)          # Capture chapter titles
          (?=\n\nSTUB)  # Positive lookahead for 2 newlines before STUB
        /x

        PART = /
          \\part{(?<text>.+)}  # Capture text inside LaTeX part commands
        /x
      end

      def doc_footer
        close_part + <<-EOS
            </ul>
          </section>
        EOS
      end

      def doc_header
        <<-EOS
          <section id="table-of-contents">
            <h3>Table of Contents</h3>
            <ul>
        EOS
      end

      def self.generate(package)
        markdown = IO.read(package.target(:md))
        renderer = Redcarpet::Markdown.new(self, fenced_code_blocks: true)
        IO.write package.target("toc.html"), renderer.render(markdown)
      end

      def header(text, header_level)
        if header_level == 1
          "<li>#{text}</li>"
        end
      end

      def paragraph(text)
        match_data = Regex::PART.match(text)

        if match_data
          render_part match_data[:text]
        end
      end

      def postprocess(html)
        tidy_html html
      end

      def preprocess(markdown)
        mark_chapter_stubs markdown
      end

      private

      attr_accessor :part

      def close_part
        if part
          <<-EOS
              </ul>
            </li>
          EOS
        else
          ""
        end
      end

      def mark_chapter_stubs(markdown)
        markdown.gsub Regex::CHAPTER_STUB, '\1*'
      end

      def open_part(text)
        <<-EOS
          <li>
            <h3>#{text}</h3>
            <ul>
        EOS
      end

      def render_part(text)
        output = close_part
        self.part = text
        output << open_part(text)
      end

      def tidy_html(html)
        Nokogiri::XML(html, &:noblanks).to_xhtml
      end
    end
  end
end
