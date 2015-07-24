describe Paperback::PandocGenerator do
  describe "#generate" do
    before do
      allow(Dir).to receive(:chdir).and_yield
      allow(Paperback).to receive(:target_root).and_return("")

      @package = double(Paperback::Package, target: "")
      @pandoc = Paperback::PandocGenerator.new(@package)
    end

    it "adds --smart and --output=format to the given arguments" do
      stub_pandoc_runner("--foo --bar --smart --output=html ", "")
      allow(@package).to receive(:target).with("format").and_return("html")

      @pandoc.generate("format", %w(--foo --bar))

      expect_pandoc_runner("--foo --bar --smart --output=html ")
    end
  end

  def stub_pandoc_runner(arguments, output)
    pandoc_runner = double(run: output)

    allow(Paperback::PandocRunner).to receive(:new)
      .with(arguments)
      .and_return(pandoc_runner)
  end

  def expect_pandoc_runner(arguments)
    expect(Paperback::PandocRunner).to have_received(:new)
      .with(arguments)
  end
end
