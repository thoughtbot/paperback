require "paperback"

module Paperback
  module Commands
    class Stats
      def self.call
        new.call
      end

      def call
        Paperback::Commands::CopyAssets.call
        Paperback::Formats::PDF.new(package).generate
        puts Paperback::Stats.new(package)
      end

      private

      def package
        Paperback::Package.book
      end
    end
  end
end
