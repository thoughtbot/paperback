require 'aws-sdk'
require 'mime-types'
require 'pathname'

module Paperback
  module Storage
    class S3
      attr_reader :file_path, :bucket_name

      def initialize(file_path = ENV['AWS_FILE_PATH'], bucket_name = ENV['AWS_BUCKET'])
        @file_path = Pathname.new(file_path.to_s)
        @bucket_name = bucket_name
      end

      def save_all(dir)
        upload_files(dir, dir)
      end

      private

      def upload_files(root_dir, pathname)
        if pathname.file?
          upload_file(root_dir, pathname)
        else
          pathname.children.each { |file| upload_files(root_dir, file) }
        end
      end

      def upload_file(root_dir, pathname)
        relative_path = pathname.relative_path_from(root_dir)
        s3_file = bucket.objects[file_path + relative_path]
        s3_file.write(pathname, content_type: content_type(pathname))
      end

      def content_type(pathname)
        MIME::Types.of(pathname.to_s).first.to_s
      end

      def bucket
        @bucket ||= s3.buckets.create(bucket_name)
      end

      def s3
        AWS::S3.new
      end
    end
  end
end
