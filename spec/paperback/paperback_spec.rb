require 'spec_helper'

describe Paperback do
  describe '#book_root' do
    it do
      Paperback.book_root.should be_an_expanded_pathname('book')
    end
  end

  describe '#build_root' do
    it do
      Paperback.build_root.should be_an_expanded_pathname('build')
    end
  end

  describe '#release_root' do
    it do
      Paperback.release_root.should be_an_expanded_pathname('release')
    end
  end

  describe '#root' do
    it do
      Paperback.root.should be_an_expanded_pathname('.')
    end
  end

  describe '#sources' do
    it do
      Paperback.sources.should == %w(book.md sample.md)
    end
  end
end
