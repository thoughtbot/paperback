require 'spec_helper'
require 'paperback/cli'

describe Paperback::CLI do
  describe '#release' do
    before do
      @s3 = Paperback::Storage::S3.any_instance
      @s3.stubs :save_all
      @cli = Paperback::CLI.new
      @cli.stubs :build_for_release
    end

    context 'when S3 is not configured' do
      it 'does not save to S3' do
        ClimateControl.modify(AWS_ACCESS_KEY_ID: nil) do
          @cli.release
        end

        expect(@s3).to have_received(:save_all).never
      end
    end

    context 'when S3 is configured' do
      it 'saves to S3' do
        ClimateControl.modify(AWS_ACCESS_KEY_ID: 'foo') do
          @cli.release
        end

        expect(@s3).to have_received(:save_all)
      end
    end
  end
end
