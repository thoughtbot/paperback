require 'spec_helper'

describe Paperback::SyntaxHighlighter do
  describe '#to_ary' do
    before do
      allow(Paperback::Git).to receive(:show_example) { 'example' }
    end

    context 'known file type' do
      it 'includes a code fence with a language' do
        syntax_highlighter = Paperback::SyntaxHighlighter.new(
          '', 'user.rb', 'abc123', nil
        )

        actual = syntax_highlighter.to_ary

        expect(actual).to eq(['```ruby', '# user.rb', 'example', '```'])
      end
    end

    context 'unknown file type' do
      it 'includes a code fence with no language' do
        syntax_highlighter = Paperback::SyntaxHighlighter.new(
          '', 'user.xyz', 'abc123', nil
        )

        actual = syntax_highlighter.to_ary

        expect(actual).to eq(['```', '# user.xyz', 'example', '```'])
      end
    end
  end
end
