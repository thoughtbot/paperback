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

      DOT_GRAPH = /```dot\s([^`]+)```/

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
      generate_dot_graphs

      @input.each_line do |line|
        case line
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

      replace_graphs_with_links
    end

    private

    def append(line)
      Paperback.in_build_dir do
        File.open(@root, 'a') do |f|
          f.puts line
        end
      end
    end

    def dot_code_blocks
      @input.read.scan(Regex::DOT_GRAPH).flatten
    end

    def generate_dot_graphs
       dot_code_blocks.each do |graph|
         DotGraph.new(graph).generate_png
       end
    end

    def import(file_path)
      self.class.new(file_path, @root).generate
    end

    def replace_graphs_with_links
      Paperback.in_build_dir do
        lines = File.open(@root).readlines
        File.open(@root, 'w') do |f|
          f.puts lines.join.gsub(Regex::DOT_GRAPH, '![Alt text](images/test-graph.png)')
        end
      end
    end
  end
end
