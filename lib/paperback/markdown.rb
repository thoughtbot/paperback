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

    def initialize(source, root = nil)
      @input = Paperback.book_root.join(source)
      @root = root || source
    end

    def generate
      @input.each_line do |line|
        case line
        when SyntaxHighlighter::Regex::CODE
          append SyntaxHighlighter.new($LAST_MATCH_INFO)
        when Regex::FILE
          import $LAST_MATCH_INFO[:file_path]
        else
          append line
        end
      end
    end

    private

    def append(line)
      Paperback.in_target_dir do
        File.open(@root, 'a') do |f|
          f.puts line
        end
      end
    end

    def import(file_path)
      self.class.new(file_path, @root).generate
    end
  end
end
