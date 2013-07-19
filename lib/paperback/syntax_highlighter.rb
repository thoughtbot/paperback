module Paperback
  class SyntaxHighlighter
    CODE_FENCE = '```'

    FILE_TYPES = {
      coffee: 'javascript',
      erb: 'rhtml',
      js: 'javascript',
      rb: 'ruby'
    }

    def initialize(file_path, git_ref, line_range)
      @file_path = file_path
      @git_ref = git_ref
      @line_range = line_range
    end

    def to_ary
      [
        code_start,
        code_path,
        Git.show_example(file_path, git_ref, line_range),
        CODE_FENCE
      ]
    end

    private

    attr_reader :file_path, :git_ref, :line_range

    def code_path
      "# #{file_path}"
    end

    def code_start
      "#{CODE_FENCE}#{language}"
    end

    def file_type
      File.extname(file_path).delete('.')
    end

    def language
      FILE_TYPES[file_type.to_sym]
    end
  end
end
