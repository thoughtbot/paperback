module Paperback
  class Markdown
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
        when Regex::CODE
          append SyntaxHighlighter.new(
            file_path: $LAST_MATCH_INFO[:file_path],
            git_ref: $LAST_MATCH_INFO[:git_ref],
            indentation: $LAST_MATCH_INFO[:indentation],
            line_range: $LAST_MATCH_INFO[:line_range]
          )
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
