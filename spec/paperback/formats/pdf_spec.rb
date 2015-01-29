describe Paperback::Formats::PDF do
  describe "#extension" do
    it "returns the extension" do
      package = double("package")
      pdf = Paperback::Formats::PDF.new(package)

      expect(pdf.extension).to eq("pdf")
    end
  end
end
