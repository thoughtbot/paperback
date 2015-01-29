describe Paperback::Formats::EPUB do
  describe "#extension" do
    it "returns the extension" do
      package = double("package")
      epub = Paperback::Formats::EPUB.new(package)

      expect(epub.extension).to eq("epub")
    end
  end
end
