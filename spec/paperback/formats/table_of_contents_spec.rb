describe Paperback::Formats::TableOfContents do
  describe "#extension" do
    it "returns the extension" do
      package = double("package")
      table_of_contents = Paperback::Formats::TableOfContents.new(package)

      expect(table_of_contents.extension).to eq("toc.html")
    end
  end
end
