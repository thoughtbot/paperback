require 'fileutils'
require 'paperback'
require 'paperback/asset_sync'
require 'paperback/generators/book'
require 'thor'

module Paperback
  class CLI < Thor
    include Thor::Actions

    desc 'build', 'Build all packages and formats'
    def build
      clean
      copy_assets

      Package.all.each do |package|
        Book.new(package).generate
      end
    end

    desc 'clean', 'Remove build artifacts'
    def clean
      FileUtils.rm_rf Paperback.build_root
    end

    desc 'new [PATH]', 'Create a new Paperback project'
    def new(path)
      Generators::Book.start [path]
    end

    desc 'preview', 'Build and open book in PDF format'
    def preview
      truncate
      copy_assets
      Book.new(Package.book).preview
    end

    desc 'release', 'Push build artifacts to S3'
    def release
      build
      AssetSync.sync
    end

    desc 'review [PULL_REQUEST_URL]', 'Review a pull request'
    def review(pull_request_url)
      Hub.checkout pull_request_url
      preview
    end

    desc 'stats', 'Report book statistics'
    def stats
      truncate
      copy_assets
      puts Book.new(Package.book).stats
    end

    private

    def copy_assets
      Paperback.target_root.mkpath
      images_root = Paperback.book_root.join('images')
      FileUtils.cp_r images_root, Paperback.target_root
    end

    def truncate
      Package.all.each do |package|
        target = Paperback.target_root.join(package.target(:markdown))

        if target.exist?
          target.truncate 0
        end
      end
    end
  end
end
