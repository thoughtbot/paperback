describe Paperback::Formats::MOBI do
  describe "#extension" do
    it "returns the extension" do
      package = double("package")
      mobi = Paperback::Formats::MOBI.new(package)

      expect(mobi.extension).to eq("mobi")
    end
  end

  describe "#generate" do
    it "depends on EPUB generation" do
      package = double("package").as_null_object
      mobi = Paperback::Formats::MOBI.new(package)
      epub = double("epub").as_null_object
      allow(Paperback::Formats::EPUB).to receive(:new).and_return(epub)
      shell = double("shell").as_null_object
      allow(Thor::Base.shell).to receive(:new).and_return shell

      mobi.generate

      expect(epub).to have_received(:generate)
    end
  end
end
