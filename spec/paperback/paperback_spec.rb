require 'spec_helper'

describe Paperback do
  describe '#book_root' do
    it do
      expect(Paperback.book_root).to be_an_expanded_pathname('book')
    end
  end

  describe '#build_root' do
    it do
      expect(Paperback.build_root).to be_an_expanded_pathname('build')
    end
  end

  describe '#release_root' do
    it do
      expect(Paperback.release_root).to be_an_expanded_pathname('release')
    end
  end

  describe '#root' do
    it do
      expect(Paperback.root).to be_an_expanded_pathname('.')
    end
  end

  describe '#sources' do
    it do
      expect(Paperback.sources).to eq(%w(book.md sample.md))
    end
  end
end
