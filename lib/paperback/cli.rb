require "paperback"
require "thor"

module Paperback
  class CLI < Thor
    desc "build", "Build packages and formats"
    option :format
    option :package
    def build
      Paperback::Commands::Build.call options[:package], options[:format]
    end

    desc "clean", "Remove build artifacts"
    def clean
      Paperback::Commands::Clean.call
    end

    desc "new", "Create a new Paperback project in the current directory"
    def new
      Paperback::Commands::New.call
    end

    desc "preview", "Build the book in HTML format"
    def preview
      Paperback::Commands::Preview.call
    end

    desc "review [PULL_REQUEST_URL]", "Review a pull request"
    def review(pull_request_url)
      Paperback::Commands::Review.call pull_request_url
    end

    desc "stats", "Report book statistics"
    def stats
      Paperback::Commands::Stats.call
    end
  end
end
