require 'fileutils'
require 'paperback'
require 'paperback/generators/book'
require 'thor'

module Paperback
  class CLI < Thor
    include Thor::Actions

    desc 'build', 'Build all book formats'
    option :preview, desc: 'Open PDF format', type: :boolean
    def build
      clean
      copy_assets

      Paperback.sources.each do |source|
        book = Paperback::Book.new(source)
        book.generate

        if options[:preview]
          book.preview
        end
      end
    end

    desc 'clean', 'Remove build artifacts'
    def clean
      FileUtils.rm_rf Paperback.build_root
    end

    desc 'new [PATH]', 'Create a new Paperback project'
    def new(path)
      Paperback::Generators::Book.start [path]
    end

    desc 'release', 'Create a new release'
    def release
      if Paperback::Git.dirty?
        raise 'You have local changes; not releasing.'
      end

      build
      FileUtils.rm_rf Paperback.release_root
      FileUtils.cp_r Paperback.build_root, Paperback.release_root
    end

    private

    def copy_assets
      Paperback.build_root.mkpath
      images_root = Paperback.book_root.join('images')
      FileUtils.cp_r images_root, Paperback.build_root
    end
  end
end
