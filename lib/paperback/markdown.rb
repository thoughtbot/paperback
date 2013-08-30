module Paperback
  class Markdown
    module Regex
      CODE = /
        (?<indentation>\s*)`\s
        (?<file_path>[\w\/\.]+)
        @
        (?<git_ref>[\w]+)
        (?::
          (?<line_range>\d+(?:,\d+)?)
        )?
      /x

      CLOSE_DOT_BLOCK = /```tod/

      FILE = /
        \<\<
        \[
        (?<file_path>.+)
        \]
      /x

      OPEN_DOT_BLOCK = /```dot/
    end

    def initialize(source, root = nil)
      @input = Paperback.book_root.join(source)
      @root = root || source
    end

    def generate
      @input.each_line do |line|
        case line
        when Regex::OPEN_DOT_BLOCK
          open_buffer
        when Regex::CLOSE_DOT_BLOCK
          graph = DotGraph.new(@buffer.join)
          close_buffer
          append link_to_image(graph.filename)
        when Regex::CODE
          append SyntaxHighlighter.new(
            $~[:indentation],
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

    def add_to_buffer(line)
      @buffer.push(line)
    end

    def append(line)
      if @buffer
        add_to_buffer(line)
      else
        Paperback.in_build_dir do
          File.open(@root, 'a') do |f|
            f.puts line
          end
        end
      end
    end

    def close_buffer
      @buffer = nil
    end

    def import(file_path)
      self.class.new(file_path, @root).generate
    end

    def link_to_image(filename)
      "![Alt text](images/#{filename})"
    end

    def open_buffer
      @buffer = []
    end
  end
end
