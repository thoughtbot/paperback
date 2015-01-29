module Paperback
  class Package
    attr_reader :name

    def initialize(name, options = {})
      @name = name
      @suffix = options[:suffix]
    end

    def self.book
      new "book"
    end

    def self.select(name = nil)
      all.select do |package|
        name.nil? || package.name == name
      end
    end

    def source
      "#{name}.md"
    end

    def target(extension)
      Paperback
        .target_root
        .join("#{Git.repository_name}#{suffix}")
        .sub_ext ".#{extension}"
    end

    private

    attr_reader :suffix

    def self.all
      [book, sample]
    end

    def self.sample
      new "sample", suffix: "-sample"
    end
  end
end
