require 'spec_helper'

describe Paperback::SyntaxHighlighter do
  describe '#to_ary' do
    before do
      Paperback::Git.stubs(:show_example).returns 'example'
    end

    context 'with a known file type' do
      it 'includes a code fence with a language' do
        syntax_highlighter = Paperback::SyntaxHighlighter.new(
          '', 'user.rb', 'abc123', nil
        )

        actual = syntax_highlighter.to_ary

        expect(actual).to eq(['```ruby', '# user.rb', 'example', '```'])
      end
    end

    context 'with a line range' do
      it 'includes an anchored code path' do
        syntax_highlighter = Paperback::SyntaxHighlighter.new(
          '', 'user.xyz', 'abc123', '1,2'
        )

        actual = syntax_highlighter.to_ary

        expect(actual).to eq(['```', '# user.xyz#L1-2', 'example', '```'])
      end
    end

    context 'with an unknown file type' do
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
