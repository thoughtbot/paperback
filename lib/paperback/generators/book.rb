require "thor/group"

module Paperback
  module Generators
    class Book < Thor::Group
      include Thor::Actions

      def create
        directory "book", "."
      end

      def self.source_root
        File.dirname __FILE__
      end
    end
  end
end
