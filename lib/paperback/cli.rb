require "fileutils"
require "launchy"
require "paperback"
require "paperback/generators/book"
require "paperback/server"
require "thor"

module Paperback
  class CLI < Thor
    include Thor::Actions

    desc "build", "Build all packages and formats"
    def build
      copy_assets

      Package.all.each do |package|
        Book.new(package).generate
      end
    end

    desc "clean", "Remove build artifacts"
    def clean
      FileUtils.rm_rf Paperback.build_root
    end

    desc "new [PATH]", "Create a new Paperback project"
    def new(path)
      Generators::Book.start [path]
    end

    desc "preview", "Build the book in HTML format"
    def preview
      copy_assets
      Book.new(Package.book).preview
    end

    desc "review [PULL_REQUEST_URL]", "Review a pull request"
    def review(pull_request_url)
      Hub.checkout pull_request_url
      preview
    end

    desc "server", "Start the Paperback server"
    def server
      preview

      Paperback::Server.run! do |server|
        host = server.config[:BindAddress]
        port = server.config[:Port]
        Launchy.open "http://#{host}:#{port}"
      end
    end

    desc "stats", "Report book statistics"
    def stats
      copy_assets
      puts Book.new(Package.book).stats
    end

    private

    def copy_assets
      clean
      Paperback.target_root.mkpath
      images_root = Paperback.book_root.join("images")
      FileUtils.cp_r images_root, Paperback.target_root
    end
  end
end
