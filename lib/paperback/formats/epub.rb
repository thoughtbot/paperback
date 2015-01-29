require "paperback/formats/pandoc_base"

module Paperback
  module Formats
    class EPUB < PandocBase
      def extension
        "epub"
      end

      private

      def args
        ["--epub-cover-image=#{Paperback::Cover.generate}"]
      end
    end
  end
end
