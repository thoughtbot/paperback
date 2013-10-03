require 'aws-sdk'
require 'mime-types'

module Paperback
  module Storage
    class S3
      def save_all(dir)
        upload_files dir, dir
      end

      private

      def upload_files(root_dir, pathname)
        if pathname.file?
          upload_file root_dir, pathname
        else
          pathname.children.each { |file| upload_files(root_dir, file) }
        end
      end

      def upload_file(root_dir, pathname)
        key = file_path + pathname.relative_path_from(root_dir)
        objects.create key, pathname, content_type: content_type(pathname)
      end

      def file_path
        aws_file_path = ENV['AWS_FILE_PATH'] || ''
        @file_path ||= Pathname.new(aws_file_path)
      end

      def objects
        bucket.objects
      end

      def bucket
        @bucket ||= AWS::S3.new.buckets.create(ENV['AWS_BUCKET'])
      end

      def content_type(pathname)
        MIME::Types.of(pathname.to_s).first.to_s
      end
    end
  end
end
