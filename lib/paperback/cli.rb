require 'fileutils'
require 'paperback'
require 'paperback/generators/book'
require 'thor'

module Paperback
  class CLI < Thor
    include Thor::Actions

    desc 'build', 'Builds all book formats'
    def build
      clean
      copy_assets

      Paperback.sources.each do |source|
        Paperback::Book.new(source).generate
      end
    end

    desc 'clean', 'Removes build artifacts'
    def clean
      FileUtils.rm_rf Paperback.build_root
    end

    desc 'new [PATH]', 'Creates a new Paperback project'
    def new(path)
      Paperback::Generators::Book.start [path]
    end

    desc 'release', 'Creates a new release'
    def release
      if Paperback::Git.dirty?
        raise 'You have local changes; not releasing.'
      end

      build
      target = Paperback.release_root
      FileUtils.rm_rf target
      FileUtils.cp_r Paperback.build_root, target
    end

    private

    def copy_assets
      Paperback.build_root.mkpath
      images_root = Paperback.book_root.join('images')
      FileUtils.cp_r images_root, Paperback.build_root
    end
  end
end
