require 'thor/group'

module Paperback
  module Generators
    class Book < Thor::Group
      include Thor::Actions

      # Arguments
      argument :path, type: :string

      def create
        directory 'book', path
      end

      private

      def self.source_root
        File.dirname __FILE__
      end
    end
  end
end
