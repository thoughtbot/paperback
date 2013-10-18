require 'active_support/core_ext/string/indent'
require 'coderay'

module Paperback
  class SyntaxHighlighter
    CODE_FENCE = '```'

    def initialize(options)
      @file_path = options[:file_path]
      @git_ref = options[:git_ref]
      @indentation = options[:indentation]
      @line_range = options[:line_range]
    end

    def to_ary
      [
        code_start,
        code_path,
        Git.show_example(file_path, git_ref, line_range),
        CODE_FENCE
      ].map do |text|
        text.indent @indentation.size
      end
    end

    private

    attr_reader :file_path, :git_ref, :line_range

    def code_path
      "# #{file_path}"
    end

    def code_start
      "#{CODE_FENCE}#{language}"
    end

    def language
      CodeRay::FileType::TypeFromExt['coffee'] = :coffee
      CodeRay::FileType::TypeFromExt['erb'] = :rhtml
      CodeRay::FileType[file_path, true]
    end
  end
end
