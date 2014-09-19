require "nokogiri"

module Paperback
  class SplitHtml
    CHAPTERS_SELECTOR = ".level1"

    def initialize(package)
      @package = package
    end

    def generate
      target_subdir.mkpath

      chapters.each do |chapter|
        write chapter["id"], wrap(chapter, chapter.at_css("h1").text)
      end
    end

    private

    def chapters
      html.css CHAPTERS_SELECTOR
    end

    def html
      @html ||= parse_single_page_html
    end

    def parse_single_page_html
      File.open(@package.target(:html)) do |io|
        Nokogiri::HTML(io).tap do |node|
          rewrite_fragments_to_relative_urls node
        end
      end
    end

    def rewrite_fragments_to_relative_urls(node)
      node.css("a").each do |a|
        a["href"] = a["href"].gsub(/#(.+)/, '\1.html')
      end
    end

    def target_subdir
      @target_subdir ||= Pathname.new("chapters")
    end

    def wrap(node, subtitle)
      html.dup.tap do |wrapper|
        wrapper.title = "#{html.title}: #{subtitle}"
        wrapper.at_css("body").inner_html = node
      end
    end

    def write(filename, node)
      target_subdir.join("#{filename}.html").open("w") do |io|
        node.write_xhtml_to io
      end
    end
  end
end
