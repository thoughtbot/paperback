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

    def initialize(source, target)
      @source = Paperback.book_root.join(source)
      @target = target
    end

    def self.generate(package)
      target = package.target(:md)

      unless target.exist?
        new("#{package.source}", target).generate
      end
    end

    def generate
      source.each_line do |line|
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

    attr_reader :source
    attr_reader :target

    def append(line)
      target.open("a") do |f|
        f.puts line
      end
    end

    def import(file_path)
      self.class.new(file_path, target).generate
    end
  end
end
