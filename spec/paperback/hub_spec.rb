require 'spec_helper'

describe Paperback::Hub do
  describe '.checkout' do
    before do
      @pull_request_id = 1
    end

    context 'when cloned over HTTPS' do
      it 'runs hub checkout' do
        command_line = stub_hub_checkout('https://github.com/a/b.git')

        Paperback::Hub.checkout @pull_request_id

        verify_command_line command_line
      end
    end

    context 'when cloned over SSH' do
      it 'runs hub checkout' do
        command_line = stub_hub_checkout('git@github.com:a/b.git')

        Paperback::Hub.checkout @pull_request_id

        verify_command_line command_line
      end
    end

    def stub_hub_checkout(origin_url)
      Paperback::Git.stubs(:origin_url).returns origin_url
      stub_command_line ''
    end

    def verify_command_line(command_line)
      pull_request_url = "https://github.com/a/b/pull/#{@pull_request_id}"

      expect(Cocaine::CommandLine).to have_received(:new)
        .with('hub checkout', pull_request_url)
      expect(command_line).to have_received(:run)
    end
  end
end
