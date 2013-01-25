require 'spec_helper'

describe Paperback::VERSION do
  it do
    Paperback::VERSION.should_not be_empty
  end
end
