require 'spec_helper'
require 'aruba/api'
require 'pathname'

module Paperback
  module Storage
    describe S3 do
      include Aruba::Api

      describe '#save_all' do
        before do
          @s3 = Paperback::Storage::S3.new

          @client = AWS::S3::Client.any_instance
          @client.stubs :create_bucket
          @objects = AWS::S3::ObjectCollection.any_instance
          @objects.stubs :create

          @current_path = Pathname.new(current_dir)
          FileUtils.rm_rf @current_path
          @path_one = Pathname.new('file.txt')
          write_file @path_one, ''
          @path_two = Pathname.new('folder/file.txt')
          write_file @path_two, ''
        end

        it 'creates the bucket' do
          ClimateControl.modify(AWS_BUCKET: 'paperback_test') do
            options = { bucket_name: ENV['AWS_BUCKET'] }

            @s3.save_all @current_path

            expect(@client).to have_received(:create_bucket).with(options)
          end
        end

        context 'when AWS_FILE_PATH is nil' do
          it 'writes to the bucket root' do
            ClimateControl.modify(AWS_FILE_PATH: nil) do
              @s3.save_all @current_path

              verify_create @path_one
              verify_create @path_two
            end
          end
        end

        context 'when AWS_FILE_PATH is present' do
          it 'writes to a prefix' do
            ClimateControl.modify(AWS_FILE_PATH: 'foo') do
              @s3.save_all @current_path

              verify_create @path_one
              verify_create @path_two
            end
          end
        end

        def verify_create(path)
          aws_file_path = ENV['AWS_FILE_PATH'] || ''
          key = Pathname.new(aws_file_path) + path
          data = @current_path + path
          options = { content_type: 'text/plain' }

          expect(@objects).to have_received(:create).with(key, data, options)
        end
      end
    end
  end
end
