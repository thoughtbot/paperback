require "kindlegen"
require "paperback/formats/base"

module Paperback
  module Formats
    class MOBI < Base
      private

      def extension
        "mobi"
      end

      def prepare
        Paperback::Formats::EPUB.new(package).generate
      end

      def run
        Kindlegen.run "#{package.target(:epub)}"
      end
    end
  end
end
