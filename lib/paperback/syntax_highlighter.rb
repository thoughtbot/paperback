class SyntaxHighligher
  CODE_FENCE = '```'

  def initialize(attrs = {})
    @config_parser = attrs[:config_parser]
    @file_path = attrs[:file_path]
  end

  def code_start
    [CODE_FENCE, language].join('')
  end

  def code_path
    ['#', file_path].join(' ')
  end

  def code_end
    CODE_FENCE
  end

  private

  def language
    syntax_highlighter_config[file_type]
  end

  def syntax_highlighter_config
    config_parser.parse('syntax_highlighter')
  end

  def file_type
    File.extname(file_path).gsub(/\./, '')
  end

  attr_reader :file_path, :config_parser
end
