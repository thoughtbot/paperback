module Paperback
  class Markdown
    module Regex
      FILE = /
        \<\<
        \[
        (?<file_path>.+)
        \]
      /x
    end

    def initialize(source, output)
      @input = Paperback.book_root.join(source)
      @output = output
    end

    def generate
      @input.each_line do |line|
        case line
        when SyntaxHighlighter::Regex::CODE
          append SyntaxHighlighter.new($LAST_MATCH_INFO)
        when Regex::FILE
          import $LAST_MATCH_INFO[:file_path]
        else
          append MarkdownImageFilter.new(line)
        end
      end
    end

    private

    def append(line)
      @output.open("a") do |f|
        f.puts line
      end
    end

    def import(file_path)
      self.class.new(file_path, @output).generate
    end
  end
end
