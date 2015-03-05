module Paperback
  class Metadata
    def self.book_name
      origin_url = Git.origin_url
      if origin_url.empty?
        File.basename(Dir.pwd)
      else
        origin_url
      end
    end
  end
end
