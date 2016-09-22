require "English"
require "paperback/commands"
require "paperback/cover"
require "paperback/formats"
require "paperback/generators"
require "paperback/git"
require "paperback/metadata"
require "paperback/hub"
require "paperback/markdown"
require "paperback/markdown_image_filter"
require "paperback/package"
require "paperback/pandoc_generator"
require "paperback/pandoc_runner"
require "paperback/stats"
require "paperback/syntax_highlighter"
require "pathname"

module Paperback
  def self.book_root
    root.join "book"
  end

  def self.build_root
    root.join "build"
  end

  def self.root
    Pathname.new Dir.pwd
  end

  def self.target_root
    build_root.join Metadata.book_name
  end
end
