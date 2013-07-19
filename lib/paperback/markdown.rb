module Paperback
  class Markdown
    module Regex
      CODE = /
        ^`\s
        (?<file_path>[a-z0-9_\/]+\.[a-z\.]+)
        @
        (?<git_ref>[\w]+)
        (?::
          (?<line_range>\d+(?:,\d+)?)
        )?
      /x

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
            $~[:file_path],
            $~[:git_ref],
            $~[:line_range]
          )
        when Regex::FILE
          import $~[:file_path]
        else
          append line
        end
      end
    end

    private

    def append(line)
      Paperback.in_build_dir do
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
