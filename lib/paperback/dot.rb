module Paperback
  class Dot
    def self.to_png(graph_title)
      "| dot -Tpng -o build/images/#{graph_title}-graph.png"
    end
  end
end
