require 'cocaine'

module Paperback
  class Hub
    def self.checkout(pull_request_id)
      pull_request_url = "#{repository_url}/pull/#{pull_request_id}"
      Cocaine::CommandLine.new('hub checkout', pull_request_url).run
    end

    private

    def self.repository_url
      "https://github.com/#{username}/#{Git.repository_name}"
    end

    def self.username
      Git.origin_url.split(%r{[:/]})[-2]
    end
  end
end
