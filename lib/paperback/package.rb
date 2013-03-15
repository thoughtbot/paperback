module Paperback
  class Package
    EXTENSIONS = {
      epub: 'epub',
      html: 'html',
      markdown: 'md',
      mobi: 'mobi',
      pdf: 'pdf'
    }

    def initialize(name, options = {})
      @name = name
      @suffix = options[:suffix] || ''
    end

    def self.all
      [book, sample]
    end

    def self.book
      new 'book'
    end

    def source
      "#{@name}.#{extension(:markdown)}"
    end

    def target(format)
      "#{git_name}#{@suffix}.#{extension(format)}"
    end

    private

    def extension(format)
      EXTENSIONS[format]
    end

    def git_name
      File.basename Git.origin_url, '.git'
    end

    def self.sample
      new 'sample', suffix: '-sample'
    end
  end
end
