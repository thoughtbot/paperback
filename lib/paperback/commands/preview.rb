require "paperback"

module Paperback
  module Commands
    class Preview
      def self.call
        new.call
      end

      def call
        Paperback::Commands::CopyAssets.call
        Paperback::Formats::HTML.new(package).generate
      end

      private

      def package
        Paperback::Package.book
      end
    end
  end
end
