require "paperback"

module Paperback
  module Commands
    class Pandoc
      def initialize(arguments)
        @arguments = arguments
      end

      def self.call(arguments)
        new(arguments).call
      end

      def call
        Paperback::PandocRunner.new(arguments).run
      end

      private

      attr_reader :arguments
    end
  end
end
