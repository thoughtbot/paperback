require 'spec_helper'

describe Paperback::Package do
  describe '#source' do
    it 'returns its markdown source' do
      package = Paperback::Package.new('franklin')

      expect(package.source).to eq('franklin.md')
    end
  end

  describe '#target' do
    it 'returns the target file for the given format' do
      stub_book_name 'adventure'
      package = Paperback::Package.new('franklin')

      expect(package.target(:pdf)).to eq('adventure.pdf')
    end

    it 'includes the suffix when given' do
      stub_book_name 'adventure'
      package = Paperback::Package.new('franklin', suffix: '-junior')

      expect(package.target(:pdf)).to eq('adventure-junior.pdf')
    end

    def stub_book_name(name)
      Paperback::Git.stubs(origin_url: "git://example.com/path/#{name}.git")
    end
  end
end
