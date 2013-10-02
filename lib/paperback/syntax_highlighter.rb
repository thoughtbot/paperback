require 'active_support/core_ext/string/indent'
require 'coderay'

module Paperback
  class SyntaxHighlighter
    CODE_FENCE = '```'

    def initialize(indentation, file_path, git_ref, line_range)
      @indentation = indentation
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
      ].map do |text|
        text.indent(@indentation.size)
      end
    end

    private

    attr_reader :file_path, :git_ref, :line_range

    def code_path
      "# #{file_path}#{line_range_anchor}"
    end

    def code_start
      "#{CODE_FENCE}#{language}"
    end

    def language
      CodeRay::FileType::TypeFromExt['coffee'] ||= :coffee
      CodeRay::FileType::TypeFromExt['erb'] = :rhtml
      CodeRay::FileType[file_path, true]
    end

    def line_range_anchor
      if line_range
        hyphenated_line_range = line_range.sub(/,/, '-')
        "#L#{hyphenated_line_range}"
      end
    end
  end
end
