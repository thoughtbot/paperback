require 'spec_helper'

describe SyntaxHighligher, '#code_start' do
  context 'known file type' do
    it 'returns a code fence and language' do
      syntax_highlighter = SyntaxHighligher.new(
        file_path: ruby_file,
        config_parser: stubbed_config_parser
      )

      expect(syntax_highlighter.code_start).to eq '```ruby'
    end
  end

  context 'unknown file type' do
    it 'returns a code fence with no language' do
      syntax_highlighter = SyntaxHighligher.new(
        file_path: unknown_file,
        config_parser: stubbed_config_parser
      )

      expect(syntax_highlighter.code_start).to eq '```'
    end
  end

  def stubbed_config_parser
    stub(parse: { 'rb' => 'ruby' })
  end

  def ruby_file
    'user.rb'
  end

  def unknown_file
    'user.xyz'
  end
end

describe SyntaxHighligher, '#code_end' do
  it 'returns a code fence' do
    syntax_highlighter = SyntaxHighligher.new(
      file_path: ruby_file,
      config_parser: stubbed_config_parser
    )

    expect(syntax_highlighter.code_end).to eq '```'
  end

  def stubbed_config_parser
    stub(parse: { 'rb' => 'ruby' })
  end

  def ruby_file
    'user.rb'
  end
end

describe SyntaxHighligher, '#code_path' do
  it 'returns a code fence' do
    syntax_highlighter = SyntaxHighligher.new(
      file_path: ruby_file,
      config_parser: stub(:config_parser)
    )

    expect(syntax_highlighter.code_path).to eq '# app/models/user.rb'
  end

  def ruby_file
    'app/models/user.rb'
  end
end
