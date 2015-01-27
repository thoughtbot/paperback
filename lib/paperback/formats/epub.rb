require "paperback/formats/pandoc_base"

module Paperback
  module Formats
    class EPUB < PandocBase
      private

      def args
        ["--epub-cover-image=#{Paperback::Cover.generate}"]
      end

      def extension
        "epub"
      end
    end
  end
end
