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

  describe '#root' do
    it do
      expect(Paperback.root).to be_an_expanded_pathname('.')
    end
  end

  describe '#target_root' do
    it do
      repository = 'a-nice-adventure'
      origin_url = "https://github.com/thoughtbot/#{repository}.git"
      allow(Paperback::Git).to receive(:origin_url) { origin_url }
      expected = "build/#{repository}"

      expect(Paperback.target_root).to be_an_expanded_pathname(expected)
    end
  end
end
