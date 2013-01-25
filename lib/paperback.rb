require 'paperback/book'
require 'paperback/cover'
require 'paperback/configuration'
require 'paperback/git'
require 'paperback/markdown'
require 'pathname'

module Paperback
  def self.book_root
    root.join 'book'
  end

  def self.build_root
    root.join 'build'
  end

  def self.in_build_dir(&block)
    build_root.mkpath
    Dir.chdir build_root, &block
  end

  def self.release_root
    root.join 'release'
  end

  def self.root
    Pathname.new Dir.pwd
  end

  def self.sources
    %w(book.md sample.md)
  end
end
