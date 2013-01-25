require 'pathname'
require 'spec_helper'

describe Paperback do
  describe '#book_root' do
    it do
      Paperback.book_root.should == Pathname.new('book')
    end
  end

  describe '#build_root' do
    it do
      Paperback.build_root.should == Pathname.new('build')
    end
  end

  describe '#release_root' do
    it do
      Paperback.release_root.should == Pathname.new('release')
    end
  end

  describe '#sources' do
    it do
      Paperback.sources.should == %w(book.md sample.md)
    end
  end
end
