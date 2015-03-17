module Paperback
  class Metadata
    def self.book_name
      repository_name = Git.repository_name

      if repository_name.empty?
        File.basename(Dir.pwd)
      else
        repository_name
      end
    end
  end
end
