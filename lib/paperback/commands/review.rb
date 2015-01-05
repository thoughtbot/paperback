require "paperback"

module Paperback
  module Commands
    class Review
      def initialize(pull_request_url)
        @pull_request_url = pull_request_url
      end

      def self.call(pull_request_url)
        new(pull_request_url).call
      end

      def call
        Paperback::Hub.checkout pull_request_url
        Paperback::Commands::Preview.call
      end

      private

      attr_reader :pull_request_url
    end
  end
end
