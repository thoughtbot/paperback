describe Paperback::Formats::HTML do
  describe "#extension" do
    it "returns the extension" do
      package = double("package")
      html = Paperback::Formats::HTML.new(package)

      expect(html.extension).to eq("html")
    end
  end
end
