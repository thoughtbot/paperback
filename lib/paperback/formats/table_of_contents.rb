require "paperback/formats/base"

module Paperback
  module Formats
    class TableOfContents < Base
      def extension
        "toc.html"
      end

      private

      def run
        Paperback::Formats::TableOfContentsRenderer.generate package
      end
    end
  end
end
