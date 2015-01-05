require "fileutils"
require "paperback"

module Paperback
  module Commands
    class CopyAssets
      def self.call
        new.call
      end

      def call
        Paperback::Commands::Clean.call
        Paperback.target_root.mkpath
        images_root = Paperback.book_root.join("images")
        FileUtils.cp_r images_root, Paperback.target_root
      end
    end
  end
end
