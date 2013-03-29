require 'spec_helper'

describe Paperback::PandocVariables do
  it { should be_a(Enumerable) }

  describe '#each_pair' do
    it 'iterates each variable' do
      verify_iterator do |config|
        results = []
        config.each_pair do |key, value|
          results << [key, value]
        end
        results
      end
    end
  end

  describe '#each' do
    it 'iterates each variable' do
      verify_iterator do |config|
        results = []
        config.each do |(key, value)|
          results << [key, value]
        end
        results
      end
    end
  end

  def verify_iterator
    config = Paperback::PandocVariables.new(
      single: 'only value',
      multi: %w(one two)
    )

    results = yield(config)

    expect(results).to eq([
      ['variable', '"single:only value"'],
      ['variable', '"multi:one"'],
      ['variable', '"multi:two"']
    ])
  end
end
