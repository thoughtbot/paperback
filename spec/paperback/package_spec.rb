describe Paperback::Package do
  describe "#source" do
    it "returns its markdown source" do
      package = Paperback::Package.new("franklin")

      expect(package.source).to eq("franklin.md")
    end
  end

  describe "#target" do
    it "returns the target file for the given format" do
      stub_repository_name "adventure"
      package = Paperback::Package.new("franklin")

      basename = package.target(:pdf).basename.to_s

      expect(basename).to eq("adventure.pdf")
    end

    it "includes the suffix when given" do
      stub_repository_name "adventure"
      package = Paperback::Package.new("franklin", suffix: "-junior")

      basename = package.target(:pdf).basename.to_s

      expect(basename).to eq("adventure-junior.pdf")
    end

    def stub_repository_name(name)
      allow(Paperback::Git).to receive(:repository_name) { name }
    end
  end
end
