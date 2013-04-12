require 'spec_helper'

describe SyntaxHighligher, '#code_start' do
  context 'known file type' do
    it 'returns a code fence and language' do
      stub_config_parser

      syntax_highlighter = SyntaxHighligher.new(known_file_type)

      expect(syntax_highlighter.code_start).to eq '```ruby'
    end
  end

  context 'unknown file type' do
    it 'returns a code fence with no language' do
      stub_config_parser

      syntax_highlighter = SyntaxHighligher.new(unknown_file_type)

      expect(syntax_highlighter.code_start).to eq '```'
    end
  end

  def stub_config_parser
    ConfigParser.stubs(parse: { 'rb' => 'ruby' })
  end

  def known_file_type
    'user.rb'
  end

  def unknown_file_type
    'user.xyz'
  end
end

describe SyntaxHighligher, '#code_end' do
  it 'returns a code fence' do
    syntax_highlighter = SyntaxHighligher.new(file_path)

    expect(syntax_highlighter.code_end).to eq '```'
  end

  def file_path
    'user.rb'
  end
end

describe SyntaxHighligher, '#code_path' do
  it 'returns a code fence' do
    syntax_highlighter = SyntaxHighligher.new(file_path)

    expect(syntax_highlighter.code_path).to eq '# app/models/user.rb'
  end

  def file_path
    'app/models/user.rb'
  end
end
