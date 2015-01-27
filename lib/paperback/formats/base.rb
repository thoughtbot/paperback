require "thor"

module Paperback
  module Formats
    class Base
      def initialize(package)
        @package = package
      end

      def generate
        Paperback::Markdown.generate package
        prepare
        say_status
        run
      end

      protected

      attr_reader :package

      private

      def extension
        fail NotImplementedError
      end

      def prepare
      end

      def run
        fail NotImplementedError
      end

      def say_status
        shell.say_status "create", package.target(extension).basename
      end

      def shell
        @shell ||= Thor::Base.shell.new
      end
    end
  end
end
