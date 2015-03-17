describe Paperback::Metadata do
  describe ".book_name" do
    it "tries Git.repository_name first" do
      expected = "foo"
      allow(Paperback::Git).to receive(:repository_name).and_return(expected)

      actual = Paperback::Metadata.book_name

      expect(actual).to eq(expected)
    end

    it "falls back to the current directory name" do
      allow(Paperback::Git).to receive(:repository_name).and_return("")

      actual = Paperback::Metadata.book_name

      expect(actual).to eq("paperback")
    end
  end
end
