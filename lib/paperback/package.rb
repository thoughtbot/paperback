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

    def source
      "#{@name}.#{extension(:markdown)}"
    end

    def target(format)
      "#{book_name}#{@suffix}.#{extension(format)}"
    end

    private

    def extension(format)
      EXTENSIONS[format]
    end

    def book_name
      File.basename(Git.origin_url, '.git')
    end
  end
end
