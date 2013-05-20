require 'spec_helper'

module Paperback
  module Storage
    describe S3 do
      subject do
        described_class.new('test/files', 'paperback_test')
      end

      let(:fixtures_dir) { File.expand_path('../../fixtures/s3', __FILE__) }
      let(:aws_s3) { AWS::S3.new }
      let(:bucket) { aws_s3.buckets['paperback_test'] }

      before do
        FileUtils.mkdir_p fixtures_dir
        bucket.clear!
      end

      after do
        FileUtils.rm_rf fixtures_dir
      end

      it 'creates the bucket with the given name' do
        subject.save_all(Pathname.new(fixtures_dir))
        expect(bucket).to exist
      end

      context 'uploading files' do
        before do
          File.write(fixtures_dir + '/file1.txt', 'I AM FILE 1')
          FileUtils.mkdir_p(fixtures_dir + '/folder')
          File.write(fixtures_dir + '/folder/file2.txt', 'I AM FILE 2')
        end

        it 'uploads all the files in a directory' do
          subject.save_all(Pathname.new(fixtures_dir))
          expect(bucket.objects['test/files/file1.txt'].read).to eq('I AM FILE 1')
          expect(bucket.objects['test/files/folder/file2.txt'].read).to eq('I AM FILE 2')
        end

        context 'file path has trailing slash' do
          subject { described_class.new('test/files/', 'paperback_test') }

          it 'uploads all files with the correct directory' do
            subject.save_all(Pathname.new(fixtures_dir))
            expect(bucket.objects['test/files/file1.txt'].read).to eq('I AM FILE 1')
          end
        end

        context 'no file path given' do
          subject { described_class.new(nil, 'paperback_test') }

          it 'uploads the files to the root of the bucket' do
            subject.save_all(Pathname.new(fixtures_dir))
            expect(bucket.objects['file1.txt'].read).to eq('I AM FILE 1')
          end
        end

        # Unfortunately theres not .private? method we can call to test this.
        # It's a nice test to have, but if it breaks and causes problems,
        # feel free to delete it.
        it 'sets the file to private' do
          File.write(fixtures_dir + '/file1.txt', 'I AM FILE 1')
          subject.save_all(Pathname.new(fixtures_dir))
          file_permissions = bucket.objects['test/files/file1.txt'].acl
          owner_id = file_permissions.owner.id
          grantee_id = file_permissions.grants.first.grantee.canonical_user_id

          expect(file_permissions.grants.length).to eq(1)
          expect(owner_id).to eq(grantee_id)
        end
      end
    end
  end
end
