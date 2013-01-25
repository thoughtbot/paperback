require 'paperback/book'
require 'paperback/cover'
require 'paperback/configuration'
require 'paperback/git'
require 'paperback/markdown'
require 'pathname'

module Paperback
  def self.book_root
    Pathname.new 'book'
  end

  def self.build_root
    Pathname.new 'build'
  end

  def self.in_build_dir(&block)
    Dir.chdir build_root, &block
  end

  def self.release_root
    Pathname.new 'release'
  end

  def self.sources
    %w(book.md sample.md)
  end
end
