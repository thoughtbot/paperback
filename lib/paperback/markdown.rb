module Paperback
  class Markdown
    module Regex
      CODE = /^` ([a-z0-9_\/]+\.[a-z\.]+)@([\w]+)(?::(\d+(?:,\d+)?))?/
      FILE = /\<\<\[(.+)\]/
    end

    def initialize(source, root = nil)
      @input = Paperback.book_root.join(source)
      @root = root || source
    end

    def generate
      @input.each_line do |line|
        case line
        when Regex::CODE
          syntax_highligher = SyntaxHighligher.new($1)
          append syntax_highligher.code_start
          append syntax_highligher.code_path
          append Git.show_example($1, $2, $3)
          append syntax_highligher.code_end
        when Regex::FILE
          import $1
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

    def import(path)
      self.class.new(path, @root).generate
    end
  end
end
