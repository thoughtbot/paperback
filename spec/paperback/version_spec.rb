require 'spec_helper'

describe Paperback::VERSION do
  it do
    expect(Paperback::VERSION).to_not be_empty
  end
end
