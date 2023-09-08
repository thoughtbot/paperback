describe Paperback::Pandoc do
  describe "#generate" do
    before do
      allow(Dir).to receive(:chdir).and_yield
      allow(Paperback).to receive(:target_root).and_return("")

      @package = double(Paperback::Package, target: "")
      @pandoc = Paperback::Pandoc.new(@package)
    end

    context "with an unsupported version of pandoc" do
      it "raises an error" do
        stub_pandoc("--version", "pandoc 1.11.0")

        expect { @pandoc.generate(:foo, ["bar"]) }.to raise_error(RuntimeError)
      end
    end

    it "adds --smart and --output=format to the given arguments" do
      stub_pandoc("--version", "pandoc 1.11.1")
      stub_pandoc("--foo --bar --smart --output=html ", "")
      allow(@package).to receive(:target).with("format").and_return("html")

      @pandoc.generate("format", %w[--foo --bar])

      expect_pandoc("--foo --bar --smart --output=html ")
    end
  end

  def stub_pandoc(arguments, output)
    command_line = double(run: output)

    allow(Terrapin::CommandLine).to receive(:new)
      .with("pandoc", arguments)
      .and_return(command_line)
  end

  def expect_pandoc(arguments)
    expect(Terrapin::CommandLine).to have_received(:new)
      .with("pandoc", arguments)
  end
end
