require "terrapin"

module Paperback
  class Hub
    def self.checkout(pull_request_url)
      Terrapin::CommandLine.new("hub checkout", pull_request_url).run
    end
  end
end
