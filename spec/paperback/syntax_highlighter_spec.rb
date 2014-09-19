describe Paperback::SyntaxHighlighter do
  describe "#to_ary" do
    before do
      allow(Paperback::Git).to receive(:show_example) { "example" }
    end

    context "with a file_path that is a" do
      context "known file type" do
        it "includes a code fence with a language" do
          syntax_highlighter = Paperback::SyntaxHighlighter.new(
            file_path: "user.rb",
            git_ref: "abc123",
            indentation: "",
            line_range: nil
          )

          actual = syntax_highlighter.to_ary

          expect(actual).to eq(["```ruby", "# user.rb", "example", "```"])
        end
      end

      context "unknown file type" do
        it "includes a code fence with no language" do
          syntax_highlighter = Paperback::SyntaxHighlighter.new(
            file_path: "user.xyz",
            git_ref: "abc123",
            indentation: "",
            line_range: nil
          )

          actual = syntax_highlighter.to_ary

          expect(actual).to eq(["```", "# user.xyz", "example", "```"])
        end
      end
    end
  end
end
