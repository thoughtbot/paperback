require 'cocaine'

module Paperback
  class Hub
    def self.checkout(pull_request_url)
      Cocaine::CommandLine.new('hub checkout', pull_request_url).run
    end
  end
end
