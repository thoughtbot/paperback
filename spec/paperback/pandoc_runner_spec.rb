describe Paperback::PandocRunner do
  describe "#run" do
    before do
      allow(Dir).to receive(:chdir).and_yield
      allow(Paperback).to receive(:target_root).and_return("")
    end

    context "with an unsupported version of pandoc" do
      it "raises an error" do
        stub_pandoc("--version", "pandoc 1.11.0")

        expect {
          Paperback::PandocRunner.new("--help").run
        }.to raise_error(RuntimeError)
      end
    end

    it "runs pandoc with the given command" do
      stub_pandoc("--version", "pandoc 1.11.1")
      stub_pandoc("--to=html5", "")

      pandoc_runner = Paperback::PandocRunner.new("--to=html5")
      pandoc_runner.run

      expect_pandoc("--to=html5")
    end
  end

  def stub_pandoc(arguments, output)
    command_line = double(run: output)

    allow(Cocaine::CommandLine).to receive(:new)
      .with("pandoc", arguments)
      .and_return(command_line)
  end

  def expect_pandoc(arguments)
    expect(Cocaine::CommandLine).to have_received(:new)
      .with("pandoc", arguments)
  end
end
