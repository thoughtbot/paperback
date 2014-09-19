require "active_support/core_ext/string/indent"
require "coderay"

module Paperback
  class SyntaxHighlighter
    CODE_FENCE = "```"

    module Regex
      CODE = %r{
        (?<indentation>\s*)`\s
        (?<file_path>[\w/\.]+)
        @
        (?<git_ref>[\w]+)
        (?::
          (?<line_range>\d+(?:,\d+)?)
        )?
      }x
    end

    def initialize(config)
      @file_path = config[:file_path]
      @git_ref = config[:git_ref]
      @indentation = config[:indentation]
      @line_range = config[:line_range]
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
      CodeRay::FileType::TypeFromExt["coffee"] = :coffee
      CodeRay::FileType::TypeFromExt["erb"] = :rhtml
      CodeRay::FileType[file_path, true]
    end
  end
end
