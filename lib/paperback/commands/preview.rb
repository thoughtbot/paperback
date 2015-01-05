require "paperback"

module Paperback
  module Commands
    class Preview
      def self.call
        new.call
      end

      def call
        Paperback::Commands::CopyAssets.call
        Paperback::Book.new(Paperback::Package.book).preview
      end
    end
  end
end
