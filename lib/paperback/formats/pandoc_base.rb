require "paperback/formats/base"

module Paperback
  module Formats
    class PandocBase < Base
      private

      def args
        fail NotImplementedError
      end

      def pandoc
        Paperback::Pandoc.new package
      end

      def run
        pandoc.generate extension, args
      end
    end
  end
end
