class SyntaxHighligher
  CODE_FENCE = '```'

  def initialize(file_path)
    @file_path = file_path
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

  attr_reader :file_path

  def language
    syntax_highlighter_config[file_type]
  end

  def syntax_highlighter_config
    ConfigParser.parse('syntax_highlighter')
  end

  def file_type
    File.extname(file_path).gsub(/\./, '')
  end
end
