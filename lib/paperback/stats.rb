require 'pdf-reader'
require 'terminal-table'

module Paperback
  class Stats
    def initialize(pdf_path)
      @pdf_reader = PDF::Reader.new(pdf_path)
    end

    def chapters_completed_count
      @chapters_completed_count ||= count_unique_matches(/^CHAPTER [\d]+/)
    end

    def chapters_remaining_count
      @chapters_remaining_count ||= count_matched_pages(/STUB/)
    end

    def pages_completed_count
      pages_count - chapters_remaining_count
    end

    def pages_count
      @pdf_reader.page_count
    end

    def to_s
      Terminal::Table.new {|t|
        t << ['Pages', pages_count]
        t << ['Pages Completed', pages_completed_count]
        t << ['Chapters Completed', chapters_completed_count]
        t << ['Chapters Remaining', chapters_remaining_count]
      }.to_s
    end

    private

    def count_matched_pages(regex)
      @pdf_reader.pages.count {|p| p.text.match(regex) }
    end

    def count_unique_matches(regex)
      @pdf_reader.pages.map {|p| p.text[regex] }.compact.uniq.count
    end
  end
end
