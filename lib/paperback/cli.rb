require 'fileutils'
require 'paperback'
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

    desc 'release', 'Create a new release'
    def release
      if Git.dirty?
        raise 'You have local changes; not releasing.'
      end

      build
      FileUtils.rm_rf Paperback.release_root
      FileUtils.cp_r Paperback.build_root, Paperback.release_root
    end

    desc 'review', 'Review a pull request'
    def review(pull_request_id)
      Hub.checkout pull_request_id
      preview
    end

    private

    def copy_assets
      Paperback.build_root.mkpath
      images_root = Paperback.book_root.join('images')
      FileUtils.cp_r images_root, Paperback.build_root
    end

    def truncate
      Package.all.each do |package|
        target = Paperback.build_root.join(package.target(:markdown))

        if target.exist?
          target.truncate 0
        end
      end
    end
  end
end
