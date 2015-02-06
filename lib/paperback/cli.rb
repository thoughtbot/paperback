require "paperback"
require "thor"

module Paperback
  class CLI < Thor
    desc "build", "Build all packages and formats"
    def build
      Paperback::Commands::Build.call
    end

    desc "clean", "Remove build artifacts"
    def clean
      Paperback::Commands::Clean.call
    end

    desc "new [PATH]", "Create a new Paperback project"
    def new(path)
      Paperback::Commands::New.call path
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
