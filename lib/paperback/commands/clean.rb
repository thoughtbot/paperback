require "fileutils"
require "paperback"

module Paperback
  module Commands
    class Clean
      def self.call
        new.call
      end

      def call
        FileUtils.rm_rf Paperback.build_root
      end
    end
  end
end
