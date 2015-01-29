require "paperback"

module Paperback
  module Commands
    class Build
      def initialize(package_name, format_extension)
        @package_name = package_name
        @format_extension = format_extension
      end

      def self.call(package_name, format_extension)
        new(package_name, format_extension).call
      end

      def call
        Paperback::Commands::CopyAssets.call

        Paperback::Package.select(package_name).each do |package|
          Paperback::Formats.select(package, format_extension).each do |format|
            format.generate
          end
        end
      end

      private

      attr_reader :format_extension
      attr_reader :package_name
    end
  end
end
