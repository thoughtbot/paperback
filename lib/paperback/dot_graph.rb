require 'pathname'

module Paperback
  module Regex
    GRAPH_TITLE = /\b\s(?<graph_title>\w+)\s\{/
  end

  class DotGraph
    def initialize(graph)
      @dot_graph_code_block = graph
    end

    def generate_png
      Cocaine::CommandLine.new(
        "echo '#{dot_graph_code_block}'",
        Dot.to_png(graph_title)
      ).run
    end

    private

    def dot_graph_code_block
      @dot_graph_code_block
    end

    def graph_title
      dot_graph_code_block.match(Regex::GRAPH_TITLE)[:graph_title]
    end
  end
end
