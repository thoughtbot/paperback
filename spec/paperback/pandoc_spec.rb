describe Paperback::Pandoc do
  describe "#generate" do
    before do
      package = double(Paperback::Package).as_null_object
      @pandoc = Paperback::Pandoc.new(package)
    end

    context "with an unsupported version of pandoc" do
      it "raises an error" do
        stub_command_line "pandoc 1.11.0"

        expect { @pandoc.generate(:foo, ["bar"]) }.to raise_error(RuntimeError)
      end
    end
  end
end
