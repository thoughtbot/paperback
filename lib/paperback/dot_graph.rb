require 'pathname'

module Paperback
  class DotGraph
    module Regex
      GRAPH_TITLE = /(?<graph_title>graph\s\w+)\s\{/
    end

    def initialize(graph)
      @dot_graph_code_block = graph
      build_png
    end

    def filename
      graph_title.sub(' ', '-') << '.png'
    end

    private

    def dot_graph_code_block
      @dot_graph_code_block
    end

    def graph_title
      @graph_title ||= dot_graph_code_block.match(
        Regex::GRAPH_TITLE
      )[:graph_title]
    end

    def build_png
      Cocaine::CommandLine.new(
        "echo '#{dot_graph_code_block}'",
        "| dot -Tpng -o build/images/#{filename}"
      ).run
    end
  end
end
