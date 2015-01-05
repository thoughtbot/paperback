require "paperback"

module Paperback
  module Commands
    class New
      def initialize(path)
        @path = path
      end

      def self.call(path)
        new(path).call
      end

      def call
        Paperback::Generators::Book.start [path]
      end

      private

      attr_reader :path
    end
  end
end
