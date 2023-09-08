require "paperback/formats/epub"
require "paperback/formats/html"
require "paperback/formats/pdf"
require "paperback/formats/website"
require "paperback/formats/table_of_contents"
require "paperback/formats/table_of_contents_renderer"

module Paperback
  module Formats
    FORMAT_CLASSES = [
      Paperback::Formats::HTML,
      Paperback::Formats::Website,
      Paperback::Formats::PDF,
      Paperback::Formats::EPUB,
      Paperback::Formats::TableOfContents
    ]

    class << self
      def select(package, desired_format = nil)
        all(package).select do |format|
          desired_format.nil? || format.type == desired_format
        end
      end

      private

      def all(package)
        FORMAT_CLASSES.map do |format_class|
          format_class.new package
        end
      end
    end
  end
end
