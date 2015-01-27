require "paperback"

module Paperback
  module Commands
    class Build
      def self.call
        new.call
      end

      def call
        Paperback::Commands::CopyAssets.call

        Paperback::Package.all.each do |package|
          Paperback::Formats.all(package).each(&:generate)
        end
      end
    end
  end
end
