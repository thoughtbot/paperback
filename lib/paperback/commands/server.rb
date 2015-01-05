require "launchy"
require "paperback"

module Paperback
  module Commands
    class Server
      def self.call
        new.call
      end

      def call
        Paperback::Commands::Preview.call

        Paperback::Server.run! do |server|
          host = server.config[:BindAddress]
          port = server.config[:Port]
          Launchy.open "http://#{host}:#{port}"
        end
      end
    end
  end
end
