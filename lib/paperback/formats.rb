require "paperback/formats/epub"
require "paperback/formats/html"
require "paperback/formats/mobi"
require "paperback/formats/pdf"
require "paperback/formats/table_of_contents"
require "paperback/formats/table_of_contents_renderer"

module Paperback
  module Formats
    FORMAT_CLASSES = [
      Paperback::Formats::HTML,
      Paperback::Formats::PDF,
      Paperback::Formats::MOBI,
      Paperback::Formats::TableOfContents
    ]

    def self.select(package, extension = nil)
      all(package).select do |format|
        extension.nil? || format.extension == extension
      end
    end

    private

    def self.all(package)
      FORMAT_CLASSES.map do |format_class|
        format_class.new package
      end
    end
  end
end
