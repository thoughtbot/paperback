require 'spec_helper'

describe Paperback::DotGraph, '#filename' do
  it 'returns the filename of the graph' do
    Cocaine::CommandLine.stubs(new: stub(:run))
    graph = Paperback::DotGraph.new(dot_code_block)

    expect(graph.filename).to eq 'graph-test.png'
  end
end

describe Paperback::DotGraph, '#title' do
  it 'returns the title of the graph' do
    Cocaine::CommandLine.stubs(new: stub(:run))
    graph = Paperback::DotGraph.new(dot_code_block)

    expect(graph.title).to eq 'graph test'
  end
end

def dot_code_block
  <<-TEXT
    graph test {
      a -- b;
      a -- c;
      b -- c;
    }
  TEXT
end
