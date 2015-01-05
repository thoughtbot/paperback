require "paperback"

module Paperback
  module Commands
    class Stats
      def self.call
        new.call
      end

      def call
        Paperback::Commands::CopyAssets.new.call
        puts Paperback::Book.new(Paperback::Package.book).stats
      end
    end
  end
end
