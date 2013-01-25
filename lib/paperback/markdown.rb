module Paperback
  class Markdown
    module Regex
      CODE = /\<\<\((.+)\)/
      EXAMPLE = /^` ([a-z0-9_\/]+\.[a-z\.]+)@([0-9a-f]+)(?::(\d+(?:,\d+)?))?/
      RAW = /\<\<\[(.+)\]/
    end

    def initialize(source, root = nil)
      @input = Paperback.book_root.join(source)
      @root = root || source
    end

    def generate
      @input.each_line do |line|
        case line
        when Regex::CODE
          append "```#{language($1)}"
          append "# #{$1}"
          import $1
          append '```'
        when Regex::EXAMPLE
          append "```#{language($1)}"
          append "# #{$1}"
          append Git.show_example($1, $2, $3)
          append '```'
        when Regex::RAW
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

    def language(path)
      if File.extname(path) == '.erb'
        'rhtml'
      else
        'ruby'
      end
    end

    def import(path)
      self.class.new(path, @root).generate
    end
  end
end
