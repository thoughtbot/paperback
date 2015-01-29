require "kindlegen"
require "paperback/formats/base"

module Paperback
  module Formats
    class MOBI < Base
      def extension
        "mobi"
      end

      private

      def prepare
        Paperback::Formats::EPUB.new(package).generate
      end

      def run
        Kindlegen.run "#{package.target(:epub)}"
      end
    end
  end
end
