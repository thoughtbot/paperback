module Paperback
  class Package
    class << self
      private

      def all
        [book, sample]
      end

      def sample
        new "sample", suffix: "-sample"
      end
    end

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
        .join("#{Metadata.book_name}#{suffix}")
        .sub_ext ".#{extension}"
    end

    private

    attr_reader :suffix
  end
end
