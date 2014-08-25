module Paperback
  class MarkdownImageFilter
    module Regex
      PARENTAL_PATH = %r{
        (?<prefix>!\[[^\]]*\]\()
        ((\.\.\/)+)
        (?<suffix>[^)]+\))
      }x
    end

    def initialize(text)
      @text = text
    end

    def to_s
      text.gsub Regex::PARENTAL_PATH, '\k<prefix>\k<suffix>'
    end

    private

    attr_reader :text
  end
end
