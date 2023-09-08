describe Paperback::Hub do
  describe ".checkout" do
    it "runs hub checkout" do
      command_line = stub_command_line
      pull_request_url = "https://github.com/user/project/pull/1"

      Paperback::Hub.checkout pull_request_url

      expect(Terrapin::CommandLine).to have_received(:new)
        .with("hub checkout", pull_request_url)
      expect(command_line).to have_received(:run)
    end
  end
end
