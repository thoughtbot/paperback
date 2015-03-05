describe Paperback::Metadata do
  describe ".book_name" do
    it "tries Git.origin_url first" do
      expected = "http://example.com/foo/bar.git"
      allow(Paperback::Git).to receive(:origin_url).and_return(expected)

      actual = Paperback::Metadata.book_name

      expect(actual).to eq(expected)
    end

    it "falls back to the current directory name" do
      allow(Paperback::Git).to receive(:origin_url).and_return("")

      actual = Paperback::Metadata.book_name

      expect(actual).to eq("paperback")
    end
  end
end
