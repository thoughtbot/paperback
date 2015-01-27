require "paperback/formats/base"

module Paperback
  module Formats
    class TableOfContents < Base
      private

      def extension
        "toc.html"
      end

      def run
        Paperback::Formats::TableOfContentsRenderer.generate package
      end
    end
  end
end
