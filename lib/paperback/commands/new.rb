require "paperback"

module Paperback
  module Commands
    class New
      def self.call
        new.call
      end

      def call
        Paperback::Generators::Book.start
      end
    end
  end
end
